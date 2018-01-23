//
//  ViewController.swift
//  SwiftVideoGenerator
//
//  Created by teodora.georgieva.92@gmail.com on 10/27/2017.
//  Copyright (c) 2017 teodora.georgieva.92@gmail.com. All rights reserved.
//

import UIKit
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
  
  @IBOutlet weak var splitVideoButton: UIButton!
  
  // MARK: - Public methods
  
  /// Public method to handle the click in the generateSingleVideoButton
  /// Generates a single type video from oen audio and one image
  /// - Parameter sender: a sender of type UIButton
  @IBAction func generateSingleVideoButtonClickHandler(_ sender: UIButton) {
    if let audioURL4 = Bundle.main.url(forResource: "audio4", withExtension: "mp3"), let _image1 = UIImage(named: "image4") {
      LoadingView.lockView()
      
      VideoGenerator.current.fileName = "singleMovie"
      VideoGenerator.current.maxVideoLengthInSeconds = 8
      VideoGenerator.current.shouldOptimiseImageForVideo = true
      
      VideoGenerator.current.generate(withImages: [_image1], andAudios: [audioURL4], andType: .single, { (progress) in
        print(progress)
      }, success: { (url) in
        LoadingView.unlockView()
        print(url)
        self.createAlertView(message: "Finished single type video generation")
      }, failure: { (error) in
        LoadingView.unlockView()
        print(error)
        self.createAlertView(message: error.localizedDescription)
      })
    }  else {
      self.createAlertView(message: "Missing resource files")
    }
  }
  
  /// Public method to handle the click in the generateMultipleVideoButton
  /// Generates a multiple type video from multiple images and audios
  /// - Parameter sender: a sender of type UIButton
  @IBAction func generateMultipleVideoButtonClickHandler(_ sender: UIButton) {
    if let audioURL1 = Bundle.main.url(forResource: "audio1", withExtension: "mp3"), let audioURL2 = Bundle.main.url(forResource: "audio2", withExtension: "mp3"), let audioURL3 = Bundle.main.url(forResource: "audio3", withExtension: "mp3") {
      if let _image1 = UIImage(named: "image1"), let _image2 = UIImage(named: "image2"), let _image3 = UIImage(named: "image3") {
        LoadingView.lockView()
        
        VideoGenerator.current.fileName = "multipleVideo"
        VideoGenerator.current.videoBackgroundColor = .red
        VideoGenerator.current.maxVideoLengthInSeconds = 20
        VideoGenerator.current.shouldOptimiseImageForVideo = true
        
        VideoGenerator.current.generate(withImages: [_image1, _image2, _image3], andAudios: [audioURL1, audioURL2, audioURL3], andType: .multiple, { (progress) in
          print(progress)
        }, success: { (url) in
          LoadingView.unlockView()
          print(url)
          self.createAlertView(message: "Finished multiple type video generation")
        }, failure: { (error) in
          LoadingView.unlockView()
          print(error)
          self.createAlertView(message: error.localizedDescription)
        })
      }  else {
        self.createAlertView(message: "Missing image files")
      }
    }  else {
      self.createAlertView(message: "Missing audio files")
    }
  }
  
  /// Public method to handle the click in the generateSingleAudioMultipleImageButton
  /// Generates a multiple type video from multiple images and single audio
  /// - Parameter sender: a sender of type UIButton
  @IBAction func generateMultipleImageSingleAudioVideo(_ sender: UIButton) {
    if let audioURL1 = Bundle.main.url(forResource: "audio1", withExtension: "mp3") {
      if let _image1 = UIImage(named: "image1"), let _image2 = UIImage(named: "image2"), let _image3 = UIImage(named: "image3"), let _image4 = UIImage(named: "image4") {
        LoadingView.lockView()
        
        VideoGenerator.current.fileName = "newVideo"
        VideoGenerator.current.shouldOptimiseImageForVideo = true
        
        VideoGenerator.current.generate(withImages: [_image1, _image2, _image3, _image4], andAudios: [audioURL1], andType: .singleAudioMultipleImage, { (progress) in
          print(progress)
        }, success: { (url) in
          LoadingView.unlockView()
          print(url)
          self.createAlertView(message: "Finished multiple type video generation")
        }, failure: { (error) in
          LoadingView.unlockView()
          print(error)
          self.createAlertView(message: error.localizedDescription)
        })
      }  else {
        self.createAlertView(message: "Missing image files")
      }
    }  else {
      self.createAlertView(message: "Missing audio files")
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
    //        VideoGenerator.mergeMovies(videoURLs: videoURLs, andFileName: "mergedMovie", success: { (videoURL) in
    //          self.createAlertView(message: "Finished merging videos")
    //          print(videoURL)
    //        }) { (error) in
    //          print(error)
    //          self.createAlertView(message: error.description)
    //        }
    //      }
    //    }
    
    if let videoURL1 = Bundle.main.url(forResource: "video1", withExtension: "mov"), let videoURL2 = Bundle.main.url(forResource: "portraitVideo", withExtension: "mp4") {
      LoadingView.lockView()
      VideoGenerator.mergeMovies(videoURLs: [videoURL1, videoURL2], andFileName: "mergedMovie", success: { (videoURL) in
        LoadingView.unlockView()
        self.createAlertView(message: "Finished merging videos")
        print(videoURL)
      }) { (error) in
        LoadingView.unlockView()
        print(error)
        self.createAlertView(message: error.localizedDescription)
      }
    }  else {
      LoadingView.unlockView()
      self.createAlertView(message: "Missing video files")
    }
  }
  
  /// Public method to handle the click in the reverseVideoButton
  /// Reverses the given video
  /// - Parameter sender: a sender of type UIButton
  @IBAction func reverseVideoButtonClickHandler(_ sender: UIButton) {
    if let videoURL1 = Bundle.main.url(forResource: "video1", withExtension: "mov") {
      LoadingView.lockView()
      VideoGenerator.current.reverseVideo(fromVideo: videoURL1, andFileName: "reversedMovie", withSound: false, success: { (videoURL) in
        LoadingView.unlockView()
        self.createAlertView(message: "Finished reversing video")
        print(videoURL)
      }, failure: { (error) in
        LoadingView.unlockView()
        print(error)
        self.createAlertView(message: error.localizedDescription)
      })
    } else {
      self.createAlertView(message: "Missing video file")
    }
  }
  
  @IBAction func splitVideoButtonClickHandler(_ sender: UIButton) {
    if let videoURL1 = Bundle.main.url(forResource: "video1", withExtension: "mov") {
      LoadingView.lockView()
      VideoGenerator.current.splitVideo(withURL: videoURL1, atStartTime: 10, andEndTime: 40, success: { (url) in
        LoadingView.unlockView()
        print(url)
        self.createAlertView(message: "Finished splitting video")
      }, failure: { (error) in
        LoadingView.unlockView()
        print(error)
        self.createAlertView(message: error.localizedDescription)
      })
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
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Private properties
  
  // MARK: - Private methods
  
  /**
   Create and show an alert view
   */
  fileprivate func createAlertView(message: String?) {
    let messageAlertController = UIAlertController(title: "message", message: message, preferredStyle: .alert)
    let buttonTitle = "OK"
    
    messageAlertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action: UIAlertAction!) in
      messageAlertController.dismiss(animated: true, completion: nil)
    }))
    
    present(messageAlertController, animated: true, completion: nil)
  }
}
