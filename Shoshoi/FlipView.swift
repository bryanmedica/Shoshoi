//
//  FlipView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 27/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct FlipView: View {
    @EnvironmentObject var cardManager: CardManager

    var body: some View {
        VStack {
            ZStack {
                Side(imageName: "shoshoi_back")
                    .rotation3DEffect(.degrees(self.cardManager.isCardFaceUp ? 180.0 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .zIndex(self.cardManager.isCardFaceUp ? 0 : 1)
                    .frame(width: 300, alignment: .center)
                    .background(Color("background"))
                    .onTapGesture {
                        self.handleFlipViewTap()
                        self.cardManager.updateCardDesc()
                    }

                Side(imageName: self.cardManager.actualCard)
                    .background(Color("background"))
                    .rotation3DEffect(.degrees(self.cardManager.isCardFaceUp ? 0.0 : 180.0), axis: (x: 0.0, y: -1.0, z: 0.0))
                    .zIndex(self.cardManager.isCardFaceUp ? 1 : 0)
                    .onTapGesture {
                        self.handleFlipViewTap()
                        self.cardManager.newCard()
                }
            }
        }.background(Color("background"))
}
    
    private func handleFlipViewTap() -> Void {
        withAnimation(.easeOut(duration:0.25)) {
            self.cardManager.isCardFaceUp.toggle()
        }
        if self.cardManager.firstCard {
            self.cardManager.firstCard.toggle()
        }
        else {
            withAnimation(.easeOut(duration:0.35)) {
                self.cardManager.isCardFaceUp.toggle()
            }
        }
    }
    
}

public struct Side: View {
    @EnvironmentObject var cardManager: CardManager
    var imageName: String = ""

    public var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 240, height: 360)
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView().environmentObject(CardManager())
    }
}
