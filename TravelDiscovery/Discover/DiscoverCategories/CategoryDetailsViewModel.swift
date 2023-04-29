//
//  CategoryDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import Foundation
class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init() {
        let stringURL = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=art"
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }.resume()
    }
}
