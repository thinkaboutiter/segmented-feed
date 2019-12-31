//
//  SegmentsCollecionView.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

class SegmentsCollectionView: BaseCollectionView {}

protocol SegmentsCollectionViewDimentionProvider: CollectionViewDimensionsProvider {
    var textHorizontallPadding: CGFloat { get }
}

// MARK: - CollectionViewDimensionsProvider protocol
extension SegmentsCollectionView: SegmentsCollectionViewDimentionProvider {
    
    var minimumInteritemSpacing: CGFloat {
        return Dimensions.minimumInteritemSpacing
    }
    
    var minimumLineSpacing: CGFloat {
        return Dimensions.minimumLineSpacing
    }
    
    var sectionEdgeInsets: UIEdgeInsets {
        return Dimensions.sectionEdgeInsets
    }
    
    var textHorizontallPadding: CGFloat {
        return Dimensions.textHorizontalPadding
    }
}

// MARK: - Dimensions
extension SegmentsCollectionView {
    
    private enum Dimensions {
        static let offset: CGFloat = 8
        static let textHorizontalPadding: CGFloat = 16
        
        static let minimumInteritemSpacing: CGFloat = Dimensions.offset
        static let minimumLineSpacing: CGFloat = Dimensions.offset
        static var sectionEdgeInsets: UIEdgeInsets {
            return UIEdgeInsets(top: Dimensions.offset,
                                left: Dimensions.offset,
                                bottom: Dimensions.offset,
                                right: Dimensions.offset)
        }
    }
}
