//
//  UIViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/10/22.
//

import UIKit

extension UIViewController {
    var container: PersistentContainer? {
        guard let uiApp = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return uiApp.persistentContainer
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true)
    }
    
    func openExternalURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
