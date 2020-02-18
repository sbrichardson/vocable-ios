//
//  PaginationIndicatorCollectionReusableView.swift
//  EyeSpeak
//
//  Created by Patrick Gatewood on 2/17/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import UIKit

class PaginationIndicatorCollectionReusableView: UICollectionReusableView {
    
    // TODO: use another common type, not just hot corner expanding ui control
    @IBOutlet weak var paginationButton: HotCornerExpandingUIControl!
    @IBOutlet weak var borderedView: BorderedView!
    
    override var canReceiveGaze: Bool { true }
    
    var paginationDirection: PaginationDirection = .forward {
        didSet {
            updatePaginationLabel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updatePaginationLabel()
        paginationButton.backgroundColor = .categoryBackgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        paginationButton.setAttributedTitle(nil, for: .normal)
    }
    
    private func updatePaginationLabel() {
        let image: UIImage!
        
        switch paginationDirection {
        case .forward:
            image = UIImage(systemName: "chevron.right")
        case .backward:
            image = UIImage(systemName: "chevron.left")
        }
        
        let systemImageAttachment = NSTextAttachment(image: image)
        let attributedString = NSMutableAttributedString(attachment: systemImageAttachment)
        attributedString.addAttributes([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 48)], range: NSRange(location: 0, length: attributedString.length))
        paginationButton.setAttributedTitle(attributedString, for: .normal)
    }
    
}
