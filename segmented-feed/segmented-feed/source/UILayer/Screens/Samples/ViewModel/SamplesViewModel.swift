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
    var samples: [Sample] { get }
    func sample(for indexPath: IndexPath) throws -> Sample
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
    
    var samples: [Sample] {
        let result: [Sample] = self.model.samples
        return result
    }
    
    func sample(for indexPath: IndexPath) throws -> Sample {
        let index: Int = indexPath.row
        let samples: [Sample] = self.samples
        let range: Range<Int> = 0..<samples.count
        guard range ~= index
        else {
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCode.indexOutOfBounds,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: "index=\(index) out of range=\(range)!"
            ])
            throw error
        }
        let result: Sample = samples[index]
        return result
    }
    
    // MARK: - SamplesModelConsumer protocol
}

// MARK: - Errors
private extension SamplesViewModelImpl {
    
    enum ErrorConstants {
        static let errorDomainName: String = "\(AppConstants.projectName).\(String(describing: RootViewModelImpl.self))"
        
        enum ErrorCode {
            static let indexOutOfBounds: Int = 9001
        }
    }
}
