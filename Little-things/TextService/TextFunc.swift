//
//  TextFunc.swift
//  Little-things
//
//  Created by Алексей Езерский on 07.01.2025.
//

import Foundation

//MARK: - Check incorrect characters in text

func notAllowedCharacters(in text: String) -> Int {
    
    let allowedCharacters = " qwertyuiopasdfghjklzxcvbnmйцукенгшщзхъфывапролджэёячсмитьбю"
    var countOfAllowedCharacters = 0
    
    for character in text {
        if (allowedCharacters + allowedCharacters.uppercased()).contains(character) {
            countOfAllowedCharacters += 1
        }
    }
    return text.count - countOfAllowedCharacters
}

//MARK: - Returns random string (use in generate name of file)
func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

