//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Joseph Chamochumbi on 2022-10-05.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(.idle)
        recordingButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(.recording)

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings:[:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(.idle)
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    enum RecordingState {
        case idle, recording
    }
    
    func configureUI(_ recordingState: RecordingState) {
        switch (recordingState) {
        case .idle:
            recordingLabel.text = "Tap to record"
            recordingButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        case .recording:
            recordingLabel.text = "Recording"
            recordingButton.isEnabled = false
            stopRecordingButton.isEnabled = true
        }
    }
}
