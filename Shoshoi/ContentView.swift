//
//  ContentView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 27/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var showSettings: Bool = false
    @State private var showingAlert = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showingAlert = true
                }) {
                    Image("shuffle")
                    .foregroundColor(Color.orange)
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Lancer une nouvelle partie"),
                          message: Text("On repart sur un Shoshoi?"),
                          primaryButton: .cancel(Text("T'es un fou toi je finis la partie")),
                          secondaryButton: .default(Text("Nouvelle tournée patron !"), action: {
                            let cardPrefix = String(self.userData.actualCard.dropLast())
                            let cardName = self.userData.rules.first(where: {
                                $0.cardPrefix == cardPrefix
                            })?.name ?? "Je sais plus je suis cuit"
                            self.userData.cards = Array(beginingCards)
                            self.userData.actualCard = self.userData.cards.remove(at: Int.random(in: 0..<52))
                            if let cardDescription = UserDefaults.standard.string(forKey: cardName) {
                                self.userData.actualDesc = cardDescription
                            } else {
                                self.userData.actualDesc = self.userData.rules.first(where: {$0.cardPrefix == cardPrefix})?.defaultRule ?? "Je sais plus je suis cuit"
                            }
                            self.userData.isCardFaceUp = false
                          }))
                }
                Spacer()
                Text("Shoshoi")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Spacer()
                Button(action: {
                    self.showSettings.toggle()
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(Color.orange)
                        .font(.system(size: 28))
                }.sheet(isPresented: $showSettings) {
                    ProfileView()
                        .environmentObject(self.userData)
                }
                }.padding()
                .frame(minWidth: 0.0, maxWidth: .infinity)

            Text("Nombre de cartes restantes : \(userData.cards.count + 1)")
            .foregroundColor(Color.white)
            Spacer()

            FlipView().padding()
            Text((self.userData.isCardFaceUp ?
                self.userData.actualDesc :
                "Tapez sur le paquet pour découvrir la prochaine carte!"))
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
            .environmentObject(UserData())
        .previewDevice("iPhone 6s")
    }
}
