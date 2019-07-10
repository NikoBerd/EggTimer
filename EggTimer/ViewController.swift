//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation



class ViewController: UIViewController {
    
  var player: AVAudioPlayer!
  let eggTimes = [
                    "Soft": 300,
                    "Medium": 420,
                    "Hard": 720
                 ]
  var secondsRemaining = 60
  var timer = Timer()
  var totalTime = 0
  var secondsPassed = 0
  
  
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    
    
    timer.invalidate()
    let hardness = sender.currentTitle!
    totalTime = eggTimes[hardness]!
    
    progressBar.progress = 0.0
    secondsPassed = 0
    titleLabel.text = hardness
    
    secondsRemaining = eggTimes[hardness]!
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
  }
  @objc func updateTimer(){
    if secondsPassed < totalTime {
      
      secondsPassed += 1
      let percentageProgress = Float(secondsPassed) / Float(totalTime)
      progressBar.progress = percentageProgress
      
    }else{
      timer.invalidate()
      titleLabel.text = "DONE"
      
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
      }

    }
  }
}
