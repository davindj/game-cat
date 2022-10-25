//
//  AboutDeveloperViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/10/22.
//

import UIKit
import RxCocoa
import RxSwift

class AboutDeveloperViewController: UIViewController {
    // Var
    private let disposeBag: DisposeBag = DisposeBag()
    // Components
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let imgDeveloper: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "davin-djayadi")
        imgView.layer.cornerRadius = 40
        imgView.layer.masksToBounds = true
        return imgView
    }()
    private let labelDeveloper: UILabel = {
        let label = UILabel()
        label.text = "Davin Djayadi"
        label.textColor = UIColor.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    private let labelDeveloperDescription: UILabel = {
        let label = UILabel()
        var desc = "A passionate programmer who enjoy creating cool and wonderful ideas into reality."
        desc += " Currently I'm focusing on mobile & web development."
        label.text = desc
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    private let btnGithub: UIButton = {
        let btn = UIButton()
        btn.setTitle("GH - Github", for: .normal)
        btn.backgroundColor = UIColor(rgb: 0x412D97)
        btn.layer.cornerRadius = 10
        return btn
    }()
    private let btnInstagram: UIButton = {
        let btn = UIButton()
        btn.setTitle("IG - Instagram", for: .normal)
        btn.backgroundColor = UIColor(rgb: 0xC4608A)
        btn.layer.cornerRadius = 10
        return btn
    }()
    private let btnLinkedin: UIButton = {
        let btn = UIButton()
        btn.setTitle("IN - LinkedIn", for: .normal)
        btn.backgroundColor = UIColor(rgb: 0x4E82A8)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViewHierarchy()
        configConstraints()
        configRx()
    }
    
    private func configViewController() {
        view.backgroundColor = .white
        navigationItem.title = "About Developer"
    }
    
    private func configViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imgDeveloper)
        contentView.addSubview(labelDeveloper)
        contentView.addSubview(labelDeveloperDescription)
        contentView.addSubview(btnGithub)
        contentView.addSubview(btnInstagram)
        contentView.addSubview(btnLinkedin)
    }
    
    private func configConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imgDeveloper.translatesAutoresizingMaskIntoConstraints = false
        labelDeveloper.translatesAutoresizingMaskIntoConstraints = false
        labelDeveloperDescription.translatesAutoresizingMaskIntoConstraints = false
        btnGithub.translatesAutoresizingMaskIntoConstraints = false
        btnInstagram.translatesAutoresizingMaskIntoConstraints = false
        btnLinkedin.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            imgDeveloper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imgDeveloper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imgDeveloper.heightAnchor.constraint(equalToConstant: 160),
            imgDeveloper.widthAnchor.constraint(equalTo: imgDeveloper.heightAnchor),
            
            labelDeveloper.topAnchor.constraint(equalTo: imgDeveloper.bottomAnchor, constant: 10),
            labelDeveloper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelDeveloperDescription.topAnchor.constraint(equalTo: labelDeveloper.bottomAnchor, constant: 5),
            labelDeveloperDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelDeveloperDescription.widthAnchor.constraint(equalToConstant: 200),
            
            btnGithub.topAnchor.constraint(equalTo: labelDeveloperDescription.bottomAnchor, constant: 20),
            btnGithub.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnGithub.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            btnGithub.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            btnInstagram.topAnchor.constraint(equalTo: btnGithub.bottomAnchor, constant: 10),
            btnInstagram.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnInstagram.leadingAnchor.constraint(equalTo: btnGithub.leadingAnchor),
            btnInstagram.trailingAnchor.constraint(equalTo: btnGithub.trailingAnchor),
            
            btnLinkedin.topAnchor.constraint(equalTo: btnInstagram.bottomAnchor, constant: 10),
            btnLinkedin.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnLinkedin.leadingAnchor.constraint(equalTo: btnGithub.leadingAnchor),
            btnLinkedin.trailingAnchor.constraint(equalTo: btnGithub.trailingAnchor),
            
            btnLinkedin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configRx() {
        btnGithub.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                self.openExternalURL(urlString: "https://github.com/davindj")
            })
            .disposed(by: disposeBag)
        
        btnInstagram.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                self.openExternalURL(urlString: "https://instagram.com/pindavin")
            })
            .disposed(by: disposeBag)
        
        btnLinkedin.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                self.openExternalURL(urlString: "https://www.linkedin.com/in/davin-djayadi")
            })
            .disposed(by: disposeBag)
    }
}
