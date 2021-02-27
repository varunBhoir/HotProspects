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
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] {
        didSet {
            saveData()
        }
    }
    static let saveKey = "SavePeople"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Prospects.saveKey) {
            if let decodedPeople = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decodedPeople
                return
            }
        }
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        saveData()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
    }
    
    private func saveData() {
        if let encodedPeople = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encodedPeople, forKey: Prospects.saveKey)
        } else {
            print("Failed to encode the people")
        }
    }
}
