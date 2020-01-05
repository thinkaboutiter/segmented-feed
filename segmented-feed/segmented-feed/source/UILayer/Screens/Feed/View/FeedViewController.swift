//
//  FeedViewController.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-05-Jan-Sun.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit
import SimpleLogger

/// APIs for `DependecyContainer` to expose.
protocol FeedViewControllerFactory {
    func makeFeedViewController() -> FeedViewController
}

class FeedViewController: BaseViewController, FeedViewModelConsumer {
    
    // MARK: - Properties
    private let viewModel: FeedViewModel
    private let segmentsViewControllerFactory: SegmentsViewControllerFactory
    
    // MARK: - Initialization
    @available(*, unavailable, message: "Creating this view controller with `init(coder:)` is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Creating this view controller with `init(coder:)` is unsupported in favor of dependency injection initializer.")
    }
    
    @available(*, unavailable, message: "Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of dependency injection initializer.")
    }
    
    init(viewModel: FeedViewModel,
         segmentsViewControllerFactory: SegmentsViewControllerFactory)
    {
        self.viewModel = viewModel
        self.segmentsViewControllerFactory = segmentsViewControllerFactory
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
        self.viewModel.setViewModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - FeedViewModelConsumer protocol
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure_ui()
    }
}

// MARK: - UI configurations
private extension FeedViewController {
    
    func configure_ui() {
        self.configure_title(&self.title)
    }
    
    func configure_title(_ title: inout String?) {
        title = NSLocalizedString("FeedViewController.title.feed",
                                  comment: AppConstants.LocalizedStringComment.screenTitle)
    }
}
