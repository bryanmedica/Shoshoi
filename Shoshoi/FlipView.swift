//
//  FlipView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 27/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct FlipView: View {
    @EnvironmentObject var userData: UserData
    @State var desc: String = "Tapez sur le paquet pour découvrir la prochaine carte!"

    var body: some View {
        VStack {
            ZStack {
                Side(imageName: "shoshoi_back")
                    .rotation3DEffect(.degrees(self.userData.isCardFaceUp ? 180.0 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .zIndex(self.userData.isCardFaceUp ? 0 : 1)
                    .frame(width: 300, alignment: .center)
                    .background(Color("background"))
                    .onTapGesture {
                        self.handleFlipViewTap()
                        let cardPrefix = String(self.userData.actualCard.dropLast())
                        let cardName = self.userData.rules.first(where: {
                            $0.cardPrefix == cardPrefix
                        })?.name ?? "Je sais plus je suis cuit"
                        if let cardDescription = UserDefaults.standard.string(forKey: cardName) {
                            self.userData.actualDesc = cardDescription
                        } else {
                            self.userData.actualDesc = self.userData.rules.first(where: {$0.cardPrefix == cardPrefix})?.defaultRule ?? "Je sais plus je suis cuit"
                        }
                    }

                Side(imageName: self.userData.actualCard)
                    .background(Color("background"))
                    .rotation3DEffect(.degrees(self.userData.isCardFaceUp ? 0.0 : 180.0), axis: (x: 0.0, y: -1.0, z: 0.0))
                    .zIndex(self.userData.isCardFaceUp ? 1 : 0)
                    .onTapGesture {
                        self.handleFlipViewTap()
                        self.newCard()
                        let cardPrefix = String(self.userData.actualCard.dropLast())
                        let cardName = self.userData.rules.first(where: {
                            $0.cardPrefix == cardPrefix
                        })?.name ?? "Je sais plus je suis cuit"
                        if let cardDescription = UserDefaults.standard.string(forKey: cardName) {
                            self.userData.actualDesc = cardDescription
                        } else {
                            self.userData.actualDesc = self.userData.rules.first(where: {$0.cardPrefix == cardPrefix})?.defaultRule ?? "Je sais plus je suis cuit"
                        }
                }
            }
        }.background(Color("background"))
}
    
    private func handleFlipViewTap() -> Void {
        withAnimation(.easeOut(duration:0.25)) {
            self.userData.isCardFaceUp.toggle()
        }
    }
    
    private func newCard() -> Void {
        if self.userData.cards.count > 0 {
            self.userData.actualCard = self.userData.cards.remove(at: Int.random(in: 0..<self.userData.cards.count))
        }
    }
}

public struct Side: View
{
    @EnvironmentObject var userData: UserData
    var imageName: String = ""

    public var body: some View
    {
        Image(
            (imageName == "shoshoi_back" ? "shoshoi_back": userData.actualCard))
            .resizable()
            .frame(width: 240, height: 360)
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView()
            .environmentObject(UserData())
    }
}
