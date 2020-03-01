//
//  EditView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 01/03/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct EditView: View {

    @EnvironmentObject var cardManager: CardManager
    var name: String
    @State var desc: String

    public var body: some View {
        VStack {
            HStack {
                TextField("Entrez la règle", text: $desc, onEditingChanged: { (changed) in
                    if !changed {
                        UserDefaults.standard.set(self.desc, forKey: self.name)
                        self.cardManager.sale = !(self.cardManager.sale)
                        print("C'est fait : \(self.desc)")
                    }
                }) {
                }.foregroundColor(.white)
                    .padding()

                
                Button(action: {
                    self.desc = ""
                    UserDefaults.standard.set(self.desc, forKey: self.name)
                    self.cardManager.sale = !(self.cardManager.sale)
                    print("C'est fait : \(self.desc)")
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.gray)
                    .padding()
                }
            }.background(Color("bg-clear"))
                .border(Color.white, width: 1)
                .padding([.vertical])
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
        .background(Color("background")
        .edgesIgnoringSafeArea(.all))
        .navigationBarTitle(Text(self.name), displayMode: .inline)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(name: "AS", desc: "Tout le monde boit").environmentObject(CardManager())
    }
}
