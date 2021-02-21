//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Riya Kasbekar"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    let user = User()
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
