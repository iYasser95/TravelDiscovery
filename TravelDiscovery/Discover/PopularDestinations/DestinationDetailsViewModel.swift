//
//  DestinationDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Apple on 05/05/2023.
//

import Foundation
class DestinationDetailsViewModel: ObservableObject {
    @Published var destinationDetails: DestinationDetailsModel?
    @Published var isLoading = true
    @Published var error: Error?
    private var url: (String) -> URL? = { name in
        let stringURL = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())"
        guard let fixedURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: fixedURL)
    }

    init(name: String) {
        guard let url = url(name) else {
            self.isLoading = false
            self.error = NSError(domain: "", code: 404)
            return
        }
        fetchDetails(with: url)
    }

    private func fetchDetails(with url: URL) {
        self.isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.error = NSError(domain: "", code: statusCode)
                    }
                    return
                }
                guard let data = data, error == nil else {
                    self.isLoading = false
                    self.error = error
                    return
                }
                do {
                    self.destinationDetails = try JSONDecoder().decode(DestinationDetailsModel.self, from: data)
                } catch {
                    print("Failed to decode")
                    self.error = error
                }
                
                self.isLoading = false
            }
            
        }.resume()
    }
}
