//
//  GameViewModel.swift
//  WordsGame
//
//  Created by Сергей Молодец on 30.06.2022.
//

import Foundation
import UIKit

enum WordError : Error {
    case theSameWord
    case beforeWord
    case littleWord
    case wrongWord
    case undefinedError
    case mistakeWord
}

class GameViewModel: ObservableObject {
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    let word: String
    var isFirst = true

    init(player1: Player, player2: Player, word: String) {
        
        self.player1 = player1
        self.player2 = player2
        self.word = word.uppercased()
    }
   
    func isReal(word: String) -> Bool {
        let textCheck = UITextChecker()
        let text = textCheck.rangeOfMisspelledWord(in: word, range: NSRange(location: 0, length: word.utf16.count), startingAt: 0, wrap: true, language: "ru")
        return text.location == NSNotFound
    }
    
    func validate(word: String) throws {
        let word = word.uppercased()

        guard isReal(word: word) else {
            print("Слово с ошибкой")
            throw WordError.mistakeWord
        }
        guard word != self.word else {
            print("Не должно совпадать с исходным словом.")
            throw WordError.theSameWord
        }
        guard !(self.words.contains(word)) else {
            print("Не повторяйся!")
            throw WordError.beforeWord
        }
        guard word.count > 2 else {
            print("Слово слишком маленькое.")
            throw WordError.littleWord
        }

        return
    }
    
    func wordToChars(word: String) -> [Character] {
        var chars = [Character]()
        for char in word.uppercased() {
            chars.append(char)
        }
        return chars
    }
    
    func check(word: String) throws -> Int {
        do {
        try self.validate(word: word)
        } catch {
            throw error
        }
        var bigWordArray = wordToChars(word: self.word)
        let smallWordArray = wordToChars(word: word)
        var result = ""
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i += 1
                }
                bigWordArray.remove(at: i)
            } else {
                throw WordError.wrongWord
            }
        }
        
        guard result == word.uppercased() else {
            print("Какая то ошибка")
            return 0
        }
        
        words.append(result)
        if isFirst {
            player1.add(score: result.count)
        } else {
            player2.add(score: result.count)
        }
        
        isFirst.toggle()
        
        return result.count
        
        
    }
}
