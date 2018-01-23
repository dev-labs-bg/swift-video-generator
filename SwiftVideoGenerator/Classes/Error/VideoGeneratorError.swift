//
//  VideoGeneratorError.swift
//  Pods-SwiftVideoGenerator_Example
//
//  Created by DevLabs BG on 22.01.18.
//

import UIKit

public class VideoGeneratorError: NSObject, LocalizedError {
  
  public enum CustomError {
    case kFailedToStartAssetWriterError
    case kFailedToAppendPixelBufferError
    case kFailedToFetchDirectory
    case kFailedToStartAssetExportSession
    case kMissingVideoURLs
    case kFailedToReadProvidedClip
    case kUnsupportedVideoType
    case kFailedToStartReader
    case kFailedToReadVideoTrack
    case kFailedToReadStartTime
  }
  
  fileprivate var desc = ""
  fileprivate var error: CustomError
  fileprivate let kErrorDomain = "VideoGenerator"
  
  init(error: CustomError) {
    self.error = error
  }
  
  override public var description: String {
    get {
      switch error {
      case .kFailedToStartAssetWriterError:
        return "\(kErrorDomain): AVAssetWriter failed to start writing"
      case .kFailedToAppendPixelBufferError:
        return "\(kErrorDomain): AVAssetWriterInputPixelBufferAdapter failed to append pixel buffer"
      case .kFailedToFetchDirectory:
        return "\(kErrorDomain): Can't find the Documents directory"
      case .kFailedToStartAssetExportSession:
        return "\(kErrorDomain): Can't begin an AVAssetExportSession"
      case .kMissingVideoURLs:
        return "\(kErrorDomain): Missing video paths"
      case .kFailedToReadProvidedClip:
        return "\(kErrorDomain): Couldn't read the supplied video's frames."
      case .kUnsupportedVideoType:
        return "\(kErrorDomain): Unsupported video type. Supported tyeps: .m4v, mp4, .mov"
      case .kFailedToStartReader:
        return "\(kErrorDomain): Failed to start reading video frames"
      case .kFailedToReadVideoTrack:
        return "\(kErrorDomain): Failed to read video track in asset"
      case .kFailedToReadStartTime:
        return "\(kErrorDomain): Start time can't be less then 0"
      }
    }
  }
  
  public var errorDescription: String? {
    get {
      return self.description
    }
  }
}
