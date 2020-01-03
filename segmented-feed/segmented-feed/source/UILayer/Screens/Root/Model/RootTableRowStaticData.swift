//
//  RootTableRowStaticData.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-03-Jan-Fri.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation

enum RootTableRowStaticData: CaseIterable {
    case embeddingDemo
    case tableViewEmbedding
    case containerControllerEmbedding
}

// MARK: - Titles
extension RootTableRowStaticData {
    
    var title: String {
        let result: String
        switch self {
        case .embeddingDemo:
            result = NSLocalizedString("RootTableRowStaticData.title.embeddingDemo", comment: AppConstants.LocalizedStringComment.rowTitle)
        case .tableViewEmbedding:
            result = NSLocalizedString("RootTableRowStaticData.title.tableViewEmbedding", comment: AppConstants.LocalizedStringComment.rowTitle)
        case .containerControllerEmbedding:
            result = NSLocalizedString("RootTableRowStaticData.title.containerControllerEmbedding", comment: AppConstants.LocalizedStringComment.rowTitle)
        }
        return result
    }
}
