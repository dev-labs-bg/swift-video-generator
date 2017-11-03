![swift-video-generator-logo](https://github.com/dev-labs-bg/swift-video-generator/blob/master/Example/SwiftVideoGenerator/Resources/swift-video-generator-logo.png)

[![Platform](https://img.shields.io/cocoapods/p/SwiftVideoGenerator.svg?style=flat-square)]()  [![CocoaPods](https://img.shields.io/cocoapods/v/SwiftVideoGenerator.svg?style=flat-square)]()  [![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://github.com/dev-labs-bg/swift-video-generator/blob/master/LICENSE)  [![Twitter URL](https://img.shields.io/badge/twitter-@devlabsbg-blue.svg?style=flat-square)](http://twitter.com/devlabsbg)  [![Website](https://img.shields.io/website-up-down-blue-red/http/shields.io.svg?label=devlabs.bg&style=flat-square)](http://devlabs.bg)

This library provides an easy way to combine images and audio into a video or merge multiple videos into one.

## Features
- create a video from a **single** image and audio file
- create a video from **multiple** image/audio pairs
- merge **multiple** videos into one

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
  pod 'SwiftVideoGenrator'
end
```
### Manually

If you don't want to use a dependency manager, you can integrate SwiftVideoGenerator manually.

Download the following .swift files:

[VideoGenerator](https://github.com/dev-labs-bg/swift-video-generator/blob/master/SwiftVideoGenerator/Classes/VideoGenerator.swift)

[ImageExtension](https://github.com/dev-labs-bg/swift-video-generator/blob/master/SwiftVideoGenerator/Classes/ImageExtension.swift)

###### Add files to project:
- Open your project in Xcode
- Select your project target, right-click and create two New Groups: VideoGenerator and ImageExtension (you can also create a group Extensions and add a subgroup Image)
- Now add the files you downloaded to their respective groups
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
if let audioURL = Bundle.main.url(forResource: "audio", withExtension: "mp3"), let _image = UIImage(named: "image") {
  VideoGenerator.current.fileName = "singleMovie"

  VideoGenerator.current.generate(withImages: [_image], andAudios: [audioURL], andType: .single, { (progress) in
    print(progress)
  }, success: { (url) in
    print(url)
    self.createAlertView(message: "Finished single type video generation")
  }, failure: { (error) in
    print(error)
    self.createAlertView(message: error.localizedDescription)
  })
}
```
With the generator type **.single** you can create a video from a single pair of audio and an image.

[Exmaple video](https://drive.google.com/open?id=0B_VCX_bQMRqPYVprSnQzdERLTkk)

The **scaleWidth** property scales the image to a desired size. Only used in a **.single** type of video.

The **fileName** property sets the output file's name.

The **videoBackgroundColor** property is used when scaling the image. When an image is scaled to a smaller frame then the video's it leaves empty spaces around the image. You can set the background color of that space with the **videoBackgroundColor** property. If you don't specify a **scaleWidth** the image is scaled (keeping the aspect ration) to fill the entire video frame.

#### Create a video from multiple image/audio pairs

```Swift
if let audioURL1 = Bundle.main.url(forResource: "audio1", withExtension: "mp3"), let audioURL2 = Bundle.main.url(forResource: "audio2", withExtension: "mp3"), let audioURL3 =  Bundle.main.url(forResource: "audio3", withExtension: "mp3") {
  if let _image1 = UIImage(named: "image1"), let _image2 = UIImage(named: "image2"), let _image3 = UIImage(named: "image3") {

    VideoGenerator.current.fileName = "multipleVideo"
    VideoGenerator.current.videoBackgroundColor = .red
    VideoGenerator.current.scaleWidth = 700

    VideoGenerator.current.generate(withImages: [_image1, _image2, _image3], andAudios: [audioURL1, audioURL2, audioURL3], andType: .multiple, { (progress) in
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
```
With the type **.multiple** you can create a video that combines multiple image/audio pairs. The finished video will queue up multiple videos created by taking one image from the array and it's corresponding index element from the audio array, creating a video from it and then appending it to the finished video.
Then the next pair of audio and image will be made into a video and appended after the first one. This will continue untill all image/audio pairs have been appended. If the image/audio pairs are not the same count, the extra audio(s)/image(s) is not used.

The **fileName** and **videoBackgroundColor** properties are used in the same way as in the **.single** type.

[Exmaple video](https://drive.google.com/open?id=0B_VCX_bQMRqPbTdNWlQ3X3E0YUU)

#### Merging multiple videos into one

```Swift
if let videoURL1 = Bundle.main.url(forResource: "video1", withExtension: "mov"), let videoURL2 = Bundle.main.url(forResource: "video2", withExtension: "mov") {
    VideoGenerator.mergeMovies(videoURLs: [videoURL1, videoURL2], andFileName: "mergedMovie", success: { (videoURL) in
      print(videoURL)
    }) { (error) in
      print(error)
    }
}
```
You can provide URLs both for local resource files as well as those stored on the device (i.e. in the Documents folder).

[Exmaple video](https://drive.google.com/open?id=0B_VCX_bQMRqPRWJrMEt2NDA1Mms)

## Credits

SwiftVideoGenerator was created and is maintaned by Dev Labs. You can find us [@devlabsbg](https://twitter.com/devlabsbg) or [devlabs.bg](http://devlabs.bg/).

## License

SwiftVideoGenerator is released under the MIT license. See [LICENSE](https://github.com/dev-labs-bg/swift-video-generator/blob/master/LICENSE) for details.
