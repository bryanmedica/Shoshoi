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
    @State var showingAlert: Bool = false
    
    var body: some View {
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
            }

            Button(action: {
                self.showingAlert.toggle()
            }) {
                Text("Remettre les règles de départ")
            }.foregroundColor(Color.black)
            .background(Color.orange)
                .alert(isPresented: $showingAlert) {
                Alert(title: Text("Remettre les règles de départ?"),
                      message: Text(""),
                      primaryButton: .cancel(Text("Je garde les miennes")),
                      secondaryButton: .default(Text("On reprend à zéro"), action: {
                        self.cardManager.clearRules()
                }))
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
                .padding()
                .frame(width: 85)
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
