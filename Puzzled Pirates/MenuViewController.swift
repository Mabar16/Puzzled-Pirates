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
    let menuMusic = try!AKAudioFile(readFileName: "menutheme.mp3", baseDir: .resources)
    var music: AKAudioPlayer
    
    required init?(coder aDecoder: NSCoder) {
        self.music = try! AKAudioPlayer(file: menuMusic)
        self.mixer = AKMixer(music)
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


}

