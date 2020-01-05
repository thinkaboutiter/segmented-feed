//
//  EmbeddingDemoDependencyContainer.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-03-Jan-Fri.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

protocol EmbeddingDemoDependencyContainer: AnyObject {}

class EmbeddingDemoDependencyContainerImpl: EmbeddingDemoDependencyContainer, EmbeddingDemoViewControllerFactory {
    
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
    
    // MARK: - EmbeddingDemoViewControllerFactory protocol
    func makeEmbeddingDemoViewController() -> EmbeddingDemoViewController {
        let vm: EmbeddingDemoViewModel = self.makeEmbeddingDemoViewModel()
        let factory: SegmentsViewControllerFactory = SegmentsDependencyContainerImpl()
        let vc: EmbeddingDemoViewController = EmbeddingDemoViewController(viewModel: vm,
                                                                          segmentsViewControllerFactory: factory)
        return vc
    }
    
    private func makeEmbeddingDemoViewModel() -> EmbeddingDemoViewModel {
        let model: EmbeddingDemoModel = EmbeddingDemoModelImpl()
        let result: EmbeddingDemoViewModel = EmbeddingDemoViewModelImpl(model: model)
        return result
    }
}
