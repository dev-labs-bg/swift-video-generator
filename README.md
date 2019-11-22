![swift-video-generator-logo](https://github.com/dev-labs-bg/swift-video-generator/blob/master/Example/SwiftVideoGenerator/Resources/swift-video-generator-logo.png)

[![Platform](https://img.shields.io/cocoapods/p/SwiftVideoGenerator.svg?style=flat-square)]()  [![CocoaPods](https://img.shields.io/cocoapods/v/SwiftVideoGenerator.svg?style=flat-square)]()  [![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://github.com/dev-labs-bg/swift-video-generator/blob/master/LICENSE)  [![Twitter URL](https://img.shields.io/badge/twitter-@devlabsbg-blue.svg?style=flat-square)](http://twitter.com/devlabsbg)  [![Website](https://img.shields.io/website-up-down-blue-red/http/shields.io.svg?label=devlabs.bg&style=flat-square)](http://devlabs.bg)

This library provides an easy way to combine images and audio into a video or merge multiple videos into one.

## Features
- create a video from a **single** image and audio file
- create a video from **multiple** image/audio pairs
- create a video from a **single** audio and **multiple** images
- create a video from a **single** image (no audio) 
- create a video from **multiple** images (no audio)
- merge **multiple** videos into one
- **reverse** a video clip
- **split** video in time range 
- merge **single** video with **single** audio
---
## Supported video formats
- mov (only when merging videos)
- m4v
- mp4 (only when merging videos)

---
## Requirements
- iOS 9.0 or later
- Xcode 8.3 or later
- Swift 3.2 or later

---
## Communication
-  If you need help or want to ask a general question, you can find me [@guardians_devil](https://twitter.com/guardians_devil?lang=en) or [@devlabsbg](https://twitter.com/devlabsbg). Or tag #swift-video-generator on [Twitter](https://twitter.com/)
-  If you found a bug, open an issue
-  If you have a feature request, open an issue
-  If you want to contribute, submit a pull request
---

## Contributers

- [ibhavin](https://github.com/ibhavin) - version 1.0.8 creating a video form a single audio and multiple images
- [SteliyanH](https://github.com/SteliyanH) - version 1.1.0 reversing the audio in a video clip
---
## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependancy manager for Xcode. You can install it by running the following command in the Terminal:

```
$ gem install cocoapods
```

To use Swift Video Generator in your Xcode project using CocoaPods, add it in the `Podfile`:
```Swift
platform :ios, '10.0'
use_frameworks!
target '<Your Target Name>' do
pod 'SwiftVideoGenerator'
end
```

### Swift Package Manager

To add the library as package dependency to your Xcode project, select File > Swift Packages > Add Package Dependency and enter its repository URL `git@github.com:dev-labs-bg/swift-video-generator.git`

### Manually

If you don't want to use a dependency manager, you can integrate SwiftVideoGenerator manually.

Download the following files:

[Video Generator Classes](https://github.com/dev-labs-bg/swift-video-generator/tree/master/SwiftVideoGenerator/Classes)

You need the VideoGenerator.swift and the files in the Error and Extensions folders.

###### Add files to project:
- Open your project in Xcode
- Add the files you downloaded to the Project Navigator. You can create your own folders or keep the files as they are.
- And you're done. You're now ready to make some video magic.
---
## Usage

If you used Cocoapods to install SwiftVideoGenerator, you need to import the module:
```Swift
import SwiftVideoGenerator
```
For both the **.single** and **.multiple** types of video generation the output video file format is m4v.

#### Create a video from a single audio and image file

```Swift
if let audioURL4 = Bundle.main.url(forResource: Audio4 , withExtension: Mp3Extension) {
  LoadingView.lockView()

  VideoGenerator.fileName = SingleMovieFileName
  VideoGenerator.shouldOptimiseImageForVideo = true

  VideoGenerator.current.generate(withImages: [#imageLiteral(resourceName: "image4")], andAudios: [audioURL4], andType: .single, { (progress) in
    print(progress)
  }, success: { (url) in
    LoadingView.unlockView()
    print(url)
    self.createAlertView(message: self.FinishedSingleTypeVideoGeneration)
  }, failure: { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  })
} else {
  self.createAlertView(message: MissingResourceFiles)
}
```
With the generator type **.single** you can create a video from a single pair of audio and an image. 

If you leave the **audio** array empty and implement **videoDurationInSeconds**, the generated video contains only the image without audio.

[Exmaple video - single type generation](https://drive.google.com/open?id=1vr19Zm2NjpeFbvGQLqJB7ew2lq4ExrOP)

The **scaleWidth** property scales the image to a desired size. Only used in a **.single** type of video.

The **fileName** property sets the output file's name.

The **videoBackgroundColor** property is used when scaling the image. When an image is scaled to a smaller frame then the video's it leaves empty spaces around the image. You can set the background color of that space with the **videoBackgroundColor** property. If you don't specify a **scaleWidth** the image is scaled (keeping the aspect ration) to fill the entire video frame.

The **maxVideoLengthInSeconds** property is used to set the video's maximum length. If the length of the moview exceeds this value, it's cut short at the specified time. (Note that this doesn't scale the audios in order to make them fit into the time.)

The **shouldOptimiseImageForVideo** property is used to optimize the images fed into the generators to a scale best fitted for video based on their orientation.

Set the **videoDurationInSeconds** for generated video without audio.

#### Create a video from multiple image/audio pairs

```Swift
if let audioURL1 = Bundle.main.url(forResource: Audio1, withExtension: Mp3Extension), let audioURL2 = Bundle.main.url(forResource: Audio2, withExtension: Mp3Extension), let audioURL3 = Bundle.main.url(forResource: Audio3, withExtension: Mp3Extension) {
  LoadingView.lockView()

  VideoGenerator.fileName = MultipleMovieFileName
  VideoGenerator.videoBackgroundColor = .red
  VideoGenerator.videoImageWidthForMultipleVideoGeneration = 2000

  VideoGenerator.current.generate(withImages: [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3")], andAudios: [audioURL1, audioURL2, audioURL3], andType: .multiple, { (progress) in
    print(progress)
  }, success: { (url) in
    LoadingView.unlockView()
    print(url)
    self.createAlertView(message: self.FnishedMultipleVideoGeneration)
  }, failure: { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  })
} else {
  self.createAlertView(message: MissingAudioFiles)
}
```
With the type **.multiple** you can create a video that combines multiple image/audio pairs. The finished video will queue up multiple videos created by taking one image from the array and it's corresponding index element from the audio array, creating a video from it and then appending it to the finished video.

If you leave the **audio** array empty and implement **videoDurationInSeconds**, the generated video contains only the images without audio.

Then the next pair of audio and image will be made into a video and appended after the first one. This will continue untill all image/audio pairs have been appended. If the image/audio pairs are not the same count, the extra audio(s)/image(s) is not used.

The **fileName** and **videoBackgroundColor** properties are used in the same way as in the **.single** type.

The **videoImageWidthForMultipleVideoGeneration** property is used to set a custom width to which the images will be scaled before they are merged with the audio files and generated as a video. The default value is 800.

[Exmaple video - multiple type generation video](https://drive.google.com/open?id=1bCoGe2LF6n5Jn9jSgNvj_UbZHv4g9GvG)

#### Create a video from multiple images and a single audio

```Swift
if let audioURL1 = Bundle.main.url(forResource: Audio1, withExtension: Mp3Extension) {
  LoadingView.lockView()

  VideoGenerator.fileName = MultipleSingleMovieFileName
  VideoGenerator.shouldOptimiseImageForVideo = true

  VideoGenerator.current.generate(withImages: [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4")], andAudios: [audioURL1], andType: .singleAudioMultipleImage, { (progress) in
    print(progress)
  }, success: { (url) in
    LoadingView.unlockView()
    print(url)
    self.createAlertView(message: self.FnishedMultipleVideoGeneration)
  }, failure: { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  })
} else {
  self.createAlertView(message: MissingAudioFiles)
}
```
With the type **.singleAudioMultipleImage** you can create a video that combines multiple images and a single audio. The finished video will space out the multiple images along the timeline of the single audio.

[Exmaple video - multiple images/single audio generated video](https://drive.google.com/open?id=1THpNWw9gZsEUYqrre8JkmOcFZ4IKsHGd)

#### Merging multiple videos into one

```Swift
if let videoURL1 = Bundle.main.url(forResource: Video1, withExtension: MOVExtension), let videoURL2 = Bundle.main.url(forResource: PortraitVideo, withExtension: Mp4Extension) {
  LoadingView.lockView()
  VideoGenerator.presetName = AVAssetExportPresetPassthrough
  VideoGenerator.fileName = MergedMovieFileName
  
  VideoGenerator.mergeMovies(videoURLs: [videoURL1, videoURL2], success: { (videoURL) in
    LoadingView.unlockView()
    self.createAlertView(message: self.FinishedMergingVideos)
    print(videoURL)
  }) { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  }
} else {
  self.createAlertView(message: MissingVideoFiles)
}
```
You can provide URLs both for local resource files as well as those stored on the device (i.e. in the Documents folder).

As of right now the merged video keeps all of the **preferredTransformations** (like mirroring or orientation) of the last provided video asset. More to come in future feature implementations.

[Exmaple video - merged video](https://drive.google.com/open?id=1QuwG15ksop8en_RlPgwwMKE-Nv6r7cic)

#### Reversing a video clip

```Swift
if let videoURL1 = Bundle.main.url(forResource: Video2, withExtension: MovExtension) {
  LoadingView.lockView()
  VideoGenerator.fileName = ReversedMovieFileName
  
  VideoGenerator.current.reverseVideo(fromVideo: videoURL1, success: { (videoURL) in
    LoadingView.unlockView()
    self.createAlertView(message: self.FinishReversingVideo)
    print(videoURL)
  }, failure: { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  })
} else {
  self.createAlertView(message: self.MissingVideoFiles)
}
```
You need to provide the file's URL and optionally a new name for the reversed video file. The finished reverse video is without audio.

[Exmaple video - reversed video](https://drive.google.com/open?id=1vz5wzXyBti0FYEhJQqgbP4OQL-_xzuvX)

#### Splitting a video clip

```Swift
if let videoURL1 = Bundle.main.url(forResource: Video1, withExtension: MOVExtension) {
  LoadingView.lockView()

  VideoGenerator.fileName = SplitMovieFileName
  
  VideoGenerator.current.splitVideo(withURL: videoURL1, atStartTime: 10, andEndTime: 40, success: { (url) in
    LoadingView.unlockView()
    print(url)
    self.createAlertView(message: self.FinishSplittingVideo)
  }, failure: { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  })
} else {
  self.createAlertView(message: self.MissingVideoFiles)
}
```
You need to provide the file's URL and optionally a new name for the split video file. The **atStartTime** and **andEndTime** properties mark the start and end of the time range in seconds.

[Exmaple video - split video](https://drive.google.com/open?id=1X26SmtYJk8B9ZKOwU8mXDvcDhLuizDkO)

#### Merging a video clip with custom audio

```Swift
if let videoURL2 = Bundle.main.url(forResource: Video2, withExtension: MOVExtension), let audioURL2 = Bundle.main.url(forResource: Audio2, withExtension: Mp3Extension) {
  LoadingView.lockView()

  VideoGenerator.fileName = NewAudioMovieFileName
  
  VideoGenerator.current.mergeVideoWithAudio(videoUrl: videoURL2, audioUrl: audioURL2, success: { (url) in
    LoadingView.unlockView()
    print(url)
    self.createAlertView(message: self.FinishMergingVideoWithAudio)
  }) { (error) in
    LoadingView.unlockView()
    print(error)
    self.createAlertView(message: error.localizedDescription)
  }
} else {
  self.createAlertView(message: self.MissingVideoFiles)
}
```
You need to provide the video and audio URLs and optionally a new name for the generated video file.

[Exmaple video - merge video with new audio](https://drive.google.com/open?id=1VgvhZXFczViqZ_jcU4DsvXNTjiPJahEU)

## Already in use in the following apps:

- [LingoZING!](https://itunes.apple.com/us/app/lingozing/id1180618224)

## Credits

SwiftVideoGenerator was created and is maintaned by Dev Labs. You can find us [@devlabsbg](https://twitter.com/devlabsbg) or [devlabs.bg](http://devlabs.bg/).

## License

SwiftVideoGenerator is released under the MIT license. See [LICENSE](https://github.com/dev-labs-bg/swift-video-generator/blob/master/LICENSE) for details.
