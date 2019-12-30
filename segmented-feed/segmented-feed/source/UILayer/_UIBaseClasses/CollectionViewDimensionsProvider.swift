//
//  CollectionViewDimensionsProvider.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

protocol CollectionViewDimensionsProvider {
    var minimumInteritemSpacing: CGFloat { get }
    var minimumLineSpacing: CGFloat { get }
    var sectionEdgeInsets: UIEdgeInsets { get }
}
