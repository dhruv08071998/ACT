//
//  PlayerViewController.swift
//  MyMusic
//
//  Created by Afraz Siddiqui on 4/3/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import AVFoundation
import UIKit
import SVProgressHUD
import MediaPlayer

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    public var position: Int = 0
    public var songs: [Song] = []
    var slider = UISlider()
    let nextButton = UIButton()
    let backButton = UIButton()
    let closeButton = UIButton()
    let commandCenter = MPRemoteCommandCenter.shared()
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    // User Interface elements
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    private var maximumTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()
    private let updatedTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()
    let playPauseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRemoteTransportControls()
        setupNotifications()
        bgView.isHidden = true
        
    }
    
    func loadngView() {
        bgView.isHidden = false
        SVProgressHUD.show()
    }
    
    func dismissView() {
        bgView.isHidden = true
        SVProgressHUD.dismiss()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            if NetworkReachabilityManager()!.isReachable {
                configure()
    
            } else  {
                SVProgressHUD.dismiss()
                showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
            }
        }
    }
    
    @objc func onTimerTick() {
        if !player!.isPlaying {
            return
        }
        slider.value = Float(player!.currentTime)
    }
    
    @objc func updateTime() {
        let currentTime = Int(player!.currentTime)
        let duration = Int(player!.duration)
        let minutes = currentTime/60
        var seconds = currentTime - minutes / 60
        if seconds > 60 {
            seconds = seconds % 60
        }
        updatedTimeLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    func configure() {
        // set up player
        let song = songs[position]
        artistNameLabel.isHidden = true
        let urlString = song.trackName
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            let soundData = try Data(contentsOf: URL(string: urlString)!)
            player = try AVAudioPlayer(data: soundData)
            guard let player = player else {
                print("player is nil")
                return
            }
            player.volume = 1
            player.delegate = self
            player.play()
            setupNowPlaying()
            SVProgressHUD.dismiss()
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerTick), userInfo: nil, repeats: true)
        }
        catch {
            print("error occurred")
        }
        //close Button
        closeButton.setBackgroundImage(UIImage(named: "Group 97"), for: .normal)
        // set up user interface elements
        // album cover
        updatedTimeLabel.text = "00:00"
        albumImageView.frame = CGRect(x: 10,
                                      y: 50,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        albumImageView.layer.cornerRadius = 12
        albumImageView.layer.borderWidth = 1
        albumImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        albumImageView.contentMode = .scaleToFill
        albumImageView.clipsToBounds = true
        holder.addSubview(albumImageView)
        
        // Labels: Song name, album, artist
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 45,
                                     width: holder.frame.size.width-20,
                                     height: 70)
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" ||  UIDevice().type.rawValue == "iPhone 7 Plus" ||  UIDevice().type.rawValue == "iPhone 8 Plus" ||  UIDevice().type.rawValue == "iPhone SE (2nd generation)" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            albumNameLabel.frame = CGRect(x: 10,
                                          y: albumImageView.frame.size.height + 50, //iphone = +70
                                          width: holder.frame.size.width-20,
                                          height: 70)
        } else {
            albumNameLabel.frame = CGRect(x: 10,
                                          y: albumImageView.frame.size.height + 10 + 80,
                                          width: holder.frame.size.width-20,
                                          height: 70)
        }
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 10 + 140,
                                       width: holder.frame.size.width-20,
                                       height: 70)
        
        //songNameLabel.text = song.name
        albumNameLabel.text =  song.name
