//
//  GameView.swift
//  WordsGame
//
//  Created by Сергей Молодец on 29.06.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal, 16)
                        .background(Color("Title"))
                        .foregroundColor(Color("StartText"))
                        .font(.custom("Inter-Bold", size: 18))
                        .cornerRadius(12)
                        .padding(6)
                }
                Spacer()
            }
            
            Text(viewModel.word)
                .font(.custom("Inter-Bold", size: 30))
                .foregroundColor(Color(.white))
            HStack(spacing: 12) {
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("Inter-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.player1.name)
                        .font(.custom("Inter-Bold", size: 24))
                        .foregroundColor(.white)
                    
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .blue : .clear,
                            radius: 4,
                            x: 0,
                            y: 0)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("Inter-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.player2.name)
                        .font(.custom("Inter-Bold", size: 24))
                        .foregroundColor(.white)
                    
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .clear : .red,
                            radius: 4,
                            x: 0,
                            y: 0)
                
            }.padding(.top)
            WordsTextField(word: $word, placeHolder: "Введите ваше слово")
                .padding(.horizontal)
            Button {
                var score = 0
                
                do {
                    try score = viewModel.check(word: self.word)
                } catch WordError.mistakeWord {
                    alertText = "Слово с ошибкой!"
                    isAlertPresent.toggle()
                } catch WordError.beforeWord {
                    alertText = "Не повторяйся!"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "Слово слишком маленькое."
                    isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "Не должно совпадать с исходным словом."
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено."
                } catch {
                    alertText = "Не известная ошибка."
                }
                
                if score > 1 {
                    self.word = "" }
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(Color("StartText"))
                    .frame(maxWidth: .infinity)
                    .background(Color("Title"))
                    .font(.custom("Inter-Bold", size: 26))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
            }
            
            List {
                ForEach(0..<self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                }
                
            }.listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity )
            
            
        }.background(Image("bg"))
            .confirmationDialog("Вы уверены что хотите завершить игру?",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                Button(role: .cancel) { } label: {
                    Text("Нет")
                }
                
                
                
            }
                                .alert(alertText,
                                       isPresented: $isAlertPresent) {
                                    Text("Ok")
                                }
        
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Саня"), player2: Player(name: "Федя"), word: "Жопострел"))
    }
}
