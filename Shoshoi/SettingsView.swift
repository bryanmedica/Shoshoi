//
//  ProfileView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 28/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var cardManager: CardManager
    @State var showingResetAlert: Bool = false

    var resetRules: some View {
        Button(action: {
            self.showingResetAlert.toggle()
        }) {
            Image(systemName: "gobackward")
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
    }

    public var body: some View {
        NavigationView {
            List(self.cardManager.rules, id: \.self) { cardRule in
                NavigationLink(destination: EditView(name: cardRule.name,
                                                     desc: UserDefaults.standard.string(forKey:                                                cardRule.name) ?? cardRule.defaultRule)) {
                    CardRow(title: cardRule.name,
                    desc: UserDefaults.standard.string(forKey: cardRule.name) ?? cardRule.defaultRule)
                }
            }
            .navigationBarTitle(Text("Rules"))
            .navigationBarItems(trailing: self.resetRules)
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
            Image(systemName: "chevron.right")
                .foregroundColor(Color("arrow-color"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(CardManager())
    }
}
