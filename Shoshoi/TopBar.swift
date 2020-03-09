//
//  TopBar.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 01/03/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    @EnvironmentObject var cardManager: CardManager
    @State var showSettings: Bool = false
    @State private var showingAlert = false

    var body: some View {
        HStack {
            Button(action: {
                self.showingAlert = true
            }) {
                Image("shuffle")
                .foregroundColor(Color.orange)
                .font(.system(size: 28))
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Lancer une nouvelle partie"),
                      message: Text("On repart sur un Shoshoi?"),
                      primaryButton: .cancel(Text("T'es un fou toi je finis la partie")),
                      secondaryButton: .default(Text("Nouvelle tournée patron !"), action: {
                        self.cardManager.newGame()
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
                Image(systemName: "rectangle.on.rectangle.angled")
                    .foregroundColor(Color.orange)
                    .font(.system(size: 28))
                    .rotationEffect(Angle(degrees: 90))
            }.sheet(isPresented: $showSettings) {
                SettingsView().environmentObject(self.cardManager)
            }
        }.padding()
        .frame(minWidth: 0.0, maxWidth: .infinity)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar().environmentObject(CardManager()).previewDevice("iPhone SE")
    }
}
