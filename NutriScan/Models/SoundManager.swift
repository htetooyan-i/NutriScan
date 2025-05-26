//
//  SoundManager.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 3/5/25.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    var player: AVAudioPlayer?

    func playClickSound() {
        guard let url = Bundle.main.url(forResource: "save_sound", withExtension: "m4a") else { return }
        print("Sound file found at: \(url.path)")
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("Playing sound!")
        } catch {
            print("Error playing sound: \(error)")
        }
    }
}
