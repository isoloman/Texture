//
//  Utilities.swift
//  Texture
//
//  Copyright (c) Facebook, Inc. and its affiliates.  All rights reserved.
//  Changes after 4/13/2017 are: Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0
//

import UIKit
import Foundation

extension UIColor {

  static func darkBlueColor() -> UIColor {
    return UIColor(red: 18.0/255.0, green: 86.0/255.0, blue: 136.0/255.0, alpha: 1.0)
  }

  static func lightBlueColor() -> UIColor {
    return UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
  }

  static func duskColor() -> UIColor {
    return UIColor(red: 255/255.0, green: 181/255.0, blue: 68/255.0, alpha: 1.0)
  }

  static func customOrangeColor() -> UIColor {
    return UIColor(red: 40/255.0, green: 43/255.0, blue: 53/255.0, alpha: 1.0)
  }

}

extension UIImage {

  func makeCircularImage(size: CGSize, borderWidth width: CGFloat) -> UIImage {
    // make a CGRect with the image's size
    let circleRect = CGRect(origin: .zero, size: size)

    // begin the image context since we're not in a drawRect:
    UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)

    // create a UIBezierPath circle
    let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)

    // clip to the circle
    circle.addClip()

    UIColor.white.set()
    circle.fill()

    // draw the image in the circleRect *AFTER* the context is clipped
    self.draw(in: circleRect)

    // create a border (for white background pictures)
    if width > 0 {
      circle.lineWidth = width;
      UIColor.white.set()
      circle.stroke()
    }

    // get an image from the image context
    let roundedImage = UIGraphicsGetImageFromCurrentImageContext();

    // end the image context since we're not in a drawRect:
    UIGraphicsEndImageContext();

    return roundedImage ?? self
  }
  
  class func draw(size: CGSize, fillColor: UIColor, shapeClosure: () -> UIBezierPath) -> UIImage {
    UIGraphicsBeginImageContext(size)
    
    let path = shapeClosure()
    path.addClip()
    
    fillColor.setFill()
    path.fill()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
}

extension NSAttributedString {

  static func attributedString(string: String?, fontSize size: CGFloat, color: UIColor?) -> NSAttributedString? {
    guard let string = string else { return nil }

    let attributes = [NSForegroundColorAttributeName: color ?? UIColor.black,
                      NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)]

    let attributedString = NSMutableAttributedString(string: string, attributes: attributes)

    return attributedString
  }
  
}
