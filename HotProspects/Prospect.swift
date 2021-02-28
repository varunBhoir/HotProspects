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
    var date = Date()
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] {
        didSet {
            saveDataInDocumentsDirectory()
        }
    }
    
    init() {
        people = []
        loadDataFromDocumentsDirectory()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        saveDataInDocumentsDirectory()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
    }
    
    private func saveDataInDocumentsDirectory() {
        let fileName = "People"
        let pathURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let encodedPeople = try? JSONEncoder().encode(people)
            try encodedPeople?.write(to: pathURL, options: [.atomicWrite, .completeFileProtection])
        }
        catch {
            print("Unable to save data")
        }
    }
    
    private func loadDataFromDocumentsDirectory() {
        let fileName = "People"
        let pathURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: pathURL)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        }
        catch {
            print("Unable to load data")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
