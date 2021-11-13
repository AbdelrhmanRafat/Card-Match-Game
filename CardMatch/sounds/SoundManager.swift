//
//  SoundManager.swift
//  CardMatch
//
//  Created by Macbook on 11/12/2020.
//

import Foundation
import AVFoundation

class soundManager{
    
    var audioPlayer : AVAudioPlayer?
    enum soundEffect {
        case flip
        case math
        case nomatch
        case shuffle
    }
    
    func playSound(effect: soundEffect) {
        var soundfileName = ""
        switch effect {
        case .flip:
            soundfileName = "cardflip"
        case .math:
            soundfileName = "dingcorrect"
        case .nomatch:
            soundfileName = "dingwrong"
        case .shuffle:
            soundfileName = "shuffle"
        }
        let bundlePath = Bundle.main.path(forResource: soundfileName, ofType: ".wav")
        guard bundlePath != nil else {
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        do{
         audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        catch{
            print("couldn't creat an audio player")
            return
        }
}
}
