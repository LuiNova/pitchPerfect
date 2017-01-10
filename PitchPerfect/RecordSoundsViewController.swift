//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Torres, Luis on 1/6/17.
//  Copyright © 2017 Torres, Luis. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate

class RecordSoundsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: Properties
    var audioRecorder: AVAudioRecorder!
    
    // MARK: Labels
    struct Labels {
        static let Record = "Tap to Record"
        static let Recording = "Recording in Progress"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func setUIState(isRecording:Bool) {
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
        recordingLabel.text = isRecording ? Labels.Recording : Labels.Record
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        setUIState(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        setUIState(isRecording: false)

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

