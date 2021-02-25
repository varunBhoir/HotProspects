//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Riya Kasbekar")
                .padding()
                .background(backgroundColor)
            Text("Change color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                        Image(systemName: "checkmark.circle.fill")
                    }
                    Button(action: {
                        self.backgroundColor = .yellow
                    }) {
                        Text("Yellow")
                    }
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
