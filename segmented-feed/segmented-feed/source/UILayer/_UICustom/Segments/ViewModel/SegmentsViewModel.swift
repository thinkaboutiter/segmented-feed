//
//  SegmentsViewModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-27-Dec-Fri.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `View` to expose to `ViewModel`
protocol SegmentsViewModelConsumer: AnyObject {
}

/// APIs for `ViewModel` to expose to `View`
protocol SegmentsViewModel: AnyObject {
    func setViewModelConsumer(_ newValue: SegmentsViewModelConsumer)
    var segments: [Segment] { get }
}

class SegmentsViewModelImpl: SegmentsViewModel, SegmentsModelConsumer {
    
    // MARK: - Properties
    private let model: SegmentsModel
    private weak var viewModelConsumer: SegmentsViewModelConsumer!
    
    // MARK: - Initialization
    required init(model: SegmentsModel) {
        self.model = model
        self.model.setModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - SegmentsViewModel protocol
    func setViewModelConsumer(_ newValue: SegmentsViewModelConsumer) {
        self.viewModelConsumer = newValue
    }
    
    var segments: [Segment] {
        return self.model.segments
    }
    
    // MARK: - SegmentsModelConsumer protocol
}
