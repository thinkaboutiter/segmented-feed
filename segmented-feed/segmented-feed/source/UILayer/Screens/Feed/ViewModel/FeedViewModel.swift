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
    func feedItems(for demoSegment: DemoSegment) throws -> [FeedItem]
    func feedItem(for indexPath: IndexPath,
                  withing demoSegment: DemoSegment) throws -> FeedItem
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
    
    func feedItems(for demoSegment: DemoSegment) throws -> [FeedItem] {
        guard let value: [FeedItem] = self.model.feedItems[demoSegment]
        else {
            let message: String = "Unable to find value for key=\(demoSegment)!"
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCode.noValueForKey,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: message
            ])
            throw error
        }
        return value
    }
    
    func feedItem(for indexPath: IndexPath,
                  withing demoSegment: DemoSegment) throws -> FeedItem
    {
        let feedItems: [FeedItem] = try self.feedItems(for: demoSegment)
        let index: Int = indexPath.row
        let range: Range<Int> = 0..<feedItems.count
        guard range ~= index
        else {
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCode.indexOutOfBounds,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: "index=\(index) out of range=\(range)!"
            ])
            throw error
        }
        let result: FeedItem = feedItems[index]
        return result
    }
    
    // MARK: - FeedModelConsumer protocol
}

// MARK: - Errors
private extension FeedViewModelImpl {
    
    enum ErrorConstants {
        static let errorDomainName: String = "\(AppConstants.projectName).\(String(describing: FeedViewModelImpl.self))"
        
        enum ErrorCode {
            static let noValueForKey: Int = 9001
            static let indexOutOfBounds: Int = 9002
        }
    }
}
