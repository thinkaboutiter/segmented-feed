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
    
    init(viewModel: EmbeddingDemoViewModel,
         segmentsViewControllerFactory: SegmentsViewControllerFactory)
    {
        self.viewModel = viewModel
        self.segmentsViewControllerFactory = segmentsViewControllerFactory
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
        self.configure_ui()
    }
    
    // MARK: - Actions
    @IBAction func embeddingActionsButton_touchUpInside(_ sender: UIButton) {
        Logger.debug.message()
        do {
            if let _ = self.segmentsViewController {
                try self.removeSegmentsViewController()
            }
            else {
                try self.embedSegmentsViewController()
            }
        }
        catch let error as NSError {
            Logger.error.message().object(error)
        }
        self.configure_embeddingActionsButton(sender)
    }
}

// MARK: - UI configurations
private extension EmbeddingDemoViewController {
    
    func configure_ui() {
        self.configure_title(&self.title)
        self.configure_segmentsContainerView(self.segmentsContainerView)
        self.configure_embeddingActionsButton(self.embeddingActionsButton)
    }
    
    func configure_title(_ title: inout String?) {
        title = NSLocalizedString("EmbeddingDemoViewController.title.embedding-demo",
                                  comment: AppConstants.LocalizedStringComment.screenTitle)
    }
    
    func configure_segmentsContainerView(_ view: UIView) {
        view.backgroundColor = UIColor.darkGray
    }
    
    func configure_embeddingActionsButton(_ button: UIButton) {
        let embedTitle: String = NSLocalizedString("embeddingActionsButton.title.embed",
                                                   comment: AppConstants.LocalizedStringComment.buttonTitle)
        let removeTitle: String = NSLocalizedString("embeddingActionsButton.title.remove",
                                                    comment: AppConstants.LocalizedStringComment.buttonTitle)
        let title: String = self.segmentsViewController == nil ? embedTitle : removeTitle
        button.setTitle(title, for: .normal)
    }
}

// MARK: - Embedding
private extension EmbeddingDemoViewController {
    
    func embedSegmentsViewController() throws {
        guard self.segmentsViewController?.parent == nil else {
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCodeDescription.segmentsViewControllerParentNotNil.code,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: ErrorConstants.ErrorCodeDescription.segmentsViewControllerParentNotNil.description
            ])
            throw error
        }
        self.segmentsViewController = nil
        let vc: SegmentsViewController = self.segmentsViewControllerFactory.makeSegmentsViewController(withSegmentSelectionConsumer: self)
        try self.embed(vc,
                       containerView: self.segmentsContainerView)
        
        // initial pre-selection
        let segment: Segment = try vc.selectedSegment()
        self.didSelectSegment(segment)
        
        self.segmentsViewController = vc
    }
    
    func removeSegmentsViewController() throws {
        guard self.segmentsViewController != nil else {
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCodeDescription.segmentsViewControllerIsNil.code,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: ErrorConstants.ErrorCodeDescription.segmentsViewControllerIsNil.description
            ])
            throw error
        }
        try self.remove(self.segmentsViewController!)
        self.segmentsViewController = nil
    }
}

// MARK: - SegmentSelectionConsumer protocol
extension EmbeddingDemoViewController: SegmentSelectionConsumer {
    
    func didSelectSegment(_ segment: Segment) {
        Logger.debug.message().object(segment)
    }
}

// MARK: - Errors
private extension EmbeddingDemoViewController {
    
    enum ErrorConstants {
        static let errorDomainName: String = "\(AppConstants.projectName).\(String(describing: EmbeddingDemoViewController.self))"
        
        enum ErrorCodeDescription {
            static let segmentsViewControllerParentNotNil: (code: Int, description: String)
                = (9001, "\(String(describing: SegmentsViewController.self)) instance has a parent view controller!")
            static let segmentsViewControllerIsNil: (code: Int, description: String)
                = (9002, "\(String(describing: SegmentsViewController.self)) instance is nil!")
        }
    }
}
