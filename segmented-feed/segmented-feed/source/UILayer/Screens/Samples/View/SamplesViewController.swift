//
//  SamplesViewController.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2020-W01-04-Jan-Sat.
//  Copyright © 2020 boyankov@yahoo.com. All rights reserved.
//

import UIKit
import SimpleLogger

/// APIs for `DependecyContainer` to expose.
protocol SamplesViewControllerFactory {
    func makeSamplesViewController() -> SamplesViewController
}

class SamplesViewController: BaseViewController, SamplesViewModelConsumer {
    
    // MARK: - Properties
    private let viewModel: SamplesViewModel
    private let embeddingDemoViewControllerFactory: EmbeddingDemoViewControllerFactory
    private let feedViewControllerFactory: FeedViewControllerFactory
    @IBOutlet private weak var samplesTableView: SamplesTableView!
    
    // MARK: - Initialization
    @available(*, unavailable, message: "Creating this view controller with `init(coder:)` is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Creating this view controller with `init(coder:)` is unsupported in favor of dependency injection initializer.")
    }
    
    @available(*, unavailable, message: "Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Creating this view controller with `init(nibName:bundle:)` is unsupported in favor of dependency injection initializer.")
    }
    
    init(viewModel: SamplesViewModel,
         embeddingDemoViewControllerFactory: EmbeddingDemoViewControllerFactory,
         feedViewControllerFactory: FeedViewControllerFactory)
    {
        self.viewModel = viewModel
        self.embeddingDemoViewControllerFactory = embeddingDemoViewControllerFactory
        self.feedViewControllerFactory = feedViewControllerFactory
        super.init(nibName: String(describing: SamplesViewController.self), bundle: nil)
        self.viewModel.setViewModelConsumer(self)
        Logger.success.message()
    }
    
    deinit {
        Logger.fatal.message()
    }
    
    // MARK: - SamplesViewModelConsumer protocol
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure_ui()
    }
}

// MARK: - UI configurations
private extension SamplesViewController {
    
    func configure_ui() {
        self.configure_title(&self.title)
        self.configure_backBarButtonItem(&self.navigationItem.backBarButtonItem)
        self.configure_samplesTableView(self.samplesTableView)
    }
    
    func configure_title(_ title: inout String?) {
        title = NSLocalizedString("SamplesViewController.title.samples",
                                  comment: AppConstants.LocalizedStringComment.screenTitle)
    }
    
    func configure_backBarButtonItem(_ item: inout UIBarButtonItem?) {
        item = UIBarButtonItem(title: nil,
                               style: .plain,
                               target: nil,
                               action: nil)
    }
    
    func configure_samplesTableView(_ tableView: SamplesTableView) {
        tableView.register(SampleTableViewCell.self,
                           forCellReuseIdentifier: String(describing: SampleTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insetsContentViewsToSafeArea = true
    }
}

// MARK: - UITableViewDataSource protocol
extension SamplesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        let result: Int = self.viewModel.samples.count
        return result
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell: SampleTableViewCell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: SampleTableViewCell.self),
                                 for: indexPath) as? SampleTableViewCell
        else {
            let message: String = "Unable to dequeue valid \(String(describing: SampleTableViewCell.self))!"
            Logger.error.message(message)
            return UITableViewCell()
        }
        
        do {
            let sample: Sample = try self.viewModel.sample(for: indexPath)
            cell.textLabel?.text = sample.title
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        catch let error as NSError {
            Logger.error.message().object(error)
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension SamplesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        do {
            let sample: Sample = try self.viewModel.sample(for: indexPath)
            let vc: UIViewController
            switch sample {
            case .embeddingDemo:
                vc = self.embeddingDemoViewControllerFactory.makeEmbeddingDemoViewController()
            case .tableViewEmbedding:
                vc = self.feedViewControllerFactory.makeFeedViewController()
            }
            self.navigationController?
                .pushViewController(vc,
                                    animated: true)
        }
        catch let error as NSError {
            Logger.error.message().object(error)
            return
        }
        tableView.deselectRow(at: indexPath,
                              animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
}
