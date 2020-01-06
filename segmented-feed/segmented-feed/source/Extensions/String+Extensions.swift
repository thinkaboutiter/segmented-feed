//
//  String+Extensions.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W01-31-Dec-Tue.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat,
                font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat,
               font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude,
                                    height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
}
