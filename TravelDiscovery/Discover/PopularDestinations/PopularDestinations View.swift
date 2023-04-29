//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Apple on 28/04/2023.
//

import SwiftUI

struct PopularDestinationsView: View {
    
    let destinations: [Destinations] = Destinations.all
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
                        NavigationLink {
                            PopularDestinationDetailsView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                            .padding(.bottom)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PopularDesinationsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
//        PopularDestinationsView()
    }
}
