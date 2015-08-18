//
//  AYOSegmentedControl.swift
//  Blender
//
//  Created by Bryan Lin on 8/17/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

@IBDesignable class AYOSegmentedControl : UIControl {

    private var labels = [UILabel]()
    var selectedHighlightView = UIView()

    var items: [String] = ["最近食譜", "熱門食譜"] {
        didSet {
            setupLabels()
        }
    }

    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }

    @IBInspectable var bgColor: UIColor = UIColor.blackColor() {
        didSet {
            updateBackgroundColor()
        }
    }

    @IBInspectable var selectedLabelColor: UIColor = UIColor.blackColor() {
        didSet {
            updateSelectedColors()
        }
    }

    @IBInspectable var unselectedLabelColor: UIColor = UIColor.whiteColor() {
        didSet {
            updateSelectedColors()
        }
    }

    @IBInspectable var highlightColor: UIColor = UIColor.whiteColor() {
        didSet {
            updateHighlightColor();
        }
    }

    @IBInspectable var fontSize: CGFloat = 13.0 {
        didSet {
            updateFont()
        }
    }

    @IBInspectable var fontFamily: String = "DIN Light" {
        didSet {
            updateFont()
        }
    }

    func updateFont() {
        for item in labels {
            item.font = UIFont(name: fontFamily, size: fontSize)
        }
    }

    func updateHighlightColor() {
        selectedHighlightView.backgroundColor = highlightColor
    }

    func updateSelectedColors() {
        for item in labels {
            item.textColor = unselectedLabelColor
        }

        if labels.count > 0 {
            labels[0].textColor = selectedLabelColor
        }
    }

    func updateBackgroundColor() {
        self.backgroundColor = bgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        var selectFrame = self.bounds
//        let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
//        selectFrame.size.width = newWidth
//        selectedHighlightView.frame = selectFrame


        selectedHighlightView.backgroundColor = highlightColor

        displayNewSelectedIndex()
    }

    func displayNewSelectedIndex(){
        for (index, item) in enumerate(labels) {
            item.textColor = unselectedLabelColor
        }

        var label = labels[selectedIndex]
        label.textColor = selectedLabelColor

        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {

            self.selectedHighlightView.frame = CGRectMake(label.frame.origin.x,
                label.frame.origin.y + label.frame.height - CGFloat(4),
                label.frame.width,
                4)
            
            }, completion: nil)
    }
    

    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {

        let location = touch.locationInView(self)

        var calculatedIndex : Int?
        for (index, item) in enumerate(labels) {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }


        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }

        return false
    }


    func setupView(){
        setupLabels()
        insertSubview(selectedHighlightView, atIndex: 0)
    }

    func setupLabels() {

        for label in labels {
            label.removeFromSuperview()
        }

        labels.removeAll(keepCapacity: true)

        for index in 1...items.count {

            let label = UILabel(frame: CGRectMake(0, 0, 70, 40))
            label.text = items[index - 1]
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = UIFont(name: "Avenir-Black", size: 15)
            label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(label)
            labels.append(label)
        }

        addIndividualItemConstraints(labels, mainView: self, padding: 0)
    }

    func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {

        let constraints = mainView.constraints()

        for (index, button) in enumerate(items) {

            var topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)

            var bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)

            var rightConstraint : NSLayoutConstraint!

            if index == items.count - 1 {

                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -padding)

            }else{

                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: nextButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -padding)
            }


            var leftConstraint : NSLayoutConstraint!

            if index == 0 {

                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: padding)

            }else{

                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: prevButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: padding)

                let firstItem = items[0]

                var widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: firstItem, attribute: .Width, multiplier: 1.0  , constant: 0)

                mainView.addConstraint(widthConstraint)
            }

            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }

}