//
//  SegmentsCollecionView.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

class SegmentsCollectionView: BaseCollectionView {}

// MARK: - CollectionViewDimensionsProvider protocol
extension SegmentsCollectionView: CollectionViewDimensionsProvider {
    var leadingOffset: CGFloat {
        return Dimensions.leadingOffset
    }
    
    var trailingOffset: CGFloat {
        return Dimensions.trailingOffset
    }
    
    var minimumInteritemSpacing: CGFloat {
        return Dimensions.minimumInteritemSpacing
    }
    
    var minimumLineSpacing: CGFloat {
        return Dimensions.minimumLineSpacing
    }
    
    var itemWidthToHeightRatio: CGFloat {
        return Dimensions.itemWidthToHeightRatio
    }
    
    var sectionEdgeInsets: UIEdgeInsets {
        return Dimensions.sectionEdgeInsets
    }
}

// MARK: - Dimensions
extension SegmentsCollectionView {
    
    private enum Dimensions {
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = 10
        static let minimumInteritemSpacing: CGFloat = 10
        static let minimumLineSpacing: CGFloat = 10
        static let itemWidthToHeightRatio: CGFloat = 3/1
        static var sectionEdgeInsets: UIEdgeInsets {
            return UIEdgeInsets(top: self.minimumLineSpacing,
                                left: self.leadingOffset,
                                bottom: self.minimumLineSpacing,
                                right: self.trailingOffset)
        }
    }
}
