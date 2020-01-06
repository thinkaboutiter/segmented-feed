//
//  Sample.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-03-Jan-Fri.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation

enum Sample: CaseIterable {
    case embeddingDemo
    case tableViewEmbedding
}

// MARK: - Titles
extension Sample {
    
    var title: String {
        let result: String
        switch self {
        case .embeddingDemo:
            result = NSLocalizedString("Sample.title.embeddingDemo", comment: AppConstants.LocalizedStringComment.rowTitle)
        case .tableViewEmbedding:
            result = NSLocalizedString("Sample.title.tableViewEmbedding", comment: AppConstants.LocalizedStringComment.rowTitle)
        }
        return result
    }
}
