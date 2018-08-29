//
//  HoveringField.swift
//  HoveringFields
//
//  Created by Travis on 8/29/18.
//  Copyright © 2018 Travis. All rights reserved.
//


import UIKit

open class HoveringField: PlaceholderTextView {
    
    var highlightedTitleColor = UIColor.blue
    
    var titleColor = UIColor.gray
    
    var titleFontSize: CGFloat = 15
    
    var borderColor = UIColor.black
    
    var title = "Example Title"

    lazy var bottomBorder: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = borderColor
        addSubview(v)
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: titleFontSize, weight: .semibold)
        l.textColor = titleColor
        l.text = title
        l.alpha = 0
        addSubview(l)
        return l
    }()
    
    private var savedTextCount: Int = 0
    
    open var placeholderTopConstant: CGFloat = 7
    
    open var titleLabelBottomConstant: CGFloat = 0
    
    open var borderHeight: CGFloat = 1
    
    open override func setup() {
        backgroundColor = nil
        isExpandable = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.setContentCompressionResistancePriority(.init(1000), for: .vertical)
        
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleLabelBottomConstant).isActive = true
        textview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textviewHeightConstraint = textview.heightAnchor.constraint(equalToConstant: textviewHeight)
        textviewHeightConstraint?.isActive = true
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.topAnchor.constraint(equalTo: textview.bottomAnchor, constant: 5).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: borderHeight).isActive = true
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: textview.leadingAnchor, constant: 5).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: textview.topAnchor, constant: placeholderTopConstant).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: textview.trailingAnchor, constant: 0).isActive = true
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        textviewHeightConstraint?.constant = textviewHeight
    }
    
    enum AnimateStyle {
        case show, hide
    }
    
    override open func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        
        if textView.text.count == 0 {
            animateTitle(.hide)
            
        } else if textView.text.count == 1 && textView.text.count > savedTextCount {
            animateTitle(.show)
        }
        savedTextCount = textView.text.count
    }
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.count > 0 {
            titleLabel.textColor = highlightedTitleColor
        }
    }
    
    open func textViewDidEndEditing(_ textView: UITextView) {
        titleLabel.textColor = titleColor
    }
    
    private func animateTitle(_ style: AnimateStyle){
        
        titleLabel.alpha = (style == .show) ? 0 : 1
        titleLabel.transform = (style == .show) ? CGAffineTransform(translationX: 0, y: 10) : .identity
        
        let transform = (style == .show) ? .identity : CGAffineTransform(translationX: 0, y: 10)
        let alpha: CGFloat = (style == .show) ? 1 : 0
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.titleLabel.alpha = alpha
            self?.titleLabel.transform = transform
            
            }, completion: { _ in
                self.titleLabel.textColor = (style == .show) ? self.highlightedTitleColor : self.titleColor
        })
    }
}
