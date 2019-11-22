//
//  ViewController.swift
//  SwiftVideoGenerator
//
//  Created by teodora.georgieva.92@gmail.com on 10/27/2017.
//  Copyright (c) 2017 teodora.georgieva.92@gmail.com. All rights reserved.
//

import UIKit
import AVKit
import SwiftVideoGenerator

class ViewController: UIViewController {
  
  // MARK: - Singleton properties
  
  // MARK: - Static properties
  
  // MARK: - Public properties
  
  /// public property to represent a button on the UI
  @IBOutlet weak var generateSingleVideoButton: UIButton!
  
  /// public property to represent a button on the UI
  @IBOutlet weak var generateMultipleVideoButton: UIButton!
  
  /// public property to represent a button on the UI
  @IBOutlet weak var mergeVideosButton: UIButton!
  
  /// public property to represent a button on the UI
  @IBOutlet weak var generateSingleAudioMultipleImageButton: UIButton!
  
  /// public property to represent a button on the UI
  @IBOutlet weak var reverseVideoButton: UIButton!
  
  /// public peoperty to represent a button on the UI
  @IBOutlet weak var splitVideoButton: UIButton!
  
  /// public peoperty to represent a button on the UI
  @IBOutlet weak var mergeVideoWithAudioButton: UIButton!
  
  // MARK: - Public methods
  
