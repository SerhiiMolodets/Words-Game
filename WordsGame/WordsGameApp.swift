//
//  WordsGameApp.swift
//  WordsGame
//
//  Created by Сергей Молодец on 28.06.2022.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct WordsGameApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            StartView()
        }
    }
}
