//
//  PresetUICollectionViewFlowLayout.swift
//  Vocable AAC
//
//  Created by Jesse Morgan on 2/4/20.
//  Copyright © 2020 WillowTree. All rights reserved.
//

import UIKit

class PresetCollectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
    
    // Dimensions of the product designs.
    // Intended for use in computing the fractional-size dimensions of collection layout items rather than hard-coding width/height values
    private static let totalSize = CGSize(width: 1130, height: 834)
    
    var transitioningDelegate: VocableCollectionViewLayoutTransitioningDelegate? {
        return collectionView?.delegate as? VocableCollectionViewLayoutTransitioningDelegate
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        guard let collectionView = collectionView else {
            return attr
        }

        let shouldTranslate = transitioningDelegate?.collectionView?(collectionView,
                                                        shouldTranslateEntranceAnimationForItemAt: itemIndexPath) ?? false
        if shouldTranslate {
            attr?.transform = CGAffineTransform(translationX: 0, y: 500.0)
        } else {
            attr?.transform = .identity
        }

        return attr
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)

        guard let collectionView = collectionView else {
            return attr
        }

        let shouldTranslate = transitioningDelegate?.collectionView?(collectionView,
                                                        shouldTranslateExitAnimationForItemAt: itemIndexPath) ?? false
        if shouldTranslate {
            attr?.transform = CGAffineTransform(translationX: 0, y: 500.0)
        } else {
            attr?.transform = .identity
        }
        
        return attr
    }
    
    // MARK: - Section Layouts
    
    static func topBarPresetSectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var regularWidthContainerGroupLayout: NSCollectionLayoutGroup {
            let textFieldItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
            textFieldItem.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 4)
            
            let functionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15), heightDimension: .fractionalHeight(1.0)))
            functionItem.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 4)
            
            let subitems = [textFieldItem, functionItem, functionItem]
            
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(116.0 / totalSize.height)),
                subitems: subitems)
        }
        
        var compactWidthContainerGroupLayout: NSCollectionLayoutGroup {
            let textFieldItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2 / 3)))
            
            let leadingFunctionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1.0)))
            let trailingFunctionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1.0)))
            leadingFunctionItem.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 4)
            trailingFunctionItem.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 0)

            let functionItemGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1 / 3)),
                subitems: [leadingFunctionItem, trailingFunctionItem])
            functionItemGroup.contentInsets = .init(top: 0, leading: 0, bottom: 6, trailing: 0)
            
            return NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.225)),
                subitems: [textFieldItem, functionItemGroup])
        }
        
        let containerGroup = environment.traitCollection.horizontalSizeClass == .compact && environment.traitCollection.verticalSizeClass == .regular ? compactWidthContainerGroupLayout : regularWidthContainerGroupLayout
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        
        return section
    }
    
    static func topBarKeyboardSectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var regularWidthContainerGroupLayout: NSCollectionLayoutGroup {
            let textFieldItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
            textFieldItem.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 4)
            
            let functionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.1), heightDimension: .fractionalHeight(1.0)))
            functionItem.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 4)
            
            let subitems = [textFieldItem, functionItem, functionItem, functionItem]
            
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(116.0 / totalSize.height)),
                subitems: subitems)
        }
        
        var compactWidthContainerGroupLayout: NSCollectionLayoutGroup {
            let textFieldItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2 / 3)))
            
            let leadingFunctionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1.0)))
            leadingFunctionItem.contentInsets = .init(top: 4, leading: 0, bottom: 0, trailing: 4)
            let innerFunctionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1.0)))
            innerFunctionItem.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 4)
            let trailingFunctionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1.0)))
            trailingFunctionItem.contentInsets = .init(top: 4, leading: 4, bottom: 0, trailing: 0)

            let functionItemGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1 / 3)),
                subitems: [leadingFunctionItem, innerFunctionItem, trailingFunctionItem])
            
            return NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0 / 5.0)),
                subitems: [textFieldItem, functionItemGroup])
        }
        
        let containerGroup = environment.traitCollection.horizontalSizeClass == .compact &&
            environment.traitCollection.verticalSizeClass == .regular ? compactWidthContainerGroupLayout : regularWidthContainerGroupLayout
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        
        return section
    }
    
    static func categoriesSectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let totalSectionWidth: CGFloat = 1130.0
        let traitCollection = environment.traitCollection
        
        let categoryItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1)))
        if case .compact = environment.traitCollection.horizontalSizeClass {
            categoryItem.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        }
        
        var categoryGroupFractionalWidth: NSCollectionLayoutDimension {
            if case .regular = traitCollection.horizontalSizeClass {
                return .fractionalWidth(906.0 / totalSectionWidth)
            }
            
            if traitCollection.verticalSizeClass == .compact
                && traitCollection.horizontalSizeClass == .compact {
                return .fractionalWidth(4 / 5.0)
            }
            
            return .fractionalWidth(3.0 / 5.0)
        }
        
        let categoriesGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: categoryGroupFractionalWidth,
                                               heightDimension: .fractionalHeight(1)),
            subitems: [categoryItem])
        
        var paginationItemFractionalWidth: NSCollectionLayoutDimension {
            if case .regular = traitCollection.horizontalSizeClass {
                return .fractionalWidth(104.0 / totalSectionWidth)
            }
            
            if traitCollection.verticalSizeClass == .compact
                && traitCollection.horizontalSizeClass == .compact {
                return .fractionalWidth(0.5 / 5.0)
            }
            
            return .fractionalWidth(1.0 / 5.0)
        }
        
        let paginationItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: paginationItemFractionalWidth,
                                               heightDimension: .fractionalHeight(1)))
        
        var containerGroupFractionalWidth: NSCollectionLayoutDimension {
            if case .compact = environment.traitCollection.verticalSizeClass {
                return .fractionalHeight(130.0 / totalSize.height)
            } else if environment.traitCollection.horizontalSizeClass == .compact
                && environment.traitCollection.verticalSizeClass == .regular {
                return .fractionalHeight(55.5 / totalSize.height)
            } else {
                return .fractionalHeight(116.0 / totalSize.height)
            }
        }
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: containerGroupFractionalWidth),
            subitems: [paginationItem, categoriesGroup, paginationItem])
        containerGroup.interItemSpacing = .flexible(0)
        
        var sectionContentInsets: NSDirectionalEdgeInsets {
            if environment.traitCollection.verticalSizeClass == .regular &&
                environment.traitCollection.horizontalSizeClass == .compact {
                return NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 4, trailing: 0)
            }
            return NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        }
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.contentInsets = sectionContentInsets
        
        return section
    }
    
    static func suggestiveTextSectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        var regularWidthSection: NSCollectionLayoutSection {
            let itemCount = CGFloat(4)
            
            let suggestiveTextItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / itemCount),
                                                   heightDimension: .fractionalHeight(1.0)))
            if environment.traitCollection.verticalSizeClass == .compact {
                suggestiveTextItem.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
            }
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(116.0 / totalSize.height)),
                subitem: suggestiveTextItem, count: Int(itemCount))
            if environment.traitCollection.verticalSizeClass != .compact {
                containerGroup.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
            }
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            
            if environment.traitCollection.verticalSizeClass != .compact {
                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "CategorySectionBackground")
                backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
                
                section.decorationItems = [backgroundDecoration]
            }

            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
            return section
        }
        
        var compactWidthSection: NSCollectionLayoutSection {
            let suggestiveTextItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2),
                                                   heightDimension: .fractionalHeight(1.0)))
            
            let suggestiveTextRow = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1)),
                subitem: suggestiveTextItem, count: Int(2))
            suggestiveTextRow.interItemSpacing = .fixed(8)
            
            let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1 / 6)),
            subitem: suggestiveTextRow, count: Int(2))
            containerGroup.interItemSpacing = .fixed(8)
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
            return section
        }
        
        return environment.traitCollection.horizontalSizeClass == .compact &&
            environment.traitCollection.verticalSizeClass == .regular ? compactWidthSection : regularWidthSection

    }
        
    static func presetsSectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        var regularWidthPresetGroup: NSCollectionLayoutGroup {
            let flexibleSpacing = (environment.container.contentSize.width / 10.0) * 2.0
            
            let presetPageItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(490.0 / totalSize.height)))
            
            let leadingPaginationItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(146.0 / totalSize.width), heightDimension: .fractionalHeight(1)))
            leadingPaginationItem.edgeSpacing = .init(leading: .flexible(flexibleSpacing), top: nil, trailing: nil, bottom: nil)
            
            let pageIndicatorItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(228.0 / totalSize.width), heightDimension: .fractionalHeight(1)))
            
            let trailingPaginationItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(146.0 / totalSize.width), heightDimension: .fractionalHeight(1)))
            trailingPaginationItem.edgeSpacing = .init(leading: nil, top: nil, trailing: .flexible(flexibleSpacing), bottom: nil)
            
            var paginationGroupFractionHeight: NSCollectionLayoutDimension {
                if case .compact = environment.traitCollection.verticalSizeClass {
                    return .fractionalHeight(120.0 / totalSize.height)
                }
                
                return .fractionalHeight(99.0 / totalSize.height)
            }
            
            let paginationGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: paginationGroupFractionHeight),
                subitems: [leadingPaginationItem, pageIndicatorItem, trailingPaginationItem])
            
            var containerGroupFractionalHeight: NSCollectionLayoutDimension {
                if case .compact = environment.traitCollection.verticalSizeClass {
                    return .fractionalHeight(700.0 / totalSize.height)
                }
                
                return .fractionalHeight(800.0 / totalSize.height)
            }
            
            let containerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: containerGroupFractionalHeight),
                subitems: [presetPageItem, paginationGroup])
            return containerGroup
        }
        
        let compactHeightPresetGroup = regularWidthPresetGroup
        
        var compactWidthPresetGroup: NSCollectionLayoutGroup {
            let presetPageItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(504.0 / totalSize.height)))
            
            let paginationItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 4.0), heightDimension: .fractionalHeight(1)))
            
            let pageIndicatorItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2.0 / 4.0), heightDimension: .fractionalHeight(1)))
            
            let paginationGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(99.0 / totalSize.height)),
                subitems: [paginationItem, pageIndicatorItem, paginationItem])
            paginationGroup.edgeSpacing = .init(leading: nil, top: .fixed(12), trailing: nil, bottom: nil)
            
            let containerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3.75 / 5.0)),
                subitems: [presetPageItem, paginationGroup])
            
            return containerGroup
        }
        
        let containerGroup: NSCollectionLayoutGroup
        if case .compact = environment.traitCollection.verticalSizeClass {
            containerGroup = compactHeightPresetGroup
        } else {
            containerGroup = environment.traitCollection.horizontalSizeClass == .regular ? regularWidthPresetGroup : compactWidthPresetGroup
        }
        
        containerGroup.interItemSpacing = .fixed(8)
    
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
        
        return section
    }
    
    // MARK: Keyboard Layout
    
    static func mainKeyboardLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let dimensions = computeDimensions(for: environment.traitCollection)
        return NSCollectionLayoutSection(group: keyboardGroupLayout(environment: environment, dimensions: dimensions, fractionalHeights: (compactHeight: 0.6, defaultHeight: 0.675)))
    }
    
    static func editTextKeyboardLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let dimensions = computeDimensions(for: environment.traitCollection)
        return NSCollectionLayoutSection(group: keyboardGroupLayout(environment: environment, dimensions: dimensions, fractionalHeights: (compactHeight: 0.8, defaultHeight: 0.825)))
    }
    
    static private func computeDimensions(for traitCollection: UITraitCollection) -> (rows: Int, columns: Int) {
        let dimensions: (rows: Int, columns: Int)
        let isCompactPortrait = traitCollection.horizontalSizeClass
            == .compact && traitCollection.verticalSizeClass == .regular
        
        let code = KeyboardLocale.current.languageCode
        switch code {
        case .en:
            if isCompactPortrait {
                dimensions = (rows: 5, columns: 6)
            } else {
                dimensions = (rows: 3, columns: 10)
            }
        case .de:
            if isCompactPortrait {
                dimensions = (rows: 6, columns: 6)
            } else {
                dimensions = (rows: 3, columns: 11)
            }
        }
        
        return dimensions
    }
    
    static private func keyboardGroupLayout(environment: NSCollectionLayoutEnvironment, dimensions: (rows: Int, columns: Int), fractionalHeights: (compactHeight: CGFloat, defaultHeight: CGFloat)) -> NSCollectionLayoutGroup {
        let traitCollection = environment.traitCollection
        let keyItem = PresetCollectionViewCompositionalLayout.keyboardCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(dimensions.columns)), heightDimension: .fractionalHeight(1)))
        
        // Character key group (Top 3 rows)
        let characterKeyGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: keyItem, count: dimensions.columns)
        
        let characterKeyFractionalHeight = CGFloat((traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular)
            ? 5.0 / 6.0 : 3.0 / 4.0)
        let characterKeyContainerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(characterKeyFractionalHeight)),
            subitem: characterKeyGroup, count: dimensions.rows)
        
        // Function Key Group (bottom row)
        let leadingKeyItem = PresetCollectionViewCompositionalLayout.keyboardCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(dimensions.columns)), heightDimension: .fractionalHeight(1)))
        
        let spaceKeyItem = PresetCollectionViewCompositionalLayout.keyboardCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(3.0 / CGFloat(dimensions.columns)), heightDimension: .fractionalHeight(1)))
        
        let trailingKeyItem = PresetCollectionViewCompositionalLayout.keyboardCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(dimensions.columns)), heightDimension: .fractionalHeight(1)))
        
        var defaultFunctionKeyGroup: NSCollectionLayoutGroup {
            let flexibleSpacing = (environment.container.contentSize.width / CGFloat(dimensions.columns)) * 2.0
            
            leadingKeyItem.edgeSpacing = .init(leading: .flexible(flexibleSpacing), top: nil, trailing: nil, bottom: nil)
            trailingKeyItem.edgeSpacing = .init(leading: nil, top: nil, trailing: .flexible(flexibleSpacing), bottom: nil)
            
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)),
                                                      subitems: [leadingKeyItem, spaceKeyItem, keyItem, trailingKeyItem])
        }
        
        var compactPortraitFunctionKeyGroup: NSCollectionLayoutGroup {
            let compactFunctionKeyGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15)),
                subitems: [leadingKeyItem, spaceKeyItem, keyItem, trailingKeyItem])
            
            return compactFunctionKeyGroup
        }
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            let overallContainerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(fractionalHeights.compactHeight)),
                subitems: [characterKeyContainerGroup, compactPortraitFunctionKeyGroup])
            
            return overallContainerGroup
        }
        
        let overallContainerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(fractionalHeights.defaultHeight)),
            subitems: [characterKeyContainerGroup, defaultFunctionKeyGroup])
        
        return overallContainerGroup
    }
    
    private static func keyboardCollectionLayoutItem(layoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        return item
    }
}
