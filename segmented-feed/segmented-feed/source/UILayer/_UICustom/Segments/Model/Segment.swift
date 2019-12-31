//
//  Segment.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

enum Segment: CaseIterable {
    case cars
    case bananas
    case dogs
    case chocolates
    case cats
    
    var title: String {
        let result: String
        switch self {
        case .cars:
            result = NSLocalizedString("segment.title.cars", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .bananas:
            result = NSLocalizedString("segment.title.bananas", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .dogs:
            result = NSLocalizedString("segment.title.dogs", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .chocolates:
            result = NSLocalizedString("segment.title.chocolates", comment: AppConstants.LocalizedStringComment.segmentTitle)
        case .cats:
            result = NSLocalizedString("segment.title.cats", comment: AppConstants.LocalizedStringComment.segmentTitle)
        }
        return result
    }
    
    var color: UIColor {
        return .purple
    }
}
