//
//  SegmentsDependencyContainer.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-27-Dec-Fri.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import Foundation
import SimpleLogger

class SegmentsDependencyContainer: SegmentsViewControllerFactory {
    
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
    
    // MARK: - SegmentsViewControllerFactory protocol
    func makeSegmentsViewController() -> SegmentsViewController {
        let vm: SegmentsViewModel = self.makeSegmentsViewModel()
        let vc: SegmentsViewController = SegmentsViewController(viewModel: vm)
        return vc
    }
    
    private func makeSegmentsViewModel() -> SegmentsViewModel {
        let model: SegmentsModel = SegmentsModelImpl()
        let result: SegmentsViewModel = SegmentsViewModelImpl(model: model)
        return result
    }
}