//
//  DefaultButton.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/17/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//


import UIKit

// MARK: - DefaultButton: Button

class DefaultButton: UIButton {
    
    // MARK: Properties
    
    let defaultBorderWidth: CGFloat = 1.0
    let defaultBorderColer = UIColor.blackColor().CGColor
    let defaultButtonCornerRadius: CGFloat = 3.0
    let defaultButtonTopBottomPadding: CGFloat = 5.0
    let defaultButtonLeftRightPadding: CGFloat = 10.0
    let defaultButtonFontSize: CGFloat = 18.0
    
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        defaultButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultButton()
    }
    
    private func defaultButton() {
        layer.masksToBounds = true
        contentEdgeInsets = UIEdgeInsetsMake(defaultButtonTopBottomPadding, defaultButtonLeftRightPadding, defaultButtonTopBottomPadding,defaultButtonLeftRightPadding)
        layer.cornerRadius = defaultButtonCornerRadius
        layer.borderWidth = defaultBorderWidth
        layer.borderColor = defaultBorderColer
        titleLabel?.font = UIFont.systemFontOfSize(defaultButtonFontSize)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    
}