//        artistNameLabel.text = song.artistName
        songNameLabel.isHidden = true
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        holder.addSubview(maximumTimeLabel)
        holder.addSubview(updatedTimeLabel)
        
        // Player controls
        
        // Frame
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 70
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" ||  UIDevice().type.rawValue == "iPhone 7 Plus" ||  UIDevice().type.rawValue == "iPhone 8 Plus" ||  UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                           y: yPosition-100,
                                           width: size-20,
                                           height: size-20) // iphone 11  = -30
            
            nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                      y: yPosition-100,
                                      width: size-20,
                                      height: size-20)
            
            backButton.frame = CGRect(x: 20,
                                      y: yPosition-100,
                                      width: size-20,
                                      height: size-20)
            closeButton.frame = CGRect(x: holder.frame.size.width - size + 20,
                                       y: yPosition-590,
                                       width: 40,
                                       height: 40)
        } else {
            playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                           y: yPosition-30,
                                           width: size,
                                           height: size) // iphone 11  = -30
            
            nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                      y: yPosition-30,
                                      width: size,
                                      height: size)
            closeButton.frame = CGRect(x: holder.frame.size.width - size + 20,
                                       y: yPosition-630,
                                       width: 40,
                                       height: 40)
            
            backButton.frame = CGRect(x: 20,
                                      y: yPosition-30,
                                      width: size,
                                      height: size)
        }
        holder.addSubview(closeButton)
        var x = 50
        if UIDevice().type.rawValue == "iPhone 7 Plus" ||  UIDevice().type.rawValue == "iPhone 8 Plus" {
            x = 70
        } else if UIDevice().type.rawValue == "iPhone 7" ||  UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone SE (2nd generation)" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"  {
            x = 60
        }
        updatedTimeLabel.frame = CGRect(x: 10,
                                        y: holder.frame.size.height - CGFloat(x),
                                        width: size,
                                        height: size)
        maximumTimeLabel.frame =  CGRect(x: holder.frame.size.width - size - 10,
                                         y: holder.frame.size.height - CGFloat(x),
                                         width: size,
                                         height: size)
        
        // Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        // Styling
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        closeButton.tintColor = .black
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        // slider
        if UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" {
            slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-100,
                                            width: holder.frame.size.width-40,
                                            height: 50))
        } else {
            slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-80,
                                            width: holder.frame.size.width-40,
                                            height: 50))
        }
        slider.value = 0
        slider.maximumValue = Float(player!.duration)
        let maxTime = Int(player!.duration)
        let minutes = maxTime/60
        var seconds = maxTime - minutes / 60
        if seconds > 60 {
            seconds = seconds % 60
        }
        maximumTimeLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        if position  == 0{
            backButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2019493466)
            commandCenter.previousTrackCommand.isEnabled = false
        }
        if position  == (songs.count - 1){
            nextButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2019493466)
            commandCenter.nextTrackCommand.isEnabled = false
        }
    }
    
    
    
    @objc func didTapBackButton() {
        if position > 0 {
            commandCenter.previousTrackCommand.isEnabled = true
            commandCenter.nextTrackCommand.isEnabled = true
            SVProgressHUD.show()
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            if NetworkReachabilityManager()!.isReachable {
                updateDBAccordingToMeditations()
                configure()
                updateNowPlaying(isPause: false)
            } else  {
                showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
                self.dismiss(animated: true, completion: nil)
                SVProgressHUD.dismiss()
            }
        }
        if position  == 0{
            backButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2019493466)
            commandCenter.previousTrackCommand.isEnabled = false
        }
    }
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            commandCenter.nextTrackCommand.isEnabled = true
            commandCenter.previousTrackCommand.isEnabled = true
            SVProgressHUD.show()
            position = position + 1
            player?.stop()
            updateDBAccordingToMeditations()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            if NetworkReachabilityManager()!.isReachable {
                updateDBAccordingToMeditations()
                configure()
            } else  {
                showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
                self.dismiss(animated: true, completion: nil)
                SVProgressHUD.dismiss()
            }
        }
        
        if position  == (songs.count - 1){
            nextButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2019493466)
            commandCenter.nextTrackCommand.isEnabled = false
        }
    }
    
    func updateDBAccordingToMeditations() {
        meditationInfo.endTime = Int(Date().timeIntervalSince1970)
        updateAndSetMeditationInDB(endTime: meditationInfo.endTime!, startTime: meditationInfo.startTime!, meditationTitle: meditationInfo.meditationTitle!, meditationId: meditationInfo.meditationId!)
        meditationInfo.startTime = Int(Date().timeIntervalSince1970)
        meditationInfo.meditationId = songs[position].id
        meditationInfo.meditationTitle = songs[position].name
    }
    
    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true {
            // pause
            player?.pause()
            // show play button
            updateNowPlaying(isPause: true)
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            // shrink image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 40,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
            })
        }
        else {
            // play
            player?.play()
            updateNowPlaying(isPause: false)
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            // increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 50,
                                                   width: self.holder.frame.size.width-20,
                                                   height: self.holder.frame.size.width-20)
            })
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.stop()
        player?.currentTime = TimeInterval(value)
        player?.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        holder.backgroundColor = .clear
        changeBackground(view: self.view)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
        meditationInfo.endTime = Int(Date().timeIntervalSince1970)
        updateAndSetMeditationInDB(endTime: meditationInfo.endTime!, startTime: meditationInfo.startTime!, meditationTitle: meditationInfo.meditationTitle!, meditationId: meditationInfo.meditationId!)
        
    }
    
}

