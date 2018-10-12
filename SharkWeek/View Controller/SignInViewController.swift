//
//  SignInViewController.swift
//  SharkWeek
//
//  Created by Cody on 10/11/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit
import AVFoundation

class SignInViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(string: Bundle.main.path(forResource: "Sample", ofType: "mp3")!)!)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        }catch{
            print(error)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.pause()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
