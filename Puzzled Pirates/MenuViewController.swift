//
//  FirstViewController.swift
//  Puzzled Pirates
//
//  Created by Markus Barrow on 11/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import UIKit
import AudioKit

class MenuViewController: UIViewController {
    
    let mixer: AKMixer
    var music: AKAudioPlayer
    var soundEffect: AKAudioPlayer
    
    let menuMusic = try!AKAudioFile(readFileName: "menutheme.mp3", baseDir: .resources)
    let buttonSound = try!AKAudioFile(readFileName: "button1.wav", baseDir: .resources)

    
    required init?(coder aDecoder: NSCoder) {
        self.music = try! AKAudioPlayer(file: menuMusic)
        self.music.volume = 0.5
        self.soundEffect = try! AKAudioPlayer(file: buttonSound)
        self.soundEffect.volume = 1.5

        self.mixer = AKMixer(music, soundEffect)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        music.looping = true
        AudioKit.output = mixer
        
        do {
            try AudioKit.start()
        } catch {
            print("AudioKit failed to start")
        }
        
        if(!music.isPlaying) {
            music.start()
        }
    }


    @IBAction func startButton(_ sender: UIButton) {
        soundEffect.start()
    }
    
    
    @IBAction func musicToggle(_ sender: UIButton) {
        
        if(music.isPlaying) {
            music.pause()
            sender.setTitle("Music is: OFF", for: .normal)
        } else {
            music.start()
            sender.setTitle("Music is: ON", for: .normal)
        }
        
    }
    
    @IBAction func volumeSlider(_ sender: UISlider) {
        let volume = Double(sender.value)
        music.volume = volume
    }
    
}

