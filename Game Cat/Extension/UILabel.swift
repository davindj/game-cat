//
//  UILabel.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/09/22.
//

import UIKit

extension UILabel {
    static func initLabelPrimary(text: String=" ") -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(rgb: 0x333333)
        label.numberOfLines = 0
        label.text = text
        return label
    }
    static func initLabelSecondary(text: String=" ") -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(rgb: 0x999999)
        label.text = text
        return label
    }
    static func initLabelSubHeader(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(rgb: 0x999999)
        label.text = text
        return label
    }
    static func initLabelLargeText(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.textColor = UIColor(rgb: 0x333333)
        label.text = text
        return label
    }
    static func initFormLabel(text: String) -> UILabel {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
//        label.textColor = UIColor(rgb: 0x333333)
        label.text = text
        return label
    }
}
