//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Joseph Chamochumbi on 2022-10-05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopRecordingButton.isEnabled = false
    }
        
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording"
        recordingButton.isEnabled = false
        stopRecordingButton.isEnabled = true
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Tap to record"
        recordingButton.isEnabled = true
        stopRecordingButton.isEnabled = false
    }
}
