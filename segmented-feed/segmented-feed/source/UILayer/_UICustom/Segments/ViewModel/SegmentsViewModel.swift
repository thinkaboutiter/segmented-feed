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
    func segment(for indexPath: IndexPath) throws -> Segment
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
    
    func segment(for indexPath: IndexPath) throws -> Segment {
        let index: Int = indexPath.row
        let segments: [Segment] = self.segments
        let range: Range<Int> = 0..<segments.count
        guard range ~= index
        else {
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCode.indexOutOfBounds,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: "index=\(index) out of range=\(range)!"
            ])
            throw error
        }
        let result: Segment = segments[index]
        return result
    }
    
    // MARK: - SegmentsModelConsumer protocol
}

// MARK: - Errors
private extension SegmentsViewModelImpl {
    
    enum ErrorConstants {
        static let errorDomainName: String = "\(AppConstants.projectName).\(String(describing: SegmentsViewModelImpl.self))"
        
        enum ErrorCode {
            static let indexOutOfBounds: Int = 9001
        }
    }
}
