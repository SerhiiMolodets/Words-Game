//
//  WordsTextField.swift
//  WordsGame
//
//  Created by Сергей Молодец on 29.06.2022.
//

import SwiftUI

struct WordsTextField: View {
    
    @State var word: Binding<String>
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: word)
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(12)
            .foregroundColor(.black)
    }
}

