//
//  DeveloperProfile.swift
//  Game Cat
//
//  Created by Davin Djayadi on 29/10/22.
//

import UIKit

struct DeveloperProfile {
    static let UDKEYdeveloperImage = "devProfileImage"
    static let UDKEYdeveloperName = "devName"
    static let UDKEYdeveloperDescription = "devDescription"
    static let UDKEYdeveloperGitHub = "githubUsername"
    static let UDKEYdeveloperInstagram = "instagramUsername"
    static let UDKEYdeveloperLinkedIn = "linkedInUsername"
    
    var image: UIImage?
    var name: String
    var description: String
    var githubUsername: String
    var instagramUsername: String
    var linkedInUsername: String
    
    func saveToUserDefault() {
        guard let image = image else { return }
        let data = image.pngData()
        guard let strBase64Image = data?.base64EncodedString(options: .endLineWithLineFeed) else { return }
        
        UserDefaults.standard.set(strBase64Image, forKey: DeveloperProfile.UDKEYdeveloperImage)
        UserDefaults.standard.set(name, forKey: DeveloperProfile.UDKEYdeveloperName)
        UserDefaults.standard.set(description, forKey: DeveloperProfile.UDKEYdeveloperDescription)
        UserDefaults.standard.set(githubUsername, forKey: DeveloperProfile.UDKEYdeveloperGitHub)
        UserDefaults.standard.set(instagramUsername, forKey: DeveloperProfile.UDKEYdeveloperInstagram)
        UserDefaults.standard.set(linkedInUsername, forKey: DeveloperProfile.UDKEYdeveloperLinkedIn)
    }
    
    static func getDefaultFromUserDefault() -> DeveloperProfile {
        var image: UIImage? = UIImage(named: "davin-djayadi")
        if let strBase64Image = UserDefaults.standard.string(forKey: "devProfileImage") { // image store as bsae64
            if let data = Data(base64Encoded: strBase64Image, options: .ignoreUnknownCharacters) {
                image =  UIImage(data: data)
            }
        }
        let name = UserDefaults.standard.string(forKey: "devName") ?? "Davin Djayadi"
        var defaultDescription = "A passionate programmer who enjoy creating cool and wonderful ideas into reality."
        defaultDescription += " Currently I'm focusing on mobile & web development."
        let description = UserDefaults.standard.string(forKey: "devDescription") ?? defaultDescription
        let githubUsername = UserDefaults.standard.string(forKey: "githubUsername") ?? "davindj"
        let instagramUsername = UserDefaults.standard.string(forKey: "instagramUsername") ?? "pindavin"
        let linkedInUsername = UserDefaults.standard.string(forKey: "linkedInUsername") ?? "davin-djayadi"
        
        return DeveloperProfile(image: image,
                                name: name,
                                description: description,
                                githubUsername: githubUsername,
                                instagramUsername: instagramUsername,
                                linkedInUsername: linkedInUsername)
    }
}
