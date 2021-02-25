//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import UserNotifications
import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack {
            Button("Request notifications") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule notifications") {
                let content = UNMutableNotificationContent()
                content.title = "February is almost over"
                content.subtitle = "Checkout some cute gifts for your loved ones"
                content.sound = UNNotificationSound.default
                
                // show this notification 5 seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
