//
//  EmbeddingDemoViewController.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-03-Jan-Fri.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit
import SimpleLogger

/// APIs for `DependecyContainer` to expose.
protocol EmbeddingDemoViewControllerFactory {
    func makeEmbeddingDemoViewController() -> EmbeddingDemoViewController
}

class EmbeddingDemoViewController: BaseViewController, EmbeddingDemoViewModelConsumer {
    
    // MARK: - Properties
    private let viewModel: EmbeddingDemoViewModel
    
    // MARK: - Initialization
    @available(*, unavailable, message: "Creating this view controller with `init(coder:)` is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Creating this view controller with `init(coder:)` is unsupported in favor of dependency injection initializer.")
    }
    
    @available(*, unavailable, message: "Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of dependency injection initializer.")
    }
    
    init(viewModel: EmbeddingDemoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: EmbeddingDemoViewController.self), bundle: nil)
        self.viewModel.setViewModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - EmbeddingDemoViewModelConsumer protocol
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
