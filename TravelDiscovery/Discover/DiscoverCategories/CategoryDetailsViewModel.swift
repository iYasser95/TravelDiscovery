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
    @Published var error: Error?
    private var name: String = ""
    private var url: URL? {
        let stringURL = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased().removeWhiteSpaces)"
        return URL(string: stringURL)
    }
    
    init(name: String) {
        self.name = name
        fetchCategoryDetails()
    }
    
    func fetchCategoryDetails() {
        guard let url = url else { return }
        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = NSError(domain: "", code: statusCode)
                }
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    self.isLoading = false
                    self.error = error
                    return
                }
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                    self.error = error
                }
                self.isLoading = false
            }
        }.resume()
    }
}

private extension String {
    var removeWhiteSpaces: String {
        replacingOccurrences(of: " ", with: "")
    }
}
