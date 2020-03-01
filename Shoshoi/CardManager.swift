//
//  .swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 27/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

import Combine

let cardsJSON: [Card] = load("cards.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

var beginingCards = [
    "10C", "10D", "10H", "10S", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "AC", "AD", "AH", "AS", "JC", "JD", "JH", "JS", "KC", "KD", "KH", "KS", "QC", "QD", "QH", "QS"
]

var tmp = Array(beginingCards)
var tmpCard = tmp.remove(at: Int.random(in: 0..<52))

final class CardManager: ObservableObject  {
    @Published var actualCard = tmpCard
    @Published var actualDesc = "Je sais plus je suis cuit"
    @Published var cards = Array(tmp)
    @Published var isCardFaceUp = false
    @Published var rules = cardsJSON
    @Published var updateDesc = false
    
    func updateCardDesc() -> Void {
        let cardPrefix = String(self.actualCard.dropLast())
        let cardName = self.rules.first(where: {
            $0.cardPrefix == cardPrefix
        })?.name ?? "Je sais plus je suis cuit"
        if let cardDescription = UserDefaults.standard.string(forKey: cardName) {
            self.actualDesc = cardDescription
        } else {
            self.actualDesc = self.rules.first(where: {$0.cardPrefix == cardPrefix})?.defaultRule ?? "Je sais plus je suis cuit"
        }
        self.updateDesc.toggle()
    }
    
    func newCard() -> Void {
        if self.cards.count > 0 {
            self.actualCard = self.cards.remove(at: Int.random(in: 0..<self.cards.count))
            self.updateCardDesc()
        }
    }
    
    func newGame() -> Void {
        self.cards = Array(beginingCards)
        self.actualCard = self.cards.remove(at: Int.random(in: 0..<52))
        self.updateCardDesc()
        self.isCardFaceUp = false
    }
    
    func clearRules() -> Void {
        for elem in self.rules {
            if let _ = UserDefaults.standard.string(forKey: elem.name) {
                UserDefaults.standard.removeObject(forKey: elem.name)
            }
        }
        self.updateCardDesc()
    }

}
