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
        let factory: SegmentsViewControllerFactory = SegmentsDependencyContainerImpl()
        let vc: FeedViewController = FeedViewController(viewModel: vm,
                                                        segmentsViewControllerFactory: factory)
        return vc
    }
    
    private func makeFeedViewModel() -> FeedViewModel {
        let feedItems: [DemoSegment: [FeedItem]] = [
            .colors: Color.allCases,
            .tropicFruits: TropicFruit.allCases,
            .shapes: Shape.allCases,
            .vegetables: Vegetable.allCases,
            .planets: Planet.allCases
        ]
        let model: FeedModel = FeedModelImpl(feedItems: feedItems)
        let result: FeedViewModel = FeedViewModelImpl(model: model)
        return result
    }
}
