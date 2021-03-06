//
//  PaginationCollectionViewCell.swift
//  Vocable AAC
//
//  Created by Patrick Gatewood on 2/18/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import UIKit
import Combine

class PaginationCollectionViewCell: VocableCollectionViewCell {
    
    let paginationLabel = UILabel(frame: .zero)
    
    var paginationDirection: UIPageViewController.NavigationDirection = .forward {
        didSet {
            updatePaginationLabel()
        }
    }

    override var isEnabled: Bool {
        didSet {
            updatePaginationLabel()
        }
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
        addSubview(paginationLabel)
        paginationLabel.translatesAutoresizingMaskIntoConstraints = false
        paginationLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        paginationLabel.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor).isActive = true
        paginationLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        paginationLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        paginationLabel.textAlignment = .center
        updatePaginationLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        paginationLabel.text = nil
    }

    private func updatePaginationLabel() {
        let image: UIImage!
        
        switch paginationDirection {
        case .forward:
            image = UIImage(systemName: "chevron.right")
        case .reverse:
            image = UIImage(systemName: "chevron.left")
        @unknown default:
            return
        }
        
        let systemImageAttachment = NSTextAttachment(image: image)
        let attributedString = NSMutableAttributedString(attachment: systemImageAttachment)
        let fontSize = CGFloat([traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass].contains(.compact) ? 22 : 48)
        attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: fontSize), .foregroundColor: isEnabled ? UIColor.defaultTextColor : UIColor.disabledTextColor],
                                       range: NSRange(location: 0, length: attributedString.length))
        paginationLabel.attributedText = attributedString
    }
    
}
