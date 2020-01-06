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
    private lazy var segmentsViewController: SegmentsViewController
        = self.segmentsViewControllerFactory.makeSegmentsViewController(withSegmentSelectionConsumer: self)
    @IBOutlet private weak var feedTableView: FeedTableView!
    
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
        self.configure_feedTableView(self.feedTableView)
    }
    
    func configure_title(_ title: inout String?) {
        title = NSLocalizedString("FeedViewController.title.feed",
                                  comment: AppConstants.LocalizedStringComment.screenTitle)
    }
    
    func configure_feedTableView(_ tableView: FeedTableView) {
        tableView.register(FeedTableViewCell.self,
                           forCellReuseIdentifier: String(describing: FeedTableViewCell.self))
        tableView.register(SegmentsContainerTableViewCell.self,
                           forCellReuseIdentifier: String(describing: SegmentsContainerTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insetsContentViewsToSafeArea = true
    }
}

// MARK: - Segment utilities
private extension FeedViewController {
    
    func selectedDemoSegment() throws -> DemoSegment {
        guard let result: DemoSegment = try self.segmentsViewController.selectedSegment() as? DemoSegment
        else {
            let error: NSError = NSError(domain: ErrorConstants.errorDomainName,
                                         code: ErrorConstants.ErrorCodeDescription.unableToObtainDemoSegment.code,
                                         userInfo: [
                                            NSLocalizedDescriptionKey: ErrorConstants.ErrorCodeDescription.unableToObtainDemoSegment.description
            ])
            throw error
        }
        return result
    }
}

// MARK: - UITableViewDataSource protocol
extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        let result: Int
        switch section {
        case 0:
            result = 1
        default:
            do {
                let demoSegment: DemoSegment = try self.selectedDemoSegment()
                let feedItems: [FeedItem] = try self.viewModel.feedItems(for: demoSegment)
                result = feedItems.count
            }
            catch let error as NSError {
                Logger.error.message().object(error)
                result = 0
            }
        }
        return result
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let result: UITableViewCell
        switch indexPath.section {
        case 0:
            guard let cell: SegmentsContainerTableViewCell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: SegmentsContainerTableViewCell.self),
                                     for: indexPath) as? SegmentsContainerTableViewCell
            else {
                let message: String = "Unable to dequeue valid \(String(describing: SegmentsContainerTableViewCell.self))!"
                Logger.error.message(message)
                return UITableViewCell()
            }
            
            if self.segmentsViewController.parent == nil {
                do {
                    try self.embedSegmentsViewController(into: cell)
                    result = cell
                }
                catch let error as NSError {
                    Logger.error.message().object(error)
                    result = UITableViewCell()
                }
            }
            else if self.segmentsViewController.view.superview !== cell {
                do {
                    try self.remove(self.segmentsViewController)
                    try self.embedSegmentsViewController(into: cell)
                    result = cell
                }
                catch let error as NSError {
                    Logger.error.message().object(error)
                    result = UITableViewCell()
                }
            }
            else {
                result = cell
            }
            
        default:
            guard let cell: FeedTableViewCell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self),
                                     for: indexPath) as? FeedTableViewCell
            else {
                let message: String = "Unable to dequeue valid \(String(describing: FeedTableViewCell.self))!"
                Logger.error.message(message)
                return UITableViewCell()
            }
            
            do {
                let selectedDemoSegment: DemoSegment = try self.selectedDemoSegment()
                let feedItem: FeedItem = try self.viewModel.feedItem(for: indexPath,
                                                                     withing: selectedDemoSegment)
                cell.textLabel?.text = feedItem.title
                result = cell
            }
            catch let error as NSError {
                Logger.error.message().object(error)
                result = UITableViewCell()
            }
        }
        return result
    }
}

// MARK: - UITableViewDelegate protocol
extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let result: CGFloat
        switch indexPath.section {
        case 0:
            result = UIConstants.segmentedContainerTableViewCellHeight
        default:
            result = UIConstants.feedTableViewCellHeight
        }
        return result
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath,
                              animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
}

// MARK: - UIConstants
private extension FeedViewController {
    
    enum UIConstants {
        static let feedTableViewCellHeight: CGFloat = 44
        static let segmentedContainerTableViewCellHeight: CGFloat = 54
    }
}

// MARK: - Embedding
private extension FeedViewController {
    
    func embedSegmentsViewController(into containerView: UIView) throws {
        try self.embed(self.segmentsViewController,
                       containerView: containerView)
        
        // initial pre-selection
        let segment: Segment = try self.segmentsViewController.selectedSegment()
        self.didSelectSegment(segment)
    }
}

// MARK: - SegmentSelectionConsumer protocol
extension FeedViewController: SegmentSelectionConsumer {
    
    func didSelectSegment(_ segment: Segment) {
        Logger.debug.message().object(segment)
        let indexSet: IndexSet = IndexSet([1])
        self.feedTableView.reloadSections(indexSet,
                                          with: .automatic)
    }
}

// MARK: - Errors
private extension FeedViewController {
    
    enum ErrorConstants {
        static let errorDomainName: String = "\(AppConstants.projectName).\(String(describing: FeedViewController.self))"
        
        enum ErrorCodeDescription {
            static let unableToObtainDemoSegment: (code: Int, description: String)
                = (9001, "Unable to obtain \(String(describing: DemoSegment.self))!")
        }
    }
}
