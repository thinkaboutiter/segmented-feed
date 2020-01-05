//
//  Segment.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

protocol Segment {
    var title: String { get }
    var color: UIColor? { get }
}

enum DemoSegment: CaseIterable, Segment {
    case colors
    case tropicFruits
    case shapes
    case vegetables
    case planets
    
    var title: String {
        let result: String
        switch self {
        case .colors:
            result = NSLocalizedString("DemoSegment.title.colors", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .tropicFruits:
            result = NSLocalizedString("DemoSegment.title.tropicFruits", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .shapes:
            result = NSLocalizedString("DemoSegment.title.shapes", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .vegetables:
            result = NSLocalizedString("DemoSegment.title.vegetables", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .planets:
            result = NSLocalizedString("DemoSegment.title.planets", comment: AppConstants.LocalizedStringComment.segmentTitle)
        }
        return result
    }
    
    var color: UIColor? {
        return UIColor(named: AppConstants.CustomColorName.demoSegmentBackgroundColor)
    }
}