  /// Public method to handle the click in the generateSingleVideoButton
  /// Generates a single type video from oen audio and one image
  /// - Parameter sender: a sender of type UIButton
  @IBAction func generateSingleVideoButtonClickHandler(_ sender: UIButton) {
    if let audioURL4 = Bundle.main.url(forResource: Audio4 , withExtension: Mp3Extension) {
      LoadingView.lockView()
      
      VideoGenerator.fileName = SingleMovieFileName
      VideoGenerator.shouldOptimiseImageForVideo = true
    
      VideoGenerator.current.generate(withImages: [#imageLiteral(resourceName: "image1")], andAudios: [audioURL4], andType: .single, { (progress) in
        print(progress)
      }) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          print(url)
          self.createAlertView(message: self.FinishedSingleTypeVideoGeneration)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: MissingResourceFiles)
    }
  }
  
  /// Public method to handle the click in the generateMultipleVideoButton
  /// Generates a multiple type video from multiple images and audios
  /// - Parameter sender: a sender of type UIButton
  @IBAction func generateMultipleVideoButtonClickHandler(_ sender: UIButton) {
    if let audioURL1 = Bundle.main.url(forResource: Audio1, withExtension: Mp3Extension), let audioURL2 = Bundle.main.url(forResource: Audio2, withExtension: Mp3Extension), let audioURL3 = Bundle.main.url(forResource: Audio3, withExtension: Mp3Extension) {
      LoadingView.lockView()
      
      VideoGenerator.fileName = MultipleMovieFileName
      VideoGenerator.videoBackgroundColor = .red
      VideoGenerator.videoImageWidthForMultipleVideoGeneration = 2000
      
      VideoGenerator.current.generate(withImages: [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3")], andAudios: [audioURL1, audioURL2, audioURL3], andType: .multiple, { (progress) in
        print(progress)
      }) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          print(url)
          self.createAlertView(message: self.FinishedSingleTypeVideoGeneration)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: MissingAudioFiles)
    }
  }
  
  /// Public method to handle the click in the generateSingleAudioMultipleImageButton
  /// Generates a multiple type video from multiple images and single audio
  /// - Parameter sender: a sender of type UIButton
  @IBAction func generateMultipleImageSingleAudioVideo(_ sender: UIButton) {
    if let audioURL1 = Bundle.main.url(forResource: Audio1, withExtension: Mp3Extension) {
      LoadingView.lockView()
      
      VideoGenerator.fileName = MultipleSingleMovieFileName
      VideoGenerator.shouldOptimiseImageForVideo = true
      
      VideoGenerator.current.generate(withImages: [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4")], andAudios: [audioURL1], andType: .singleAudioMultipleImage, { (progress) in
        print(progress)
      }) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          print(url)
          self.createAlertView(message: self.FinishedSingleTypeVideoGeneration)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: MissingAudioFiles)
    }
  }
  
  /// Public method to handle the click in the mergeVideosButton
  /// Merges multiple videos into a single video
  /// - Parameter sender: a sender of type UIButton
  @IBAction func mergeVideosButtonClickHandler(_ sender: UIButton) {
    
    //    if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    //      if let paths = try? FileManager.default.contentsOfDirectory(atPath: documentsPath) {
    //
    //        var videoURLs: [URL] = []
    //        for path in paths {
    //          videoURLs.append(URL(fileURLWithPath: documentsPath).appendingPathComponent(path))
    //        }
    //
    //        VideoGenerator.mergeMovies(videoURLs: videoURLs, andFileName: MergedMovieFileName, success: { (videoURL) in
    
    if let videoURL1 = Bundle.main.url(forResource: Video1, withExtension: MOVExtension), let videoURL2 = Bundle.main.url(forResource: PortraitVideo, withExtension: Mp4Extension) {
      LoadingView.lockView()
      VideoGenerator.presetName = AVAssetExportPresetPassthrough
      VideoGenerator.fileName = MergedMovieFileName
      
      VideoGenerator.mergeMovies(videoURLs: [videoURL1, videoURL2]) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          self.createAlertView(message: self.FinishedMergingVideos)
          print(url)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: MissingVideoFiles)
    }
  }
  
  /// Public method to handle the click in the reverseVideoButton
  /// Reverses the given video
  /// - Parameter sender: a sender of type UIButton
  @IBAction func reverseVideoButtonClickHandler(_ sender: UIButton) {
    if let videoURL1 = Bundle.main.url(forResource: Video2, withExtension: MovExtension) {
      LoadingView.lockView()
      VideoGenerator.fileName = ReversedMovieFileName
      
      VideoGenerator.current.reverseVideo(fromVideo: videoURL1) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          print(url)
          self.createAlertView(message: self.FinishReversingVideo)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: self.MissingVideoFiles)
    }
  }
  
  /// Method to start an example of spliting videos
  @IBAction func splitVideoButtonClickHandler(_ sender: UIButton) {
    if let videoURL1 = Bundle.main.url(forResource: Video1, withExtension: MOVExtension) {
      LoadingView.lockView()
      
      VideoGenerator.fileName = SplitMovieFileName
      
      VideoGenerator.current.splitVideo(withURL: videoURL1, atStartTime: 14, andEndTime: 24) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          print(url)
          self.createAlertView(message: self.FinishSplittingVideo)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: self.MissingVideoFiles)
    }
  }
  
  /// Method to start an example of merging video with audio videos
  @IBAction func mergeVideoAndAudioButtonClickHandler(_ sender: UIButton) {
    if let videoURL2 = Bundle.main.url(forResource: Video2, withExtension: MOVExtension), let audioURL2 = Bundle.main.url(forResource: Audio2, withExtension: Mp3Extension) {
      LoadingView.lockView()
      
      VideoGenerator.fileName = NewAudioMovieFileName
      
      VideoGenerator.current.mergeVideoWithAudio(videoUrl: videoURL2, audioUrl: audioURL2) { (result) in
        LoadingView.unlockView()
        switch result {
        case .success(let url):
          print(url)
          self.createAlertView(message: self.FinishMergingVideoWithAudio)
        case .failure(let error):
          print(error)
          self.createAlertView(message: error.localizedDescription)
        }
      }
    } else {
      self.createAlertView(message: self.MissingVideoFiles)
    }
  }
  
  // MARK: - Initialize/Livecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Override methods
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    generateSingleVideoButton.layer.cornerRadius = generateSingleVideoButton.frame.height / 2
    generateMultipleVideoButton.layer.cornerRadius = generateMultipleVideoButton.frame.height / 2
    generateSingleAudioMultipleImageButton.layer.cornerRadius = generateSingleAudioMultipleImageButton.frame.height / 2
    mergeVideosButton.layer.cornerRadius = mergeVideosButton.frame.height / 2
    reverseVideoButton.layer.cornerRadius = reverseVideoButton.frame.height / 2
    splitVideoButton.layer.cornerRadius = splitVideoButton.frame.height / 2
    mergeVideoWithAudioButton.layer.cornerRadius = mergeVideoWithAudioButton.frame.height / 2
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Private properties
  
  /// Alert error strings
  private let MissingResourceFiles = "Missing resource files"
  private let MissingImageFiles = "Missing image files"
  private let MissingAudioFiles = "Missing audio files"
  private let MissingVideoFiles = "Missing video files"
  
  private let FnishedMultipleVideoGeneration = "Finished multiple type video generation"
  private let FinishedSingleTypeVideoGeneration = "Finished single type video generation"
  private let FinishedMergingVideos = "Finished merging videos"
  private let FinishReversingVideo = "Finished reversing video"
  private let FinishSplittingVideo = "Finished splitting video"
  private let FinishMergingVideoWithAudio = "Finished merging video with audio"
  
  private let SingleMovieFileName = "singleMovie"
  private let MultipleMovieFileName = "multipleVideo"
  private let MultipleSingleMovieFileName = "newVideo"
  private let MergedMovieFileName = "mergedMovie"
  private let ReversedMovieFileName = "reversedMovie"
  private let SplitMovieFileName = "splitMovie"
  private let NewAudioMovieFileName = "newAudioMovie"
  
  /// Resource extensions
  private let MovExtension = "mov"
  private let Mp3Extension = "mp3"
  private let MOVExtension = "mov"
  private let Mp4Extension = "mp4"
  
  /// Resource file names
  private let Audio1 = "audio1"
  private let Audio2 = "audio2"
  private let Audio3 = "audio3"
  private let Audio4 = "audio4"
  
  private let Video1 = "video1"
  private let Video2 = "video2"
  private let Video3 = "video3"
  private let Video4 = "video4"
  private let PortraitVideo = "portraitVideo"
  
  private let Message = "message"
  private let OK = "OK"
  
  // MARK: - Private methods
  
  /**
   Create and show an alert view
   */
  fileprivate func createAlertView(message: String?) {
    let messageAlertController = UIAlertController(title: Message, message: message, preferredStyle: .alert)
    messageAlertController.addAction(UIAlertAction(title: OK, style: .default, handler: { (action: UIAlertAction!) in
      messageAlertController.dismiss(animated: true, completion: nil)
    }))
    DispatchQueue.main.async { [weak self] in
      self?.present(messageAlertController, animated: true, completion: nil)
    }
  }
}
