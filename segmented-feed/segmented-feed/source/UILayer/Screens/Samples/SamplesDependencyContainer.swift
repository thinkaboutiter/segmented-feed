//
//  SamplesDependencyContainer.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-04-Jan-Sat.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

protocol SamplesDependencyContainer: AnyObject {}

class SamplesDependencyContainerImpl: SamplesDependencyContainer, SamplesViewControllerFactory {
    
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
    
    // MARK: - SamplesViewControllerFactory protocol
    func makeSamplesViewController() -> SamplesViewController {
        let vm: SamplesViewModel = self.makeSamplesViewModel()
        let factory: EmbeddingDemoViewControllerFactory = EmbeddingDemoDependencyContainerImpl(parent: self)
        let vc: SamplesViewController = SamplesViewController(viewModel: vm,
                                                              embeddingDemoViewControllerFactory: factory)
        return vc
    }
    
    private func makeSamplesViewModel() -> SamplesViewModel {
        let model: SamplesModel = SamplesModelImpl(samples: Sample.allCases)
        let result: SamplesViewModel = SamplesViewModelImpl(model: model)
        return result
    }
}
