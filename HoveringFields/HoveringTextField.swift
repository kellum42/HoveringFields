//
//  HoveringTextField.swift
//  HoveringFields
//
//  Created by Travis on 8/29/18.
//  Copyright © 2018 Travis. All rights reserved.
//

import UIKit

open class HoveringTextField: HoveringField {
    
    @IBInspectable open override var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable open override var titleColor: UIColor {
        didSet { }
    }
    
    @IBInspectable open override var highlightedTitleColor: UIColor {
        didSet { }
    }
    
    @IBInspectable open override var titleFontSize: CGFloat {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: titleFontSize, weight: .semibold)
        }
    }
    
    @IBInspectable open override var placeholder: String {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable open override var placeholderColor: UIColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    @IBInspectable open override var textColor: UIColor {
        didSet {
            textview.textColor = textColor
        }
    }
    
    @IBInspectable open override var fontSize: CGFloat {
        didSet {
            textview.font = UIFont.systemFont(ofSize: fontSize)
            placeholderLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    @IBInspectable open override var borderColor: UIColor {
        didSet {
            bottomBorder.backgroundColor = borderColor
        }
    }
    
    open override func setup() {
        textviewHeight = textview.font!.lineHeight + 5
        placeholderTopConstant = 0
        titleLabelBottomConstant = 5
        
        super.setup()
        
        textview.textContainer.maximumNumberOfLines = 1
        textview.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    override open func layoutSubviews() {
        textviewHeight = textview.font!.lineHeight + 5 // some padding on bottom
        super.layoutSubviews()
    }
}
