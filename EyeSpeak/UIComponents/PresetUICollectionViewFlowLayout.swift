//
//  PresetUICollectionViewFlowLayout.swift
//  EyeSpeak
//
//  Created by Jesse Morgan on 2/4/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import UIKit

class PresetUICollectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
    
    var dataSource: UICollectionViewDiffableDataSource<TextSelectionViewController.Section, TextSelectionViewController.ItemWrapper>? {
        self.collectionView?.dataSource as? UICollectionViewDiffableDataSource<TextSelectionViewController.Section, TextSelectionViewController.ItemWrapper>
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        // Make animation only happen for preset items
        guard let item = dataSource?.itemIdentifier(for: itemIndexPath) else {
            return attr
        }
        
        switch item {
        case .textField(let text):
            let presetItem = TextSelectionViewController.ItemWrapper.presetItem(text)
            guard let presetIndexPath = dataSource?.indexPath(for: presetItem) else { break }
            guard let presetAttr = self.layoutAttributesForItem(at: presetIndexPath) else { break }
            attr?.alpha = 1.0
            attr?.center = presetAttr.center
            attr?.size = presetAttr.size
            attr?.zIndex = 1000
        case .presetItem(_):
            attr?.transform = CGAffineTransform(translationX: 0, y: 500.0)
        default:
            break
        }
        return attr
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        // Make animation only happen for preset items
        guard let item = dataSource?.itemIdentifier(for: itemIndexPath), case TextSelectionViewController.ItemWrapper.presetItem(_) = item else {
            return attr
        }
        attr?.transform = CGAffineTransform(translationX: 0, y: 500.0)
        return attr
    }
    
}
