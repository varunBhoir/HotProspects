//
//  ProspectsView.swift
//  HotProspects
//
//  Created by varun bhoir on 26/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

enum SortType {
    case mostRecent, name
}

enum FilterType {
    case none, contacted, uncontected
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showSortedActionSheet = false
    let filter: FilterType
    @State var sortby: SortType = .name
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
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var filteredSortedProspects: [Prospect] {
        switch sortby {
        case .mostRecent:
            return filteredProspects.sorted {
                $0.date > $1.date
            }
        case .name:
            return filteredProspects.sorted {
                $0.name < $1.name
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSortedProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "envelope" : "envelope.badge")
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind me") {
                                self.addNotification(prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button("Sort") {
                self.showSortedActionSheet = true
                }, trailing:  Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
            })
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Varun Bhoir\nbhoirvarun6@gmail.com", completion: self.handleScan)
        }
        .actionSheet(isPresented: $showSortedActionSheet) {
            return ActionSheet(title: Text("Sort People By..."), buttons:
                [
                    .default(Text((self.sortby == .mostRecent ? "✓ " : "") + "Most Recent")) {
                        self.sortby = .mostRecent
                    },
                    .default(Text((self.sortby == .name ? "✓ " : "") + "Name")) {
                        self.sortby = .name
                    }
                ]
            )
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let prospect = Prospect()
            prospect.name = details[0]
            prospect.emailAddress = details[1]
            prospects.add(prospect)
        case .failure(let error):
            print("Scanning failed- \(error.localizedDescription)")
        }
    }
    
    func addNotification(_ prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = "\(prospect.emailAddress)"
            content.sound = UNNotificationSound.default
            
            //            var dateComponents = DateComponents()
            //            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("User is not allowing for notifications to show")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none, sortby: .name).environmentObject(Prospects())
    }
}
