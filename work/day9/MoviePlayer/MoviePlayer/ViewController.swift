//
//  ViewController.swift
//  MoviePlayer
//
//  Created by CSMAC08 on 2023/07/05.
// http://cooling.dongduk.ac.kr:8080/data/puppy.mp4

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let url = NSURL(string: "http://cooling.dongduk.ac.kr:8080/data/puppy.mp4")
    
        playVideo(url: url!)
    }
    
    private func playVideo(url: NSURL) {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

