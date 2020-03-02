//
//  ProfileView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 28/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var cardManager: CardManager
    @State var showingResetAlert: Bool = false
    @State var showingShortenAlert: Bool = false

    var toolsButtons: some View {
        HStack {
            Button(action: {
                self.showingResetAlert.toggle()
            }) {
                Image(systemName: "arrow.2.circlepath")
                    .foregroundColor(Color.orange)
                    .font(.system(size: 28))
            }
            .alert(isPresented: $showingResetAlert) {
                Alert(title: Text("Remettre les règles de départ?"),
                      message: Text(""),
                      primaryButton: .default(Text("On reprend à zéro"), action: {
                              self.cardManager.clearRules()
                      }),
                      secondaryButton: .cancel(Text("Je garde les miennes")))
            }
            .position(x: 10, y: 10)

            Button(action: {
                self.showingShortenAlert.toggle()
            }) {
                Image(systemName: "scissors")
                    .foregroundColor(Color.orange)
                    .font(.system(size: 28))
            }.foregroundColor(Color.white)
            .alert(isPresented: $showingShortenAlert) {
                Alert(title: Text("Raccourcir les règles ?"),
                      message: Text(""),
                      primaryButton: .default(Text("Oui mon iPhone est trop petit..."), action: {
                        self.cardManager.shortenCards()
                      }),
                      secondaryButton: .cancel(
                        Text("Non, je connais les règles par coeur")
                    ))
            }
            .position(x: 10, y: 10)
        }
    }

    public var body: some View {
        VStack {
            NavigationView {
                List(self.cardManager.rules, id: \.self) { cardRule in
                    NavigationLink(destination: EditView(name: cardRule.name,
                        desc: UserDefaults.standard.string(forKey: cardRule.name) ?? cardRule.defaultRule)) {
                        CardRow(title: cardRule.name,
                        desc: UserDefaults.standard.string(forKey: cardRule.name) ?? cardRule.defaultRule)
                        .listRowBackground(Color("background"))
                    }
                }
                .navigationBarTitle(Text("Rules"))
                .navigationBarItems(trailing: self.toolsButtons)
            }
        }
    }
}

public struct CardRow: View {
    var title: String = ""
    var desc: String = ""

    public var body: some View {
        HStack {
            Text(self.title)
                .foregroundColor(Color.white)
                .frame(width: 80)
            Text(self.desc)
                .foregroundColor(Color.white)
                .padding([.vertical])
            Spacer()
        }.background(Color("background"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(CardManager())
    }
}
