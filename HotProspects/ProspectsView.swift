//
//  ProspectsView.swift
//  HotProspects
//
//  Created by varun bhoir on 26/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI

enum FilterType {
    case none, contacted, uncontected
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontected:
            return "Uncontacted"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontected:
            return prospects.people.filter { !$0.isContacted}
        }
        
    }
        
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                let prospect = Prospect()
                prospect.name = "Varun Bhoir"
                prospect.emailAddress = "bhoirvarun6@gmail.com"
                self.prospects.people.append(prospect)
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
