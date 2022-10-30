//
//  DividerView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 30/10/22.
//

import UIKit

class DividerView: UIView {
    private let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    convenience init(labelText: String) {
        self.init(frame: .zero)
        label.text = labelText
        configViewHierarchy()
        configContraints()
    }
    
    private func configViewHierarchy() {
        addSubview(lineView1)
        addSubview(lineView2)
        addSubview(label)
    }
    
    private func configContraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        lineView1.translatesAutoresizingMaskIntoConstraints = false
        lineView2.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView1.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineView1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/6),
            lineView1.heightAnchor.constraint(equalToConstant: 1),
            
            lineView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView2.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineView2.widthAnchor.constraint(equalTo: lineView1.widthAnchor),
            lineView2.heightAnchor.constraint(equalTo: lineView1.heightAnchor),
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: lineView1.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: lineView2.leadingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
