//
//  FeedViewModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-05-Jan-Sun.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `View` to expose to `ViewModel`
protocol FeedViewModelConsumer: AnyObject {
}

/// APIs for `ViewModel` to expose to `View`
protocol FeedViewModel: AnyObject {
    func setViewModelConsumer(_ newValue: FeedViewModelConsumer)
}

class FeedViewModelImpl: FeedViewModel, FeedModelConsumer {
    
    // MARK: - Properties
    private let model: FeedModel
    private weak var viewModelConsumer: FeedViewModelConsumer!
    
    // MARK: - Initialization
    required init(model: FeedModel) {
        self.model = model
        self.model.setModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - FeedViewModel protocol
    func setViewModelConsumer(_ newValue: FeedViewModelConsumer) {
        self.viewModelConsumer = newValue
    }
    
    // MARK: - FeedModelConsumer protocol
}
