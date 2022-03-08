//
//  SJCenterFlowLayout.swift
//  FinchLists
//
//  Created by Vladimir Pchelyakov on 06.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

enum SJCenterFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
}

enum SJCenterFlowLayoutSectionInset {
    case center
    case custom(UIEdgeInsets)
    case none
}

enum SJCenterFlowLayoutAnimation {
    case scale(sideItemScale: CGFloat, sideItemAlpha: CGFloat, sideItemShift: CGFloat)
    case none
}

final class SJCenterFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Types
    
    private struct LayoutState {
        
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        
        func isEqual(_ otherState: LayoutState) -> Bool {
            size.equalTo(otherState.size) && direction == otherState.direction
        }
        
    }
    
    
    // MARK: - Properties
    
    var sectionInsetsType = SJCenterFlowLayoutSectionInset.center
    var spacingMode = SJCenterFlowLayoutSpacingMode.fixed(spacing: 10)
    var animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.7, sideItemAlpha: 0.6, sideItemShift: 0)
    
    /// Calculates the current centered page.
    var currentCenteredIndexPath: IndexPath? {
        
        guard let collectionView = collectionView else {
            return nil
        }
        
        let currentCenteredPoint = CGPoint(
            x: collectionView.contentOffset.x + collectionView.bounds.width / 2,
            y: collectionView.contentOffset.y + collectionView.bounds.height / 2
        )
        
        return collectionView.indexPathForItem(at: currentCenteredPoint)
    }
    
    var currentCenteredPage: Int? {
        currentCenteredIndexPath?.row
    }
    
    private var state = LayoutState(size: .zero, direction: .horizontal)
    
    private var cellSpacing: CGFloat {
        scrollDirection == .horizontal ? minimumInteritemSpacing : minimumLineSpacing
    }
    
    private var pageWidth: CGFloat {
        itemSize.width + minimumLineSpacing
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        let currentState = LayoutState(size: collectionView.bounds.size, direction: scrollDirection)
        
        if !state.isEqual(currentState) {
            setupCollectionView()
            updateLayout()
            state = currentState
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else {
            return nil
        }
        
        return attributes.map { transformLayoutAttributes($0) }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView,
              !collectionView.isPagingEnabled,
              let layoutAttributes = layoutAttributesForElements(in: collectionView.bounds)
        else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let midSide = collectionView.bounds.size.width / 2
        let proposedCenterOffset = proposedContentOffset.x + midSide
        
        var targetContentOffset: CGPoint
        let closest = layoutAttributes.sorted {
            abs($0.center.x - proposedCenterOffset) < abs($1.center.x - proposedCenterOffset)
        }.first ?? UICollectionViewLayoutAttributes()
        
        switch sectionInsetsType {
        
        case .center:
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
            
        case .custom, .none:
            targetContentOffset = CGPoint(
                x: floor(closest.center.x - midSide + cellSpacing),
                y: proposedContentOffset.y
            )
        }
        
        return targetContentOffset
    }
    
    
    // MARK: - Public methods
    
    /// Programmatically scrolls to a page at a specified index.
    ///
    /// - Parameters:
    ///   - index: The index of the page to scroll to.
    ///   - animated: Whether the scroll should be performed animated.
    func scrollToPage(atIndex index: Int, animated: Bool = true) {
        
        guard let collectionView = collectionView else {
            return
        }
        
        let proposedContentOffset: CGPoint
        let shouldAnimate: Bool
        
        var pageOffset: CGFloat
        
        switch sectionInsetsType {
        
        case .center:
            pageOffset = CGFloat(index) * pageWidth - collectionView.contentInset.left
            
        case let .custom(insets):
            let xInset = (collectionView.bounds.size.width - itemSize.width) / 2
            // Метод getLastIndexPath реализован в FinchExtensions!
            let isLastIndex = collectionView.getLastIndexPath().row == index
            
            pageOffset = (CGFloat(index) * pageWidth) + cellSpacing - xInset + (isLastIndex ? 0 : insets.left)
            
        case .none:
            let xInset = (collectionView.bounds.size.width - itemSize.width) / 2
            pageOffset = (CGFloat(index) * pageWidth) + minimumLineSpacing - xInset
            
            guard collectionView.numberOfSections == 1 else {
                fatalError("Надо бы переписать эту реализацию")
            }
            
            let itemsCount = collectionView.numberOfItems(inSection: 0)
            
            if index == 1 {
                pageOffset += collectionView.contentInset.left
                
            } else if index == 0 {
                pageOffset += xInset + collectionView.contentInset.left - minimumLineSpacing
                
            } else if index == (itemsCount - 1) {
                
                pageOffset = (itemSize.width * CGFloat(index)) - xInset
            }
        }
        
        proposedContentOffset = CGPoint(x: pageOffset, y: collectionView.contentOffset.y)
        shouldAnimate = abs(collectionView.contentOffset.x - pageOffset) > 1 ? animated : false
        
        if shouldAnimate {
            collectionView.setContentOffset(proposedContentOffset, animated: shouldAnimate)
        } else {
            collectionView.contentOffset = proposedContentOffset
        }
    }
    
    
    // MARK: - Private methods
    
    private func setupCollectionView() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    private func updateLayout() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        let collectionSize = collectionView.bounds.size
        
        switch sectionInsetsType {
        
        case .center:
            let yInset = (collectionSize.height - itemSize.height) / 2
            let xInset = (collectionSize.width - itemSize.width) / 2
            sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
            
        case .custom(let inset):
            sectionInset = inset
            
        case .none:
            sectionInset = .zero
        }
        
        
        let side = itemSize.width
        let scale: CGFloat
        
        switch animationMode {
        
        case .scale(let sideItemScale, _, _):
            scale = sideItemScale
            
        case .none:
            scale = 1
        }
        
        let scaledItemOffset = (side - side * scale) / 2
        
        switch spacingMode {
        
        case .fixed(let spacing):
            minimumLineSpacing = spacing - scaledItemOffset
        }
    }
    
    private func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes { // swiftlint:disable:this line_length
        
        guard let collectionView = collectionView else {
            return attributes
        }
        
        let collectionCenter: CGFloat = collectionView.frame.size.width / 2
        let offset = collectionView.contentOffset.x
        let normalizedCenter = attributes.center.x - offset
        
        let maxDistance = itemSize.width + minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        var sideItemShift: CGFloat = 0
        
        switch animationMode {
        
        case .scale(let sideItemScale, let sideItemAlpha, let shift):
            sideItemShift = shift
            
            let alpha = ratio * (1 - sideItemAlpha) + sideItemAlpha
            let scale = ratio * (1 - sideItemScale) + sideItemScale
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.2)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))
            attributes.alpha = alpha
            attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
            attributes.zIndex = Int(alpha * 10)
            CATransaction.commit()
            
        case .none:
            break
        }
        
        let shift = (1 - ratio) * sideItemShift
        attributes.center.y += shift
        
        return attributes
    }
    
}
