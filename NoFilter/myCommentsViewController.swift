//
//  myCommentsViewController.swift
//  HomeFeature Tab
//
//  Created by harpreet singh on 2017-03-05.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit
import AVFoundation
class myCommentsViewController: UIViewController,AVAudioPlayerDelegate,AVAudioRecorderDelegate {

    var sec=10
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recButn: UIButton!
    @IBOutlet weak var popupView: UIView!
    var timer=Timer()
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var presstoRecord: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        popupView.layer.cornerRadius=10
        popupView.layer.masksToBounds=true
        presstoRecord.layer.cornerRadius=10
        playBtn.isEnabled=false
        //showing seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myCommentsViewController.counter), userInfo: nil, repeats: true)
        //implementing audio recorder
        
        //file path to save file
        let fileMgr = FileManager.default                                     //
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,                  //  6th step
            in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")    //
        
        //recorder settings
        let recordSettings =                                                  //
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,           //
                AVEncoderBitRateKey: 16,                                         //   7th step
                AVNumberOfChannelsKey: 2,                                        //
                AVSampleRateKey: 44100.0] as [String : Any]                      //
        //creating session for recording
        let audioSession = AVAudioSession.sharedInstance()                    //8th step
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
    }
    
    func counter()
    {
        sec-=1
        secLabel.text=String(sec)
        if(sec==0)
        {
            timer.invalidate()
             dismiss(animated: true, completion: nil)
            
        }
    }

    @IBAction func recordBtn(_ sender: UIButton) {
        /*popupView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 9, options: .allowUserInteraction, animations:
            {
                self.popupView.transform=CGAffineTransform.identity
        }, completion: nil)
        dismiss(animated: true, completion: nil)  */
        
        if(recButn.titleLabel?.text=="Record")
        {
            recButn.setTitle("Stop", for: .normal)
            if audioRecorder?.isRecording == false {
              
                audioRecorder?.record()
            }
            
        }
        else if(recButn.titleLabel?.text=="Stop"){
            if audioRecorder?.isRecording == true {
                audioRecorder?.stop()
                //recButn.setTitle("Record", for: .normal)
                  dismiss(animated: true, completion: nil)
                playBtn.isEnabled=true
            } else {
                audioPlayer?.stop()
              //  playBtn.isEnabled=true
            }
           dismiss(animated: true, completion: nil)
            
        }
        
    }
    @IBAction func playButton(_ sender: UIButton) {
        
        if audioRecorder?.isRecording == false {
           
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }

    }

}
