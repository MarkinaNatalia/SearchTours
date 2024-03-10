//
//  TagItemLabel.swift
//  SearchTours
//
//  Created by Наталья on 06.03.2024.
//

import UIKit

final class TagItemLabel: UILabel {
    var leftInset: CGFloat
    var topInset: CGFloat
    var rightInset: CGFloat
    var bottomInset: CGFloat
    
    // MARK: Initialization

    init(leftInset: CGFloat, 
         topInset: CGFloat,
         rightInset: CGFloat,
         bottomInset: CGFloat) {
        self.leftInset = leftInset
        self.topInset = topInset
        self.rightInset = rightInset
        self.bottomInset = bottomInset
        
        super.init(frame: .zero)
        
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overriding
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, 
                                  left: leftInset,
                                  bottom: bottomInset,
                                  right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    // MARK: Setup settings
    
    private func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customColor(.lightGrayColor)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        font = .customFont(.medium, size: 12)
        textColor = .customColor(.grayColor)
    }
}
