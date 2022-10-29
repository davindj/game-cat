//
//  EditImageFormView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 29/10/22.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import PhotosUI

protocol EditImageFormViewDelegate: AnyObject, UIViewController {
    func onErrorLoadImage(err: Error)
}

enum EditImageFormViewLoadFromPickerError: Error {
    case unknownCase
}

class EditImageFormView: UIView {
    // Var
    private weak var delegate: EditImageFormViewDelegate?
    private var disposeBag = DisposeBag()
    // Components
    private let imagePicker = UIImagePickerController()
    private let phPicker: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        return picker
    }()
    private let profileImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 40
        return imgView
    }()
    private let editIconImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.image = UIImage(systemName: "pencil.circle.fill")
        imgView.backgroundColor = .white
        imgView.tintColor = .primaryColor
        imgView.layer.cornerRadius = 20
        return imgView
    }()
    
    override func didMoveToSuperview() {
        configView()
    }
    
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
        configImagePicker()
        configRx()
    }
    
    private func configDefaultData() {
        profileImgView.image = UIImage(named: "davin-djayadi")
    }
    
    private func configViewHierarchy() {
        addSubview(profileImgView)
        addSubview(editIconImgView)
    }
    
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        profileImgView.translatesAutoresizingMaskIntoConstraints = false
        editIconImgView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: profileImgView.topAnchor, constant: -20),
            profileImgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImgView.heightAnchor.constraint(equalToConstant: 160),
            profileImgView.widthAnchor.constraint(equalTo: profileImgView.heightAnchor),

            editIconImgView.topAnchor.constraint(equalTo: profileImgView.bottomAnchor, constant: -30),
            editIconImgView.trailingAnchor.constraint(equalTo: profileImgView.trailingAnchor, constant: 10),
            editIconImgView.heightAnchor.constraint(equalToConstant: 40),
            editIconImgView.widthAnchor.constraint(equalTo: editIconImgView.heightAnchor),
            
            self.bottomAnchor.constraint(equalTo: profileImgView.bottomAnchor)
        ])
    }
    
    private func configRx() {
        profileImgView.rx
            .tapGesture()
            .when(.recognized)
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.present(self.phPicker, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configImagePicker() {
        phPicker.delegate = self
    }
    
    func config(delegate: EditImageFormViewDelegate) {
        self.delegate = delegate
    }
    
    func setImage(image: UIImage?) {
        profileImgView.image = image
    }
    
    func getImage() -> UIImage? {
        return profileImgView.image
    }
}

extension EditImageFormView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                guard let self = self else { return }
                if let err = error {
                    self.delegate?.onErrorLoadImage(err: err)
                    return
                }
                if let image = reading as? UIImage {
                    DispatchQueue.main.async {
                        self.profileImgView.image = image
                    }
                    return
                }
                self.delegate?.onErrorLoadImage(err: EditImageFormViewLoadFromPickerError.unknownCase)
            }
        }
    }
}
