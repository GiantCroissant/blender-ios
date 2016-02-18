//
//  CardView.swift
//  Blender
//
//  Created by Bryan Lin on 8/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//


import UIKit

@IBDesignable
class CardView: UIView {

  @IBInspectable var cornerRadius: CGFloat = 2

  @IBInspectable var shadowOffsetWidth: Int = 0
  @IBInspectable var shadowOffsetHeight: Int = 3
  @IBInspectable var shadowColor: UIColor? = UIColor.blackColor()
  @IBInspectable var shadowOpacity: Float = 0.5

  override func layoutSubviews() {
    layer.cornerRadius = cornerRadius
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

    layer.masksToBounds = false
    layer.shadowColor = shadowColor?.CGColor
    layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
    layer.shadowOpacity = shadowOpacity
    layer.shadowPath = shadowPath.CGPath
  }

}

@IBDesignable
class ClipView: UIView {

  var cornerRadius: CGFloat = 2

  override func layoutSubviews() {
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = true
  }


}

//import UIKit
//
//class CardView: UIView {
//
//    var radius: CGFloat = 2
//
//    override func layoutSubviews() {
////        layer.cornerRadius = radius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
//
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.blackColor().CGColor
//        layer.shadowOffset = CGSize(width: 0, height: 0);
//        layer.shadowOpacity = 0.2
//        layer.shadowPath = shadowPath.CGPath
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
//}