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
        /* Shoshoi's app color */
        let backgroundColor: UIColor = UIColor.init(red: 55 / 255, green: 57 / 255, blue: 63 / 255, alpha: 1)

        /* Buttons color */
        UINavigationBar.appearance().tintColor = UIColor.orange

        /* Navigation bars color */
        UINavigationBar.appearance().barTintColor = backgroundColor

        /* Titles colors */
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        /* List table color */
        UITableView.appearance().backgroundColor = backgroundColor

        /* Cell color */
        UITableViewCell.appearance().backgroundColor = backgroundColor
    }
    
    var body: some View {
        VStack {
            
            TopBar()

            Text("Nombre de cartes restantes : \(self.cardManager.cards.count + 1)")
            .foregroundColor(Color.white)
            Spacer()

            FlipView().padding()

            Text((self.cardManager.isCardFaceUp ? self.cardManager.actualDesc : "Tapez sur le paquet!"))
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
