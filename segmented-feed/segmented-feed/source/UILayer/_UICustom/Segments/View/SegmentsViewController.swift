//
//  SegmentsViewController.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-27-Dec-Fri.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit
import SimpleLogger

/// APIs for `DependecyContainer` to expose.
protocol SegmentsViewControllerFactory {
    func makeSegmentsViewController() -> SegmentsViewController
}

class SegmentsViewController: BaseViewController, SegmentsViewModelConsumer {
    
    // MARK: - Properties
    private let viewModel: SegmentsViewModel
    @IBOutlet private weak var demoLabel: UILabel!
    
    // MARK: - Initialization
    @available(*, unavailable, message: "Creating this view controller with `init(coder:)` is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Creating this view controller with `init(coder:)` is unsupported in favor of dependency injection initializer.")
    }
    
    @available(*, unavailable, message: "Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of dependency injection initializer.")
    }
    
    init(viewModel: SegmentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SegmentsViewController.self), bundle: nil)
        self.viewModel.setViewModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - SegmentsViewModelConsumer protocol
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure_ui()
    }
}

// MARK: - Configurations
private extension SegmentsViewController {
    
    func configure_ui() {
        self.view.backgroundColor = UIColor.orange
        self.configure_demoLabel()
    }
    
    func configure_demoLabel() {
        self.demoLabel.text = String(describing: SegmentsViewController.self)
    }
}
