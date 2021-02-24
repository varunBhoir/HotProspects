//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
