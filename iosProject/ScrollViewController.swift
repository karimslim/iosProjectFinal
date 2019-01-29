//
//  ScrollViewController.swift
//  iosProject
//
//  Created by Slim Karim on 13/04/2018.
//  Copyright © 2018 Slim Karim. All rights reserved.
//

import UIKit
import AVFoundation

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var welcomeMusic : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "welcomeMusic.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        let delay = max(0.0, 7.0)
        
        do {
            welcomeMusic = try AVAudioPlayer(contentsOf: url)
            welcomeMusic?.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.welcomeMusic?.stop()
                
            }
        } catch {
            // couldn't load file :(
        }
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
        textView.textAlignment = .center
        textView.text = "World Cup Russia 2018"
        textView.textColor = UIColor.white
        self.startButton.layer.cornerRadius = 4.0
        //3
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "fifa1")
       
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "fifa2")
       
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "fifa3")
      
        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgFour.image = UIImage(named: "fifa4")
        
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 4, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        startButton.setTitleColor(.white, for: .normal)
       
        // Change the text accordingly
        if Int(currentPage) == 0{
            textView.text = "World Cup Russia 2018"
           
            
        }else if Int(currentPage) == 1{
            textView.text = "Who is the winner ?"
        }else if Int(currentPage) == 2{
            textView.text = "2018 FIFA World Cup Tickets: Official Partner"
        }else{
            textView.text = "Russia World Cup 2018"
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.startButton.alpha = 1.0
                
                
            })
        }
    }
    
}


