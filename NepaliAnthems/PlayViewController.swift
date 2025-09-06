//
//  PlayViewController.swift
//  NepaliAnthems
//
//  Created by IMCS on 10/24/19.
//  Copyright © 2019 IMCS. All rights reserved.
//

import UIKit
import AVFoundation
import FLAnimatedImage

class PlayViewController: UIViewController {
    
    var songName : String = ""
    var player = AVPlayer()
    
    var isPlaying : Bool = true
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var animatedFlag: FLAnimatedImageView!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var audioSlider: UISlider!
    
    @IBAction func audioSliderChange(_ sender: UISlider) {
        print(audioSlider.value)
        if let duration = player.currentItem?.duration{
            let totalSeconds = Float(CMTimeGetSeconds(duration))
            let value = audioSlider.value *  totalSeconds
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            player.seek(to: seekTime, completionHandler : {(completedSeek)
                in
                
            })
        }
    }
    
    
    @IBAction func playPauseButtonAction(_ sender: UIButton) {
        
        if isPlaying {
            isPlaying = false
            player.pause()
            playPauseButton.setImage(UIImage(named: "play.png"), for: .normal)
        } else {
            isPlaying = true
            player.play()
            playPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        }
        
        
    }

    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
        player.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path1 : String = Bundle.main.path(forResource: "flag", ofType: "jpeg")!
        let url = URL(fileURLWithPath: path1)
        let gifData = try? Data(contentsOf: url)
        let imageData1 = try? FLAnimatedImage(animatedGIFData: gifData)
        animatedFlag.animatedImage = imageData1
        playSong()
        TitleLabel.text = songName
        UIApplication.shared.isIdleTimerDisabled = true
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(PlayViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let interval = CMTimeMake(value: 1, timescale: 4) // 0.25 (1/4) seconds
       
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            //print(time)
            
            let time = Int(CMTimeGetSeconds((self?.player.currentTime())!)) 
            
            if let totalTime = self?.player.currentItem?.duration {
                
           
                
            let totalSeconds = Float(CMTimeGetSeconds(totalTime))
                guard !(totalSeconds.isNaN || totalSeconds.isInfinite) else {
                               return
                }
                print(totalSeconds)
                print(Float(time)/totalSeconds)
                self?.audioSlider.value = Float(time)/Float(totalSeconds)
            }
            
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            
            self?.TimeLabel.text = String(format:"%02i:%02i", minutes, seconds)
            
            print(time)
//            NSUInteger durationSeconds = (long)CMTimeGetSeconds(interval);
//            NSUInteger hours = floor(dTotalSeconds / 3600);
//            NSUInteger minutes = floor(durationSeconds % 3600 / 60);
//            NSUInteger seconds = floor(durationSeconds % 3600 % 60);
        }
       
        // Do any additional setup after loading the view.
    }
    
    func playSong() {
        var audioPath = Bundle.main.path(forResource: songName, ofType: "mp3")
        
        
        do {
            player = try AVPlayer (url: URL(fileURLWithPath: audioPath!))
                //NameofSong.text = songsName[currentSong]
        } catch {
            print("Error Page")
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }
        catch {
           // report for an error
        }
        
        player.play()
    }
    
    @IBAction func volumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
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
