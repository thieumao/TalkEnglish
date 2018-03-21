//
//  ViewController.swift
//  TalkEnglish
//
//  Created by Thieu Mao on 12/13/17.
//  Copyright © 2017 thieumao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var myPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// IBAction - button click event
extension ViewController {
    @IBAction func playButtonClicked(_ sender: Any) {
        playAudio("example.mp3")
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        pauseAudio()
    }
    
    @IBAction func replayButtonClicked(_ sender: Any) {
        replayAudio()
    }
}

// Play MP3
extension ViewController {
    func playAudio(_ fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            myPlayer = try AVAudioPlayer(contentsOf: url)
            myPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func pauseAudio() {
        myPlayer?.pause()
    }
    
    func replayAudio(){
        myPlayer?.play()
    }
}
