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
    private var devProfile = DeveloperProfile.getDefaultFromUserDefault()
    private let disposeBag: DisposeBag = DisposeBag()
    // Components
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let imgDeveloper: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 40
        imgView.layer.masksToBounds = true
        return imgView
    }()
    private let labelDeveloper: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    private let labelDeveloperDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    private let socialMediaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
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
    private let dividerView: UIView = DividerView(labelText: "you can also be developer by editing current profile :D")
    private let btnEditProfile: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.backgroundColor = .primaryColor
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViewHierarchy()
        configConstraints()
        loadData()
        configData()
        configRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        configData()
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
        contentView.addSubview(socialMediaStackView)
        contentView.addSubview(dividerView)
        contentView.addSubview(btnEditProfile)
        
        socialMediaStackView.addArrangedSubview(btnGithub)
        socialMediaStackView.addArrangedSubview(btnInstagram)
        socialMediaStackView.addArrangedSubview(btnLinkedin)
    }
    
    private func configConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imgDeveloper.translatesAutoresizingMaskIntoConstraints = false
        labelDeveloper.translatesAutoresizingMaskIntoConstraints = false
        labelDeveloperDescription.translatesAutoresizingMaskIntoConstraints = false
        socialMediaStackView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        btnEditProfile.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            socialMediaStackView.topAnchor.constraint(equalTo: labelDeveloperDescription.bottomAnchor, constant: 20),
            socialMediaStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            socialMediaStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            dividerView.topAnchor.constraint(equalTo: socialMediaStackView.bottomAnchor, constant: 20),
            dividerView.leadingAnchor.constraint(equalTo: socialMediaStackView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: socialMediaStackView.trailingAnchor),
            
            btnEditProfile.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10),
            btnEditProfile.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnEditProfile.leadingAnchor.constraint(equalTo: socialMediaStackView.leadingAnchor),
            btnEditProfile.trailingAnchor.constraint(equalTo: socialMediaStackView.trailingAnchor),
            
            btnEditProfile.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadData() {
        devProfile = DeveloperProfile.getDefaultFromUserDefault()
    }
    
    private func configData() {
        imgDeveloper.image = devProfile.image
        labelDeveloper.text = devProfile.name
        labelDeveloperDescription.text = devProfile.description
    }
    
    private func configRx() {
        btnGithub.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.openExternalURL(urlString: "https://github.com/\(self.devProfile.githubUsername)")
            })
            .disposed(by: disposeBag)
        
        btnInstagram.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.openExternalURL(urlString: "https://instagram.com/\(self.devProfile.instagramUsername)")
            })
            .disposed(by: disposeBag)
        
        btnLinkedin.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.openExternalURL(urlString: "https://www.linkedin.com/in/\(self.devProfile.linkedInUsername)")
            })
            .disposed(by: disposeBag)
        
        btnEditProfile.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let editDeveloperVC = EditDeveloperViewController()
                self.navigationController?.pushViewController(editDeveloperVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
