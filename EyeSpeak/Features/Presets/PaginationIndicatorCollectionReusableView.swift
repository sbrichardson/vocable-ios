//
//  PaginationIndicatorCollectionReusableView.swift
//  EyeSpeak
//
//  Created by Patrick Gatewood on 2/17/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import UIKit

class PaginationIndicatorCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var paginationLabel: UILabel!
    
    var paginationDirection: PaginationDirection = .forward {
        didSet {
            updatePaginationLabel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .collectionViewBackgroundColor
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
            image = UIImage(systemName: "chevron.compact.right")
        case .backward:
            image = UIImage(systemName: "chevron.compact.left")
        }
        
        let systemImageAttachment = NSTextAttachment(image: image)
        let attributedString = NSMutableAttributedString(attachment: systemImageAttachment)
        attributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 48)], range: NSRange(location: 0, length: attributedString.length))
        paginationLabel.attributedText = attributedString
    }
    
}
