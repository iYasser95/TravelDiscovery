//
//  Destinations.swift
//  TravelDiscovery
//
//  Created by Apple on 28/04/2023.
//

import Foundation

struct Destinations: Hashable {
    let name, country, imageName: String
    let latitude, longitude: Double
    
    static let all: [Destinations] = [Destinations(name: "Paris", country: "France", imageName: "france", latitude: 48.859565, longitude: 2.353235),
                                      Destinations(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.679693, longitude: 139.771913),
                                      Destinations(name: "New York", country: "US", imageName: "new_york", latitude: 40.71592, longitude: -74.0055)]
}
