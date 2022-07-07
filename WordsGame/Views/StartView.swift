//
//  ContentView.swift
//  WordsGame
//
//  Created by Сергей Молодец on 28.06.2022.
//

import SwiftUI

struct StartView: View {
    @State var bigWord = ""
    @State var player1 = ""
    @State var player2 = ""
    
    @State var isShowedGame = false
    @State var isAlertPresent = false
    
    var body: some View {
        
        VStack {
            TitleText(text: "WORDS GAME")
            
            WordsTextField(word: $bigWord, placeHolder: "Введите длинное слово")                .padding(20)
                .padding(.top, 32)
            
            
            WordsTextField(word: $player1, placeHolder: "Player 1")
                .padding(.horizontal, 20)
                .padding(.top)
            
            
            WordsTextField(word: $player2, placeHolder: "Player 2")
                .padding(.horizontal, 20)
                .padding(.top)
            
            Button {
                if bigWord.count > 6 {
                    isShowedGame.toggle()
                } else {
                    self.isAlertPresent.toggle()
                }
            } label: {
                Text("Start")
                    .font(.custom("Inter-Bold", size: 30))
                    .foregroundColor(Color("StartText"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Title"))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
            }
            
            
        }.background(Image("bg"))
            .alert("Длинное слово слишком короткое",
                   isPresented: $isAlertPresent,
                   actions: {
                Text("Ok")
            })
            .fullScreenCover(isPresented: $isShowedGame) {
                let name1 = player1 == "" ? "Игрок 1" : self.player1
                let name2 = player2 == "" ? "Игрок 1" : self.player2
                let player1 = Player.init(name: name1)
                let player2 = Player.init(name: name2)
                let gameViewModel = GameViewModel(player1: player1,
                                                  player2: player2,
                                                  word: self.bigWord)
                
                GameView(viewModel: gameViewModel)
            }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
