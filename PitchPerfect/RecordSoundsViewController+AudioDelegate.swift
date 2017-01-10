//
//  RecordSoundsViewController+AudioDelegate.swift
//  PitchPerfect
//
//  Created by Torres, Luis on 1/9/17.
//  Copyright © 2017 Torres, Luis. All rights reserved.
//

import UIKit
import AVFoundation

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not Successful")
        }
    }
}
