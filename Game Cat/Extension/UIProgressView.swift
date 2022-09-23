//
//  UIProgressView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/09/22.
//

import UIKit

extension UIProgressView {
    static func initProgressView() -> UIProgressView {
        let progView = UIProgressView()
        progView.progress = 0
        progView.trackTintColor = UIColor(rgb: 0xdddddd)
        progView.progressTintColor = UIColor(rgb: 0x333333)
        return progView
    }
}
