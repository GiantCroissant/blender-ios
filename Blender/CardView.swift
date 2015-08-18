//
//  CardView.swift
//  Blender
//
//  Created by Bryan Lin on 8/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class CardView: UIView {

    var radius: CGFloat = 2

    override func layoutSubviews() {
//        layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 0);
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.CGPath
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}