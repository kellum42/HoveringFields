//
//  HoveringTextView.swift
//  HoveringFields
//
//  Created by Travis on 8/29/18.
//  Copyright © 2018 Travis. All rights reserved.
//

import UIKit

open class HoveringTextView: HoveringField {
    
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
    
    @IBInspectable open override var textviewHeight: CGFloat {
        didSet {
            textviewHeightConstraint?.constant = textviewHeight
        }
    }
    
    @IBInspectable open override var isExpandable: Bool {
        didSet { }
    }
    
    open var isInflatable: Bool = true
    
    var isInflated: Bool = false
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if (isInflatable && !isInflated) {
            textviewHeightConstraint?.constant = textview.font!.lineHeight + 10
        }
    }
    
    open override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        
        if isInflatable && !isInflated {
            isInflated = true
            textviewHeightConstraint?.constant = textviewHeight
            layoutIfNeeded()
        }
    }
}
