//
//  CollectionViewDimensionsProvider.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

protocol CollectionViewDimensionsProvider {
    var leadingOffset: CGFloat { get }
    var trailingOffset: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }
    var minimumLineSpacing: CGFloat { get }
    var itemWidthToHeightRatio: CGFloat { get }
    var sectionEdgeInsets: UIEdgeInsets { get }
}
