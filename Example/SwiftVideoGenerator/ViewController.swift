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
  
  @IBOutlet weak var generateSingleVideoButton: UIButton! {
    didSet {
      generateSingleVideoButton.accessibilityLabel = "single"
    }
  }
  
  @IBOutlet weak var generateMultipleVideoButton: UIButton! {
    didSet {
      generateMultipleVideoButton.accessibilityLabel = "multiple"
    }
  }
  
  @IBOutlet weak var mergeVideosButton: UIButton! {
    didSet {
      mergeVideosButton.accessibilityLabel = "merge"
    }
  }
  
  // MARK: - Public methods
  
  @IBAction func generateSingleVideoButtonClickHandler(_ sender: UIButton) {
    if let audioURL4 = Bundle.main.url(forResource: "audio4", withExtension: "mp3"), let _image1 = UIImage(named: "image4") {
      VideoGenerator.current.fileName = "singleMovie"

      VideoGenerator.generate(withImages: [_image1], andAudios: [audioURL4], andType: .single, { (progress) in
        print(progress)
      }, success: { (url) in
        print(url)
        self.createAlertView(message: "Finished single type video generation")
      }, failure: { (error) in
        print(error)
        self.createAlertView(message: error.localizedDescription)
      })
    }
  }
  
  @IBAction func generateMultipleVideoButtonClickHandler(_ sender: UIButton) {
    if let audioURL1 = Bundle.main.url(forResource: "audio1", withExtension: "mp3"), let audioURL2 = Bundle.main.url(forResource: "audio2", withExtension: "mp3"), let audioURL3 = Bundle.main.url(forResource: "audio3", withExtension: "mp3") {
      if let _image1 = UIImage(named: "image1"), let _image2 = UIImage(named: "image2"), let _image3 = UIImage(named: "image3") {

        VideoGenerator.current.fileName = "multipleVideo"
        VideoGenerator.current.videoBackgroundColor = .red
        VideoGenerator.current.scaleWidth = 700
        
        VideoGenerator.generate(withImages: [_image1, _image2, _image3], andAudios: [audioURL1, audioURL2, audioURL3], andType: .multiple, { (progress) in
          print(progress)
        }, success: { (url) in
          print(url)
          self.createAlertView(message: "Finished single type video generation")
        }, failure: { (error) in
          print(error)
          self.createAlertView(message: error.localizedDescription)
        })
      }
    }
  }
  
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
    
    if let videoURL1 = Bundle.main.url(forResource: "video1", withExtension: "mov"), let videoURL2 = Bundle.main.url(forResource: "video2", withExtension: "mov") {
      VideoGenerator.mergeMovies(videoURLs: [videoURL1, videoURL2], andFileName: "mergedMovie", success: { (videoURL) in
        self.createAlertView(message: "Finished merging videos")
        print(videoURL)
      }) { (error) in
        print(error)
        self.createAlertView(message: error.localizedDescription)
      }
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
    mergeVideosButton.layer.cornerRadius = mergeVideosButton.frame.height / 2
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
