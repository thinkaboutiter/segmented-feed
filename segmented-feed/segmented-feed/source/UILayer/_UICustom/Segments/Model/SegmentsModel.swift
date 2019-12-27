//
//  SegmentsModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-27-Dec-Fri.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `ViewModel` to expose to `Model`
protocol SegmentsModelConsumer: AnyObject {
    init(model: SegmentsModel)
}

/// APIs for `Model` to expose to `ViewModel`
protocol SegmentsModel: AnyObject {
    func setModelConsumer(_ newValue: SegmentsModelConsumer)
}

class SegmentsModelImpl: SegmentsModel {
    
    // MARK: - Properties
    private weak var modelConsumer: SegmentsModelConsumer!
    
    // MARK: - Initialization
    init() {
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - SegmentsModel protocol
    func setModelConsumer(_ newValue: SegmentsModelConsumer) {
        self.modelConsumer = newValue
    }
}
