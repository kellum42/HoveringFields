//
//  PlaceholderTextView.swift
//  HoveringFields
//
//  Created by Travis on 8/29/18.
//  Copyright © 2018 Travis. All rights reserved.
//

import UIKit

open class PlaceholderTextView: UIView, UITextViewDelegate {
    
    var textviewHeightConstraint: NSLayoutConstraint?
    
    var textColor: UIColor = .black
    
    var placeholder: String = "Example Title"
    
    var placeholderColor: UIColor = .gray
    
    var fontSize: CGFloat = 17
    
    var textviewHeight: CGFloat = 200
    
//    var maxHeight: CGFloat?
    
    open var text: String {
        get {
            return textview.text
        }
        set {
            textview.text = text
        }
    }
    
    //   Callbacks
    open var textviewDidChange: ((UITextView) -> Void)?  // Args: Textview Text
    
    lazy var textview: UITextView = {
        let t = UITextView(frame: .zero)
        t.delegate = self
        t.font = UIFont.systemFont(ofSize: fontSize)
        t.textColor = textColor
        t.text = ""
        t.backgroundColor = nil
        addSubview(t)
        return t
    }()
    
    lazy var placeholderLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.text = placeholder
        l.font = textview.font!
        l.textColor = placeholderColor
        addSubview(l)
        return l
    }()
    
    open var isExpandable: Bool = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup(){
        backgroundColor = nil
        
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textviewHeightConstraint = textview.heightAnchor.constraint(equalToConstant: textviewHeight)
        textviewHeightConstraint?.isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
    }
    
    open func textViewDidChange(_ textView: UITextView) {
        if isExpandable {
//            let max: CGFloat = maxHeight ?? 999 // some unlimited value
            let  max = textviewHeight
            if textView.contentSize.height <= max {
                textviewHeightConstraint?.constant = textView.contentSize.height
                textview.layoutIfNeeded()
            }
        }
        
        placeholderLabel.isHidden = textView.text.count > 0
        textviewDidChange?(textView)
    }
}