extension PlayerViewController :AVAudioPlayerDelegate {
    func setupRemoteTransportControls() {
      // Add handler for Play Command
      commandCenter.playCommand.addTarget { [unowned self] event in
        print("Play command - is playing: \(self.player!.isPlaying)")
        if !self.player!.isPlaying {
            didTapPlayPauseButton()
          return .success
        }
        return .commandFailed
      }
      
      // Add handler for Pause Command
      commandCenter.pauseCommand.addTarget { [unowned self] event in
        print("Pause command - is playing: \(self.player!.isPlaying)")
        if self.player!.isPlaying {
            didTapPlayPauseButton()
          return .success
        }
        return .commandFailed
      }
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
          print("next command - is playing: \(self.player!.isPlaying)")
          if self.player!.isPlaying || self.player!.isPlaying  {
              didTapNextButton()
            return .success
          }
          return .commandFailed
        }
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
          print("next command - is playing: \(self.player!.isPlaying)")
          if self.player!.isPlaying || self.player!.isPlaying  {
              didTapBackButton()
            return .success
          }
          return .commandFailed
        }
    }
    func setupNowPlaying() {
      // Define Now Playing Info
      var nowPlayingInfo = [String : Any]()
        let song = songs[position]
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.name
      
        if let image = UIImage(named: song.imageName) {
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
          return image
        }
      }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate
      
      // Set the metadata
      MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func updateNowPlaying(isPause: Bool) {
      // Define Now Playing Info
      var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo!
      
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
      nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPause ? 0 : 1
      
      // Set the metadata
      MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func setupNotifications() {
      let notificationCenter = NotificationCenter.default
      notificationCenter.addObserver(self,
                                     selector: #selector(handleInterruption),
                                     name: AVAudioSession.interruptionNotification,
                                     object: nil)
      notificationCenter.addObserver(self,
                                     selector: #selector(handleRouteChange),
                                     name: AVAudioSession.routeChangeNotification,
                                     object: nil)
    }
    
    // MARK: Handle Notifications
    @objc func handleRouteChange(notification: Notification) {
      guard let userInfo = notification.userInfo,
        let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
        let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else {
          return
      }
      switch reason {
      case .newDeviceAvailable:
        let session = AVAudioSession.sharedInstance()
        for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.headphones {
          print("headphones connected")
          DispatchQueue.main.sync {
            didTapPlayPauseButton()
          }
          break
        }
      case .oldDeviceUnavailable:
        if let previousRoute =
          userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
          for output in previousRoute.outputs where output.portType == AVAudioSession.Port.headphones {
            print("headphones disconnected")
            DispatchQueue.main.sync {
                didTapPlayPauseButton()
            }
            break
          }
        }
      default: ()
      }
    }
    @objc func handleInterruption(notification: Notification) {
      guard let userInfo = notification.userInfo,
        let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
        let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
          return
      }
      
      if type == .began {
        print("Interruption began")
        // Interruption began, take appropriate actions
      }
      else if type == .ended {
        if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
          let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
          if options.contains(.shouldResume) {
            // Interruption Ended - playback should resume
            print("Interruption Ended - playback should resume")
            didTapPlayPauseButton()
          } else {
            // Interruption Ended - playback should NOT resume
            print("Interruption Ended - playback should NOT resume")
          }
        }
      }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      print("Audio player did finish playing: \(flag)")
      if (flag) {
        updateNowPlaying(isPause: true)
        playPauseButton.setTitle("Play", for: UIControl.State.normal)
      }
    }
}

