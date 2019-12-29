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
    
    // MARK: - UI configurations
    func configure(with segment: Segment) {
        self.titleLabel.text = segment.title
        self.contentContrainerView.backgroundColor = segment.color
    }
}
