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
var beginingCards: [String] = load("cardsAssetsList.json")

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

var tmp = Array(beginingCards)
var tmpCard = tmp.remove(at: Int.random(in: 0..<52))

final class CardManager: ObservableObject  {
    @Published var actualCard = tmpCard
    @Published var actualDesc = "Je sais plus je suis cuit"
    @Published var cards = Array(tmp)
    @Published var isCardFaceUp = false
    @Published var rules = cardsJSON
    @Published var updateDesc = false
    @Published var firstCard = true
    
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
        self.firstCard = true
    }
    
    func clearRules() -> Void {
        for elem in self.rules {
            if let _ = UserDefaults.standard.string(forKey: elem.name) {
                UserDefaults.standard.removeObject(forKey: elem.name)
            }
        }
        self.rules = cardsJSON
        self.updateCardDesc()
    }

}
