//
//  Attraction.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import Foundation
import MapKit

struct Attraction: Identifiable {
    let id = UUID()
    let name: String
    let latitude, longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let all: [Attraction] = [Attraction(name: "Eiffel Tower", latitude: 48.858605, longitude: 2.2946),
                                    Attraction(name: "Champs-Elysees", latitude: 48.866867, longitude: 2.311780),
                                    Attraction(name: "Louvre Museum", latitude: 48.860288, longitude: 2.337789)]
}
