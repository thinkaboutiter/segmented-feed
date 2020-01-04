//
//  RootViewModel.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-25-Dec-Wed.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

/// APIs for `View` to expose to `ViewModel`
protocol RootViewModelConsumer: AnyObject {
}

/// APIs for `ViewModel` to expose to `View`
protocol RootViewModel: AnyObject {
    func setViewModelConsumer(_ newValue: RootViewModelConsumer)
    var rows: [Sample] { get }
    func sample(for indexPath: IndexPath) throws -> Sample
}

class RootViewModelImpl: RootViewModel, RootModelConsumer {
    
    // MARK: - Properties
    private let model: RootModel
    private weak var viewModelConsumer: RootViewModelConsumer!
    
    // MARK: - Initialization
    required init(model: RootModel) {
        self.model = model
        self.model.setModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - RootViewModel protocol
    func setViewModelConsumer(_ newValue: RootViewModelConsumer) {
        self.viewModelConsumer = newValue
    }
    
    var rows: [Sample] {
        let result: [Sample] = self.model.rows
        return result
    }
    
    func sample(for indexPath: IndexPath) throws -> Sample {
        let index: Int = indexPath.row
        let samples: [Sample] = self.rows
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
    
    // MARK: - RootModelConsumer protocol
}

// MARK: - Errors
private extension RootViewModelImpl {
    
    enum ErrorConstants {
        static let errorDomainName: String = "\(AppConstants.projectName).\(String(describing: RootViewModelImpl.self))"
        
        enum ErrorCode {
            static let indexOutOfBounds: Int = 9001
        }
    }
}
