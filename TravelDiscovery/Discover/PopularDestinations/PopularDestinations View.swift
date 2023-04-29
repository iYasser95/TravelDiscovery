//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Apple on 28/04/2023.
//

import SwiftUI

struct PopularDestinationsView: View {
    
    let destinations: [Destinations] = [
        Destinations(name: "Paris", country: "France", imageName: "france"),
        Destinations(name: "Tokyo", country: "Japan", imageName: "japan"),
        Destinations(name: "New York", country: "US", imageName: "new_york"),
    ]
    var body: some View {
        VStack {
            HStack {
                Text("Popular destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(destinations, id: \.self) { destination in
                        VStack(alignment: .leading, spacing: 0) {
                            Image(destination.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(5)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
                            Text(destination.name)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                            Text(destination.country)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.bottom, 8)
                                .foregroundColor(.gray)
                        }
                        .tileModifier()
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


struct PopularDesinationsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationsView()
    }
}
