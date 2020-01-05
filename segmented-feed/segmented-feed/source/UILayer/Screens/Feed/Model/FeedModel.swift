//
//  FeedModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-05-Jan-Sun.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `ViewModel` to expose to `Model`
protocol FeedModelConsumer: AnyObject {
    init(model: FeedModel)
}

/// APIs for `Model` to expose to `ViewModel`
protocol FeedModel: AnyObject {
    func setModelConsumer(_ newValue: FeedModelConsumer)
}

class FeedModelImpl: FeedModel {
    
    // MARK: - Properties
    private weak var modelConsumer: FeedModelConsumer!
    
    // MARK: - Initialization
    init() {
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - FeedModel protocol
    func setModelConsumer(_ newValue: FeedModelConsumer) {
        self.modelConsumer = newValue
    }
}
