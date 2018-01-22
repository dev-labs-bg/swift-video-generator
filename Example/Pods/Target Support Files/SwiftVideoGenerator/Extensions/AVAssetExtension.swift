//
//  AVAssetExtension.swift
//  Pods-SwiftVideoGenerator_Example
//
//  Created by DevLabs BG on 22.01.18.
//

import UIKit
import AVFoundation

extension AVAsset {
  
  func videoOrientation() -> (orientation: UIInterfaceOrientation, device: AVCaptureDevice.Position) {
    var orientation: UIInterfaceOrientation = .unknown
    var device: AVCaptureDevice.Position = .unspecified
    
    let tracks: [AVAssetTrack] = self.tracks(withMediaType: .video)
    if let videoTrack = tracks.first {
      
      let t = videoTrack.preferredTransform
      
      if (t.a == 0 && t.b == 1.0 && t.d == 0) {
        orientation = .portrait
        
        if t.c == 1.0 {
          device = .front
        } else if t.c == -1.0 {
          device = .back
        }
      }
      else if (t.a == 0 && t.b == -1.0 && t.d == 0) {
        orientation = .portraitUpsideDown
        
        if t.c == -1.0 {
          device = .front
        } else if t.c == 1.0 {
          device = .back
        }
      }
      else if (t.a == 1.0 && t.b == 0 && t.c == 0) {
        orientation = .landscapeRight
        
        if t.d == -1.0 {
          device = .front
        } else if t.d == 1.0 {
          device = .back
        }
      }
      else if (t.a == -1.0 && t.b == 0 && t.c == 0) {
        orientation = .landscapeLeft
        
        if t.d == 1.0 {
          device = .front
        } else if t.d == -1.0 {
          device = .back
        }
      }
    }
    
    return (orientation, device)
  }
}
