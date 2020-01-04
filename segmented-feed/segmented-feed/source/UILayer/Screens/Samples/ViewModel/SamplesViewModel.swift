//
//  SamplesViewModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-04-Jan-Sat.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `View` to expose to `ViewModel`
protocol SamplesViewModelConsumer: AnyObject {
}

/// APIs for `ViewModel` to expose to `View`
protocol SamplesViewModel: AnyObject {
    func setViewModelConsumer(_ newValue: SamplesViewModelConsumer)
}

class SamplesViewModelImpl: SamplesViewModel, SamplesModelConsumer {
    
    // MARK: - Properties
    private let model: SamplesModel
    private weak var viewModelConsumer: SamplesViewModelConsumer!
    
    // MARK: - Initialization
    required init(model: SamplesModel) {
        self.model = model
        self.model.setModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - SamplesViewModel protocol
    func setViewModelConsumer(_ newValue: SamplesViewModelConsumer) {
        self.viewModelConsumer = newValue
    }
    
    // MARK: - SamplesModelConsumer protocol
}

