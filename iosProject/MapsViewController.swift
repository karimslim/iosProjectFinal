//
//  MapsViewController.swift
//  iosProject
//
//  Created by Slim Karim on 11/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import MapKit


class MapsViewController: UIViewController, MKMapViewDelegate {
     
    @IBOutlet weak var mapView: MKMapView!
    
    var longitude = Int()
    var latitude = Int()
    var nameStadium = String()
    var nameCountry = String()
    var locationManager: CLLocationManager!
    var names:[String]!
    var images:[UIImage]!
    var descriptions:[String]!
    var coordinates:[Any]!
    var currentRestaurantIndex: Int = 0
   
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Some restaurants in London
        names = ["lekaterinbourg Arena", "Kazan Arena", "Otkrytie Arena", "Loujniki stadium", "Saint Petersbourg Arena", "Spartak Arena", "Fisht stadium", "Volgograd Arena","Nijni Novgorod","Rostov Arena","Samara Arena","Mordovia Arena","Baltika Arena"]
        
        // Restaurants' images to show in the pin callout
        images = [UIImage(named: "s1")!, UIImage(named: "s2")!, UIImage(named: "s3")!, UIImage(named: "s4")!, UIImage(named: "s5")!, UIImage(named: "s6")!, UIImage(named: "s7")!, UIImage(named: "s8")!,UIImage(named: "s9")!,UIImage(named: "s10")!,UIImage(named: "s11")!,UIImage(named: "s12")!,UIImage(named: "s13")!]
        
        // Latitudes, Longitudes
        coordinates = [
            [56.00, 60.00],
            [55.00 , 49.00],
            [55.00 , 37.00],
            [55.00 , 37.00],
            [60.00 , 30.00],
            [55.00 , 37.00],
            [43.00 , 40.00],
            [49.00 , 44.00],
            [56.00 , 44.00],
            [47.00 , 39.00],
            [53.00 , 50.00],
            [54.00 , 45.00],
            [54.00 , 20.00]
            
        ]
        
        currentRestaurantIndex = 0
   
        // Ask for user permission to access location infos
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        // Show the user current location
        mapView.showsUserLocation = true
        mapView.delegate = self
       
    }
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If annotation is not of type RestaurantAnnotation (MKUserLocation types for instance), return nil
        if !(annotation is StadiumAnnotation){
            return nil
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        
        let restaurantAnnotation = annotation as! StadiumAnnotation
        annotationView?.detailCalloutAccessoryView = UIImageView(image: restaurantAnnotation.image)
        
        // Left Accessory
        let leftAccessory = UILabel(frame: CGRect(x: 0,y: 0,width: 50,height: 30))
        leftAccessory.text = restaurantAnnotation.eta
        leftAccessory.font = UIFont(name: "Verdana", size: 14)
        annotationView?.leftCalloutAccessoryView = leftAccessory
        
        // Right accessory view
        let image = UIImage(named: "bus.png")
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(image, for: UIControlState())
        annotationView?.rightCalloutAccessoryView = button
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
        // The map item is the restaurant location
        let mapItem = MKMapItem(placemark: placemark)
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    
    //SHowing all stadiums
    @IBAction func nextStadium(_ sender: Any) {
        // 1
        if currentRestaurantIndex > names.count - 1{
            currentRestaurantIndex = 0
        }
        // 2
        let coordinate = coordinates[currentRestaurantIndex] as! [Double]
        let latitude: Double   = coordinate[0]
        let longitude: Double  = coordinate[1]
        let locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        var point = StadiumAnnotation(coordinate: locationCoordinates)
        point.title = names[currentRestaurantIndex]
        point.image = images[currentRestaurantIndex]
        // 3
        // Calculate Transit ETA Request
        let request = MKDirectionsRequest()
        /* Source MKMapItem */
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate, addressDictionary: nil))
        request.source = sourceItem
        /* Destination MKMapItem */
        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: locationCoordinates, addressDictionary: nil))
        request.destination = destinationItem
        request.requestsAlternateRoutes = false
        // Looking for Transit directions, set the type to Transit
        request.transportType = .transit
        // Center the map region around the restaurant coordinates
        mapView.setCenter(locationCoordinates, animated: true)
        // You use the MKDirectionsRequest object constructed above to initialise an MKDirections object
        let directions = MKDirections(request: request)
        directions.calculateETA { (etaResponse, error) -> Void in
            if let error = error {
                print("Error while requesting ETA : \(error.localizedDescription)")
                point.eta = error.localizedDescription
            }else{
                point.eta = "\(Int((etaResponse?.expectedTravelTime)!/60)) min"
            }
            // 4
            var isExist = false
            for annotation in self.mapView.annotations{
                if annotation.coordinate.longitude == point.coordinate.longitude && annotation.coordinate.latitude == point.coordinate.latitude{
                    isExist = true
                    point = annotation as! StadiumAnnotation
                }
            }
            if !isExist{
                self.mapView.addAnnotation(point)
            }
            self.mapView.selectAnnotation(point, animated: true)
            self.currentRestaurantIndex += 1
        }
    }

}
