//
//  LoadingView.swift
//  SwiftVideoGenerator_Example
//
//  Created by DevLabs BG on 10.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  
  // MARK: - Singleton properties
  
  // MARK: - Static properties
  
  // MARK: - Public properties
  
  // MARK: - Public methods
  
  /**
   Class method to lock the screen
   */
  class func lockView() {
    DispatchQueue.main.async {
      let loadingView = LoadingView(frame: UIScreen.main.bounds)
      loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
      
      if let _lastWindow = UIApplication.shared.windows.last {
        if !_lastWindow.subviews.contains(where: { $0 is LoadingView }) {
          _lastWindow.endEditing(true)
          _lastWindow.addSubview(loadingView)
        }
      }
      
      loadingView.addFadeAnimationWithFadeType(.fadeIn)
      
      let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
      indicator.center = loadingView.center
      indicator.tintColor = .white
      
      if UI_USER_INTERFACE_IDIOM() == .pad {
        indicator.style = .whiteLarge
      } else {
        indicator.style = .white
      }
      indicator.startAnimating()
      loadingView.addSubview(indicator)
    }
  }
  
  /**
   Class method to unclock the screen after a request
   */
  class func unlockView() {
    DispatchQueue.main.async {
      if let _lastWindow = UIApplication.shared.windows.last {
        for subview in _lastWindow.subviews {
          if let loadingView = subview as? LoadingView {
            loadingView.addFadeAnimationWithFadeType(.fadeOut)
          }
        }
      }
    }
  }
  
  // MARK: - Initialize/Livecycle methods
  
  // MARK: - Override methods
  
  // MARK: - Private properties
  
  // MARK: - Private methods
  
}

enum FadeType {
  case fadeIn
  case fadeOut
}

extension UIView {
  
  /**
   This function performs a fadeIn/ fadeOut animation on a view
   
   :param: fadeType         fade type: in or out
   :param: shouldRemoveView should it remove ot add the view
   */
  func addFadeAnimationWithFadeType(_ fadeType: FadeType) {
    
    switch fadeType {
    case .fadeIn:
      
      DispatchQueue.main.async {
        self.alpha = 0.0
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
          self.alpha = 1.0
        })
      }
      
    case .fadeOut:
      
      UIView.animate(withDuration: 1.0, animations: { () -> Void in
        DispatchQueue.main.async {
          self.alpha = 0.0
        }
      }, completion: { (finished) -> Void in
        if finished {
          self.removeFromSuperview()
        }
      })
    }
  }
}
