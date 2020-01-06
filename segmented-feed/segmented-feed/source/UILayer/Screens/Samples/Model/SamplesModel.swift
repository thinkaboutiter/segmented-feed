//
//  SamplesModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-04-Jan-Sat.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `ViewModel` to expose to `Model`
protocol SamplesModelConsumer: AnyObject {
    init(model: SamplesModel)
}

/// APIs for `Model` to expose to `ViewModel`
protocol SamplesModel: AnyObject {
    func setModelConsumer(_ newValue: SamplesModelConsumer)
    var samples: [Sample] { get }
}

class SamplesModelImpl: SamplesModel {
    
    // MARK: - Properties
    private weak var modelConsumer: SamplesModelConsumer!
    
    // MARK: - Initialization
    init(samples: [Sample]) {
        self.samples = samples
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - SamplesModel protocol
    func setModelConsumer(_ newValue: SamplesModelConsumer) {
        self.modelConsumer = newValue
    }
    
    let samples: [Sample]
}
