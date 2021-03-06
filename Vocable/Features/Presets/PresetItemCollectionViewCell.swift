//
//  PresetItemCollectionViewCell.swift
//  Vocable AAC
//
//  Created by Patrick Gatewood on 1/28/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import UIKit

class PresetItemCollectionViewCell: VocableCollectionViewCell {
    let textLabel = UILabel(frame: .zero)
    
    override func updateContentViews() {
        super.updateContentViews()

        let textColor: UIColor = {
            if isSelected {
                return .selectedTextColor
            }
            if !isEnabled {
                return .disabledTextColor
            }
            return .defaultTextColor
        }()

        textLabel.textColor = textColor
        textLabel.backgroundColor = .clear
        textLabel.isOpaque = true
        textLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.5
        textLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        textLabel.textAlignment = .center
        updateContentViews()
    }

    func setup(title: String) {
        textLabel.text = title
        updateContentViews()
    }
    
    func setup(with image: UIImage?) {
        guard let image = image else {
            return
        }
        
        let systemImageAttachment = NSTextAttachment(image: image)
        let attributedString = NSAttributedString(attachment: systemImageAttachment)
        
        textLabel.attributedText = attributedString
        updateContentViews()
    }
}

class CategoryItemCollectionViewCell: PresetItemCollectionViewCell {
    
    var roundedCorners: UIRectCorner = .allCorners {
        didSet {
            borderedView.roundedCorners = roundedCorners
        }
    }
    
    override func updateContentViews() {
        super.updateContentViews()
        borderedView.fillColor = isSelected ? .cellSelectionColor : .categoryBackgroundColor
        borderedView.backgroundColor = (traitCollection.verticalSizeClass == .compact
            || traitCollection.horizontalSizeClass == .compact)
            ? .collectionViewBackgroundColor : .categoryBackgroundColor
        
        textLabel.textColor = isSelected ? .selectedTextColor : .defaultTextColor
        textLabel.backgroundColor = borderedView.fillColor
        textLabel.isOpaque = true
        textLabel.font = .systemFont(ofSize: 22, weight: .bold)
    }
}
