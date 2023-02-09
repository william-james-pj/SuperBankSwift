//
//  GeneratePasswordButtonText.swift
//  Login
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import Foundation

struct ButtonPasswordText {
    let first: Int
    let second: Int
}

class GeneratePasswordButtonText {
    func generationText() -> [ButtonPasswordText] {
        var passArray: [Int] = []
        while passArray.count != 10 {
            passArray.append(self.random(haveIt: passArray))
        }

        var texts: [ButtonPasswordText] = []
        for index in stride(from: 0, to: 9, by: 2) {
            let new = ButtonPasswordText(first: passArray[index], second: passArray[index+1])
            texts.append(new)
        }

        return texts
    }

    fileprivate func random(haveIt: [Int]) -> Int {
        let randomNumber = Int.random(in: 0...9)
        if haveIt.contains(randomNumber) {
            return self.random(haveIt: haveIt)
        }
        return randomNumber
    }
}
