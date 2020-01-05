//
//  FeedDependencyContainer.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-05-Jan-Sun.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

protocol FeedDependencyContainer: AnyObject {}

class FeedDependencyContainerImpl: FeedDependencyContainer, FeedViewControllerFactory {
    
    // MARK: - Properties
    private let parent: SamplesDependencyContainer
    
    // MARK: - Initialization
    init(parent: SamplesDependencyContainer) {
        // setup
        self.parent = parent
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - FeedViewControllerFactory protocol
    func makeFeedViewController() -> FeedViewController {
        let vm: FeedViewModel = self.makeFeedViewModel()
        let vc: FeedViewController = FeedViewController(viewModel: vm)
        return vc
    }
    
    private func makeFeedViewModel() -> FeedViewModel {
        let model: FeedModel = FeedModelImpl()
        let result: FeedViewModel = FeedViewModelImpl(model: model)
        return result
    }
}
