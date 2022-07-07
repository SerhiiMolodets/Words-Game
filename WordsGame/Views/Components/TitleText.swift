//
//  SwiftUIView.swift
//  WordsGame
//
//  Created by Сергей Молодец on 29.06.2022.
//

import SwiftUI

struct TitleText: View {
    
    @State var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("Inter-Bold", size: 48))
            .cornerRadius(16)
            .foregroundColor(Color("Title"))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "WORDS GAME")
    }
}
