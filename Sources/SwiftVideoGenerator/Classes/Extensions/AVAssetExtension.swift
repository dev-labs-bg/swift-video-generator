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
  
  func writeAudioTrackToURL(URL: URL, completion: @escaping (Bool, Error?) -> ()) {
    do {
      let audioAsset = try self.audioAsset()
      audioAsset.writeToURL(URL: URL, completion: completion)
      
    } catch {
      completion(false, error)
    }
  }
  
  func writeToURL(URL: URL, completion: @escaping (Bool, Error?) -> ()) {
    guard let exportSession = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetAppleM4A) else {
      completion(false, nil)
      return
    }
    
    exportSession.outputFileType = AVFileType.m4a
    exportSession.outputURL      = URL as URL
    
    exportSession.exportAsynchronously {
      switch exportSession.status {
      case .completed:
        completion(true, nil)
      case .unknown, .waiting, .exporting, .failed, .cancelled:
        completion(false, nil)
      @unknown default:
        completion(false, nil)
      }
    }
  }
  
  func audioAsset() throws -> AVAsset {
    let composition = AVMutableComposition()
    let audioTracks = tracks(withMediaType: AVMediaType.audio)
    for track in audioTracks {
      
      let compositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
      do {
        try compositionTrack?.insertTimeRange(track.timeRange, of: track, at: track.timeRange.start)
      } catch {
        throw error
      }
      compositionTrack?.preferredTransform = track.preferredTransform
    }
    return composition
  }
}
