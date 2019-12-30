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
    @IBOutlet private weak var segmentsCollectionView: SegmentsCollectionView!
    
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
        self.configue_view(self.view)
        self.configure_segmentsCollectionView(self.segmentsCollectionView)
    }
    
    func configue_view(_ view: UIView) {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    func configure_segmentsCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView
            .register(UINib(nibName: String(describing: SegmentCollectionViewCell.self),
                            bundle: nil),
                      forCellWithReuseIdentifier: String(describing: SegmentCollectionViewCell.self))
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource protocol
extension SegmentsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        let result: Int = self.viewModel.segments.count
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell: SegmentCollectionViewCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: SegmentCollectionViewCell.self),
                                 for: indexPath) as? SegmentCollectionViewCell
        else {
            let message: String = "Unable to dequeue valid \(String(describing: SegmentCollectionViewCell.self))!"
            Logger.error.message(message)
            return UICollectionViewCell()
        }
        
        do {
            let segment: Segment = try self.viewModel.segment(for: indexPath)
            cell.configure(with: segment)
            return cell
        }
        catch let error as NSError {
            Logger.error.message().object(error)
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate protocol
extension SegmentsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        do {
            let segment: Segment = try self.viewModel.segment(for: indexPath)
            Logger.debug.message().object(segment.title)
        }
        catch let error as NSError {
            Logger.error.message().object(error)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol
extension SegmentsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let result: CGSize = self.itemSize(for: collectionView,
                                           at: indexPath)
        return result
    }
    
    private func itemSize(for collectionView: UICollectionView,
                          at indexPath: IndexPath) -> CGSize
    {
        guard let dimensionsProvider: SegmentsCollectionViewDimentionProvider
            = collectionView as? SegmentsCollectionViewDimentionProvider
        else {
            let message: String = "Unable to obtain valid \(String(describing: SegmentsCollectionViewDimentionProvider.self)) object!"
            Logger.error.message(message)
            return CGSize.zero
        }
        do {
            let container_height: CGFloat = collectionView.bounds.height
            let segment: Segment = try self.viewModel.segment(for: indexPath)
            let text_width: CGFloat = segment.title.width(withConstrainedHeight: container_height,
                                                          font: SegmentCollectionViewCell.UIConstatns.titleFont)
            let item_width: CGFloat = (
                text_width
                    + dimensionsProvider.textHorizontallPadding * 2
            )
            let item_height: CGFloat = (
                container_height
                    - dimensionsProvider.sectionEdgeInsets.top
                    - dimensionsProvider.sectionEdgeInsets.bottom
            )
            let result: CGSize = CGSize(width: item_width, height: item_height)
            return result
        }
        catch let error as NSError {
            Logger.error.message().object(error)
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        guard let dimensionsProvider: CollectionViewDimensionsProvider
            = collectionView as? CollectionViewDimensionsProvider
        else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            Logger.error.message(message)
            return UIEdgeInsets.zero
        }
        return dimensionsProvider.sectionEdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        guard let dimensionsProvider: CollectionViewDimensionsProvider
            = collectionView as? CollectionViewDimensionsProvider
        else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            Logger.error.message(message)
            return 0
        }
        return dimensionsProvider.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        guard let dimensionsProvider: CollectionViewDimensionsProvider
            = collectionView as? CollectionViewDimensionsProvider
        else {
            let message: String = "Unable to obtain valid \(String(describing: CollectionViewDimensionsProvider.self)) object!"
            Logger.error.message(message)
            return 0
        }
        return dimensionsProvider.minimumLineSpacing
    }
}
