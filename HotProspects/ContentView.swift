//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    let prospects = Prospects()
   
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
            }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
            }
            ProspectsView(filter: .uncontected)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
            }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
            }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
