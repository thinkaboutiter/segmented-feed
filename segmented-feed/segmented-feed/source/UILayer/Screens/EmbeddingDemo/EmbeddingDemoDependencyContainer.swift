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
    private let parent: RootDependencyContainer
    
    // MARK: - Initialization
    init(parent: RootDependencyContainer) {
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
        let vc: EmbeddingDemoViewController = EmbeddingDemoViewController(viewModel: vm)
        return vc
    }
    
    private func makeEmbeddingDemoViewModel() -> EmbeddingDemoViewModel {
        let model: EmbeddingDemoModel = EmbeddingDemoModelImpl()
        let result: EmbeddingDemoViewModel = EmbeddingDemoViewModelImpl(model: model)
        return result
    }
}
