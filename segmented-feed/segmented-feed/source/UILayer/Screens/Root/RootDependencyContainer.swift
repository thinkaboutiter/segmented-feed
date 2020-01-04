//
//  RootDependencyContainer.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-25-Dec-Wed.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

protocol RootDependencyContainer: AnyObject {}

class RootDependencyContainerImpl: RootDependencyContainer, RootViewControllerFactory {
    
    // MARK: - Initialization
    init() {
        // setup
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - RootViewControllerFactory protocol
    func makeRootViewController() -> RootViewController {
        let vm: RootViewModel = self.makeRootViewModel()
        let factory: EmbeddingDemoViewControllerFactory = EmbeddingDemoDependencyContainerImpl(parent: self)
        let vc: RootViewController = RootViewController(viewModel: vm,
                                                        embeddingDemoViewControllerFactory: factory)
        return vc
    }
    
    private func makeRootViewModel() -> RootViewModel {
        let model: RootModel = RootModelImpl(rows: Sample.allCases)
        let result: RootViewModel = RootViewModelImpl(model: model)
        return result
    }
}
