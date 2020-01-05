//
//  EmbeddingDemoModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-03-Jan-Fri.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `ViewModel` to expose to `Model`
protocol EmbeddingDemoModelConsumer: AnyObject {
    init(model: EmbeddingDemoModel)
}

/// APIs for `Model` to expose to `ViewModel`
protocol EmbeddingDemoModel: AnyObject {
    func setModelConsumer(_ newValue: EmbeddingDemoModelConsumer)
}

class EmbeddingDemoModelImpl: EmbeddingDemoModel {
    
    // MARK: - Properties
    private weak var modelConsumer: EmbeddingDemoModelConsumer!
    
    // MARK: - Initialization
    init() {
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - EmbeddingDemoModel protocol
    func setModelConsumer(_ newValue: EmbeddingDemoModelConsumer) {
        self.modelConsumer = newValue
    }
}
