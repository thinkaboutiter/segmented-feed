//
//  SegmentCollectionViewCell.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-29-Dec-Sun.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

class SegmentCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet private weak var contentContrainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var selectionView: UIView!
    private(set) var segment: Segment?
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure_selectionView(self.selectionView)
    }
    
    override var isSelected: Bool {
        didSet {
            self.selectionView.isHidden = !self.isSelected
        }
    }
    
    // MARK: - UI configurations
    func configure(with segment: Segment) {
        self.segment = segment
        self.titleLabel.text = segment.title
        self.titleLabel.font = UIConstatns.titleFont
        self.contentContrainerView.backgroundColor = segment.color
    }
}

// MARK: - UI configurations
private extension SegmentCollectionViewCell {
    
    func configure_selectionView(_ view: UIView) {
        view.backgroundColor = .white
        view.isHidden = true
    }
}

// MARK: - UI constants
extension SegmentCollectionViewCell {
    
    enum UIConstatns {
        private static let fontSize: CGFloat = 16
        private static let fontWeight: UIFont.Weight = .medium
        static let titleFont: UIFont = UIFont.systemFont(ofSize: UIConstatns.fontSize,
                                                         weight: UIConstatns.fontWeight)
    }
}
