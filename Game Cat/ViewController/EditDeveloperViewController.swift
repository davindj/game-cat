//
//  EditDeveloperViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 25/10/22.
//

import UIKit
import RxCocoa
import RxSwift

class EditDeveloperViewController: UIViewController {
    // Var
    private let developerProfile = DeveloperProfile.getDefaultFromUserDefault()
    private let disposeBag = DisposeBag()
    // Components
    private let scrollView: UIScrollView = UIScrollView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let editImageFormView = EditImageFormView()
    private let labelName: UILabel = UILabel.initFormLabel(text: "Developer name")
    private let textFieldName: UITextField = RoundedTextField(placeholder: "your name...")
    private let labelDescription: UILabel = UILabel.initFormLabel(text: "Description")
    private let textFieldDescription: UITextField = RoundedTextField(placeholder: "description...")
    private let labelGhUsername: UILabel = UILabel.initFormLabel(text: "Github")
    private let textFieldGhUsername: UITextField = RoundedTextField(placeholder: "github username... ex: davindj")
    private let labelIgUsername: UILabel = UILabel.initFormLabel(text: "Instagram")
    private let textFieldIgUsername: UITextField = RoundedTextField(placeholder: "instagram username... ex: pindavin")
    private let labelLinkedIn: UILabel = UILabel.initFormLabel(text: "LinkedIn")
    private let textFieldLinkedInUsername: UITextField = RoundedTextField(placeholder: "linkedin username... ex: davin-djayadi")
    private let btnSaveProfile: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save Profile", for: .normal)
        btn.backgroundColor = .primaryColor
        btn.layer.cornerRadius = 10
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViewHierarchy()
        configContraints()
        configComponents()
        configData()
        configRx()
    }
    
    private func configViewController() {
        view.backgroundColor = .white
        navigationItem.title = "Edit Developer Profile"
    }
    
    private func configComponents() {
        editImageFormView.config(delegate: self)
    }
    
    private func configViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(editImageFormView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(btnSaveProfile)
        
        stackView.addArrangedSubview(labelName)
        stackView.addArrangedSubview(textFieldName)
        stackView.addArrangedSubview(labelDescription)
        stackView.addArrangedSubview(textFieldDescription)
        stackView.addArrangedSubview(labelGhUsername)
        stackView.addArrangedSubview(textFieldGhUsername)
        stackView.addArrangedSubview(labelIgUsername)
        stackView.addArrangedSubview(textFieldIgUsername)
        stackView.addArrangedSubview(labelLinkedIn)
        stackView.addArrangedSubview(textFieldLinkedInUsername)
    }
    
    private func configContraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        editImageFormView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        btnSaveProfile.translatesAutoresizingMaskIntoConstraints = false
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        textFieldDescription.translatesAutoresizingMaskIntoConstraints = false
        labelGhUsername.translatesAutoresizingMaskIntoConstraints = false
        textFieldGhUsername.translatesAutoresizingMaskIntoConstraints = false
        labelIgUsername.translatesAutoresizingMaskIntoConstraints = false
        textFieldIgUsername.translatesAutoresizingMaskIntoConstraints = false
        labelLinkedIn.translatesAutoresizingMaskIntoConstraints = false
        textFieldLinkedInUsername.translatesAutoresizingMaskIntoConstraints = false
        btnSaveProfile.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            editImageFormView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            editImageFormView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: editImageFormView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            
            // this should be affected to all children inside stackview
            textFieldName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80),
            
            btnSaveProfile.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            btnSaveProfile.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            btnSaveProfile.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            btnSaveProfile.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40)
        ])
    }
    
    private func configData() {
        editImageFormView.setImage(image: developerProfile.image)
        textFieldName.text = developerProfile.name
        textFieldDescription.text = developerProfile.description
        textFieldGhUsername.text = developerProfile.githubUsername
        textFieldIgUsername.text = developerProfile.instagramUsername
        textFieldLinkedInUsername.text = developerProfile.linkedInUsername
    }
    
    private func configRx() {
        btnSaveProfile.rx
            .tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.saveProfile()
            })
            .disposed(by: disposeBag)
    }
    
    private func saveProfile() {
        guard let name = textFieldName.text, !name.isEmpty else {
            showAlert(title: "Empty Name", message: "please fill name")
            return
        }
        guard let description = textFieldDescription.text, !description.isEmpty else {
            showAlert(title: "Empty Description", message: "please fill description")
            return
        }
        guard let githubUsername = textFieldGhUsername.text, !githubUsername.isEmpty else {
            showAlert(title: "Empty Github Username", message: "please fill github username")
            return
        }
        guard let instagramUsername = textFieldIgUsername.text, !instagramUsername.isEmpty else {
            showAlert(title: "Empty Instagram Username", message: "please fill instagram username")
            return
        }
        guard let linkedInUsername = textFieldLinkedInUsername.text, !linkedInUsername.isEmpty else {
            showAlert(title: "Empty LinkedIn Username", message: "please fill linkedin username")
            return
        }
        
        let newDeveloperProfile = DeveloperProfile(image: editImageFormView.getImage(),
                                                   name: name,
                                                   description: description,
                                                   githubUsername: githubUsername,
                                                   instagramUsername: instagramUsername,
                                                   linkedInUsername: linkedInUsername)
        newDeveloperProfile.saveToUserDefault()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let navController = self.navigationController else { return }
            navController.popViewController(animated: true)
            navController.showAlert(title: "Succesfully Update Profile", message: "Developer Profile Updated!")
        }
    }
}

extension EditDeveloperViewController: EditImageFormViewDelegate {
    func onErrorLoadImage(err: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(title: "Load Image Error", message: "please choose your image again")
        }
    }
}
