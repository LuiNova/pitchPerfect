//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Torres, Luis on 1/6/17.
//  Copyright © 2017 Torres, Luis. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - PlaySoundsViewController: UIViewController

class PlaySoundsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var innerStackView1: UIStackView!
    @IBOutlet weak var innerStackView2: UIStackView!
    @IBOutlet weak var innerStackView3: UIStackView!
    @IBOutlet weak var innerStackView4: UIStackView!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Properties
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpAspectFitButtons()
        configureUI(.notPlaying)
    }
    
    // override this function to make sure when rotated to landscape, the buttons are not squeezed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) -> Void in
            let orientation = UIApplication.shared.statusBarOrientation
            
            if orientation.isPortrait{
                self.outerStackView.axis = .vertical
                self.setInnerStackViewsAxis(.horizontal)
            } else {
                self.outerStackView.axis = .horizontal
                self.setInnerStackViewsAxis(.vertical)
            }
        }, completion: nil)
    }
    
    // helper function: all the innerStackView should share the same style, configure them together
    func setInnerStackViewsAxis(_ axisStyle: UILayoutConstraintAxis)  {
        innerStackView1.axis = axisStyle
        innerStackView2.axis = axisStyle
        innerStackView3.axis = axisStyle
        innerStackView4.axis = axisStyle
    }
    
    func setUpAspectFitButtons() {
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
    }
    
    // MARK: Actions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
}
