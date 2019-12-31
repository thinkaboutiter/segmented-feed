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
    var segments: [Segment] { get }
    var selectedSegment: Segment { get }
    func setSelectedSegment(_ newValue: Segment)
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
    
    var segments: [Segment] {
        let result: [Segment] = Segment.allCases
        return result
    }
    
    private(set) var selectedSegment: Segment = Segment.allCases.first!
    func setSelectedSegment(_ newValue: Segment) {
        self.selectedSegment = newValue
        Logger.cache.message().object(newValue)
    }
}
