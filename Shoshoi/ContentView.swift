//
//  ContentView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 27/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cardManager: CardManager

    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.init(red: 55 / 255, green: 57 / 255, blue: 63 / 255, alpha: 1)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UITableView.appearance().backgroundColor = UIColor.init(red: 55 / 255, green: 57 / 255, blue: 63 / 255, alpha: 1)
        UITableViewCell.appearance().backgroundColor = UIColor.init(red: 55 / 255, green: 57 / 255, blue: 63 / 255, alpha: 1)
    }
    
    var body: some View {
        VStack {
            
            TopBar()

            Text("Nombre de cartes restantes : \(cardManager.cards.count + 1)")
            .foregroundColor(Color.white)
            Spacer()

            FlipView().padding()

            Text((self.cardManager.isCardFaceUp ? self.cardManager.actualDesc
                : "Tapez sur le paquet pour découvrir la prochaine carte!"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .foregroundColor(Color.white)
                .padding()
            Spacer()

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
            .background(Color("background")
            .edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CardManager())
        .previewDevice("iPhone 6s")
    }
}
