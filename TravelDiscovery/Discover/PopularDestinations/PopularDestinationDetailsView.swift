//
//  PopularDestinationDetailsView.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import SwiftUI
import MapKit

struct PopularDestinationDetailsView: View {
    let destination: Destinations
    @State var region: MKCoordinateRegion
    
    init(destination: Destinations) {
        self.destination = destination
        self.region = MKCoordinateRegion(center: .init(latitude: destination.latitude,
                                                       longitude: destination.longitude),
                                         span: .init(latitudeDelta: 0.1,
                                                     longitudeDelta: 0.1))
    }
    var body: some View {
        ScrollView {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading) {
                
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.top, 2)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    .padding(.top, 8)
                    .font(.system(size: 16))
                
                HStack { Spacer() }
            }
            .padding(.horizontal)
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal)
           
            Map(coordinateRegion: $region)
                .frame(height: 200)
        }
        .navigationBarTitle(destination.name, displayMode: .inline)
    }
}

struct PopularDestinationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destination: Destinations.all[0])
        }
    }
}
