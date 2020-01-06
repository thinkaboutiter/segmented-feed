//
//  FeedItem.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-05-Jan-Sun.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation

protocol FeedItem {
    var title: String { get }
}

enum Color: CaseIterable, FeedItem {
    case red
    case green
    case blue
    case yellow
    case black
    case white
    
    var title: String {
        let result: String
        switch self {
        case .red:
            result = NSLocalizedString("FeedItem.Color.red",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .green:
            result = NSLocalizedString("FeedItem.Color.green",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .blue:
            result = NSLocalizedString("FeedItem.Color.blue",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .yellow:
            result = NSLocalizedString("FeedItem.Color.yellow",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .black:
            result = NSLocalizedString("FeedItem.Color.black",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .white:
            result = NSLocalizedString("FeedItem.Color.white",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        }
        return result
    }
}

enum TropicFruit: CaseIterable, FeedItem {
    case lemon
    case orange
    case bannana
    case coconut
    case mango
    case papaya
    
    var title: String {
        let result: String
        switch self {
        case .lemon:
            result = NSLocalizedString("FeedItem.TropicFruit.lemon",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .orange:
            result = NSLocalizedString("FeedItem.TropicFruit.orange",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .bannana:
            result = NSLocalizedString("FeedItem.TropicFruit.bannana",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .coconut:
            result = NSLocalizedString("FeedItem.TropicFruit.coconut",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .mango:
            result = NSLocalizedString("FeedItem.TropicFruit.mango",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .papaya:
            result = NSLocalizedString("FeedItem.TropicFruit.papaya",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        }
        return result
    }
}

enum Shape: CaseIterable, FeedItem {
    case cirlce
    case triangle
    case square
    case rectangle
    case elipse
    case pentagon
    
    var title: String {
        let result: String
        switch self {
        case .cirlce:
            result = NSLocalizedString("FeedItem.Shape.cirlce",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .triangle:
            result = NSLocalizedString("FeedItem.Shape.triangle",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .square:
            result = NSLocalizedString("FeedItem.Shape.square",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .rectangle:
            result = NSLocalizedString("FeedItem.Shape.rectangle",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .elipse:
            result = NSLocalizedString("FeedItem.Shape.elipse",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .pentagon:
            result = NSLocalizedString("FeedItem.Shape.pentagon",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        }
        return result
    }
}

enum Vegetable: CaseIterable, FeedItem {
    case cucumber
    case tomato
    case potato
    case onion
    case mushroom
    case spinach
    
    var title: String {
        let result: String
        switch self {
        case .cucumber:
            result = NSLocalizedString("FeedItem.Vegetable.cucumber",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .tomato:
            result = NSLocalizedString("FeedItem.Vegetable.tomato",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .potato:
            result = NSLocalizedString("FeedItem.Vegetable.potato",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .onion:
            result = NSLocalizedString("FeedItem.Vegetable.onion",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .mushroom:
            result = NSLocalizedString("FeedItem.Vegetable.mushroom",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .spinach:
            result = NSLocalizedString("FeedItem.Vegetable.spinach",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        }
        return result
    }
}

enum Planet: CaseIterable, FeedItem {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    
    var title: String {
        let result: String
        switch self {
        case .mercury:
            result = NSLocalizedString("FeedItem.Planet.mercury",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .venus:
            result = NSLocalizedString("FeedItem.Planet.venus",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .earth:
            result = NSLocalizedString("FeedItem.Planet.earth",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .mars:
            result = NSLocalizedString("FeedItem.Planet.mars",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .jupiter:
            result = NSLocalizedString("FeedItem.Planet.jupiter",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        case .saturn:
            result = NSLocalizedString("FeedItem.Planet.saturn",
                                       comment: AppConstants.LocalizedStringComment.feedTitle)
        }
        return result
    }
}
