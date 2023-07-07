//
//  ViewController.swift
//  pageControlTest
//
//  Created by CSMAC08 on 2023/06/28.
//

import UIKit

var images = [ "01.png", "02.png", "03.png" ]
class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count
        pageControl.currentPage = currentPage
        
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.purple
        
        imgView.image = UIImage(named: images[0])
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
    @IBAction func pageChange(_ sender: UIPageControl) {
        currentPage = pageControl.currentPage
        imgView.image = UIImage(named: images[currentPage])
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            imgView.image = UIImage(named: images[currentPage])
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if (pageControl.currentPage != images.count - 1) {
                    currentPage += 1
                    imgView.image = UIImage(named: images[currentPage])
                    pageControl.currentPage = currentPage
                }
            case UISwipeGestureRecognizer.Direction.right:
                if (pageControl.currentPage != 0) {
                    currentPage -= 1
                    imgView.image = UIImage(named: images[currentPage])
                    pageControl.currentPage = currentPage
                }
            default:
                break
            }
        }
    }
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
}

