//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab = "varun"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Text("Varun Bhoir")
                Text("Tap here to see his crush")
                    .padding()
                    .onTapGesture {
                        self.selectedTab = "riya"
                }
            }
            .tabItem {
                Image(systemName: "person")
                Text("varun")
            }
            .tag("varun")
            
            VStack {
                Text("Riya Kasbekar")
                Text("Tap here to see her crush")
                    .padding()
                    .onTapGesture {
                        self.selectedTab = "varun"
                }
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Riya")
            }
            .tag("riya")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
