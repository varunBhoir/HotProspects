//
//  Prospect.swift
//  HotProspects
//
//  Created by varun bhoir on 26/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
}
