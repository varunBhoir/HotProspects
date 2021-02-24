//
//  ContentView.swift
//  HotProspects
//
//  Created by varun bhoir on 21/02/21.
//  Copyright © 2021 varun bhoir. All rights reserved.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    @State private var message = "Hello world"
    
    var body: some View {
        Text(message)
            .onAppear {
                self.fetchData(from: "https://www.apple.com") { result in
                    switch result {
                    case .success(let str):
                        print(str)
                        self.message = "success"
                    case .failure(let error):
                        switch error {
                        case .badURL:
                            print("Invalid url")
                            self.message = "Invalid url"
                        case .requestFailed:
                            print("Network problems")
                            self.message = "Network problems"
                        case .unknown:
                            print("Unknown")
                            self.message = "Unknown"
                        }
                    }
                }
        }
    }
    
    
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // check for the url is good or not else bad url
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    // convertu that data into string to use in closure
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // an error is occured
                    completion(.failure(.requestFailed))
                } else {
                    // it is not possible but still
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
