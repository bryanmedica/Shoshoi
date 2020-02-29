//
//  ProfileView.swift
//  Shoshoi
//
//  Created by Bryan MEDICA on 28/02/2020.
//  Copyright © 2020 Bryan MEDICA. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List {
                EditLine(title: "AS",
                         desc: "La personne qui a tiré cette carte devient roi/reine des questions !")
            }.background(Color("background"))
        }.navigationBarTitle("Rules")
    }
}

public struct EditLine: View {
    var title: String = ""
    var desc: String = ""

    public var body: some View {
        HStack {
            Text(self.title)
                .foregroundColor(Color.white)
            Spacer()
            Text(self.desc)
            .foregroundColor(Color.white)
            .padding()
            Image(systemName: "control")
                .foregroundColor(Color.white)
                .rotationEffect(.degrees(90))
        }.background(Color("background"))
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
