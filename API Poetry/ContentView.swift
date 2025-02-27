//
//  ContentView.swift
//  API Poetry
//
//  Created by Carson Payne on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    @State var authors = [String]()
    var body: some View {
        NavigationView {
            List(authors, id:\.self) { author in
                NavigationLink(destination: Text(author)) {
                    Text (author)
                }
            }
            .navigationTitle("Poetry Authors")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await getAuthors()
        }
    }
    func getAuthors() async {
        let query = "https://poetrydb.org//author"
        if let url = URL(string: query) {
            if let (data, _) = try? await URLSession.shared.data(from: url) {
                if let decodedResponse = try? JSONDecoder().decode(Authors.self, from: data) {
                    authors = decodedResponse.authors
                }
            }
        }
    }
}

struct Authors: Codable {
    var authors: [String]
}
#Preview {
    ContentView()
}
