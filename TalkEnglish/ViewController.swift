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
    
    var bombSoundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// IBAction - button click event
extension ViewController {
    @IBAction func playButtonClicked(_ sender: Any) {
        playDemo("example.mp3")
    }
}

// Play MP3
extension ViewController {
    func playDemo(_ fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
}
