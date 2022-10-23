//
//  AppDelegate.swift
//  Game Cat
//
//  Created by Davin Djayadi on 18/09/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "GameCat")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}
