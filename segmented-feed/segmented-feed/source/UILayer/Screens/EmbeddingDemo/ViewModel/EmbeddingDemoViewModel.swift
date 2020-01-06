//
//  EmbeddingDemoViewModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-03-Jan-Fri.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `View` to expose to `ViewModel`
protocol EmbeddingDemoViewModelConsumer: AnyObject {
}

/// APIs for `ViewModel` to expose to `View`
protocol EmbeddingDemoViewModel: AnyObject {
    func setViewModelConsumer(_ newValue: EmbeddingDemoViewModelConsumer)
}

class EmbeddingDemoViewModelImpl: EmbeddingDemoViewModel, EmbeddingDemoModelConsumer {
    
    // MARK: - Properties
    private let model: EmbeddingDemoModel
    private weak var viewModelConsumer: EmbeddingDemoViewModelConsumer!
    
    // MARK: - Initialization
    required init(model: EmbeddingDemoModel) {
        self.model = model
        self.model.setModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - EmbeddingDemoViewModel protocol
    func setViewModelConsumer(_ newValue: EmbeddingDemoViewModelConsumer) {
        self.viewModelConsumer = newValue
    }
    
    // MARK: - EmbeddingDemoModelConsumer protocol
}

