//
//  RootViewController.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-25-Dec-Wed.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit
import SimpleLogger

/// APIs for `DependecyContainer` to expose.
protocol RootViewControllerFactory {
    func makeRootViewController() -> RootViewController
}

class RootViewController: BaseViewController, RootViewModelConsumer {
    
    // MARK: - Properties
    private let viewModel: RootViewModel
    private let segmentsViewControllerFactory: SegmentsViewControllerFactory
    @IBOutlet private weak var segmentsContainerView: UIView!
    @IBOutlet private weak var embeddingActionsButton: UIButton!
    private weak var segmentsViewController: SegmentsViewController?
    
    // MARK: - Initialization
    @available(*, unavailable, message: "Creating this view controller with `init(coder:)` is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Creating this view controller with `init(coder:)` is unsupported in favor of dependency injection initializer.")
    }
    
    @available(*, unavailable, message: "Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of dependency injection initializer.")
    }
    
    init(viewModel: RootViewModel,
         segmentsViewControllerFactory: SegmentsViewControllerFactory)
    {
        self.viewModel = viewModel
        self.segmentsViewControllerFactory = segmentsViewControllerFactory
        super.init(nibName: String(describing: RootViewController.self), bundle: nil)
        self.viewModel.setViewModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - RootViewModelConsumer protocol
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure_ui()
    }
    
    // MARK: - Actions
    @IBAction func embeddingActionsButton_touchUpInside(_ sender: UIButton) {
        Logger.debug.message()
    }
}

// MARK: - UI configurations
private extension RootViewController {
    
    func configure_ui() {
        self.configure_segmentsContainerView(self.segmentsContainerView)
        self.configure_embeddingActionsButton(self.embeddingActionsButton)
    }
    
    func configure_segmentsContainerView(_ view: UIView) {
        view.backgroundColor = UIColor.darkGray
    }
    
    func configure_embeddingActionsButton(_ button: UIButton) {
        let embedTitle: String = NSLocalizedString("embeddingActionsButton.title.embed",
                                                   comment: AppConstants.LocalizedStringComment.buttonTitle)
        let removeTitle: String = NSLocalizedString("embeddingActionsButton.title.embed",
        comment: AppConstants.LocalizedStringComment.buttonTitle)
        let title: String = self.segmentsViewController == nil ? embedTitle : removeTitle
        button.setTitle(title, for: .normal)
    }
}

// MARK: - Embedding
private extension RootViewController {
    
    func embedSegmentsViewController() {
        
    }
    
    func removeSegmentsViewController() {
        
    }
}
