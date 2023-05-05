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
    @ObservedObject var viewModel = DestinationDetailsViewModel(name: "")
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = false
    var attractions: [Attraction]  {
        isShowingAttractions ? Attraction.all : Attraction.none
    }
    init(destination: Destinations) {
        self.destination = destination
        self.region = MKCoordinateRegion(center: .init(latitude: destination.latitude,
                                                       longitude: destination.longitude),
                                         span: .init(latitudeDelta: 0.1,
                                                     longitudeDelta: 0.1))
        self.viewModel = DestinationDetailsViewModel(name: destination.name)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else {
                if viewModel.error != nil {
                    ErrorView()
                } else {
                    ScrollView {
                        DestinationHeaderContainer(imageNames: viewModel.destinationDetails?.photos ?? [])
                            .frame(height: 250)
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
                            
                            Text(viewModel.destinationDetails?.description ?? "")
                                .padding(.top, 8)
                                .font(.system(size: 16))
                            
                            HStack { Spacer() }
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Location")
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                            Button {
                                isShowingAttractions.toggle()
                            } label: {
                                Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            Toggle("", isOn: $isShowingAttractions)
                                .labelsHidden()
                        }
                        .padding(.horizontal)
              
                        Map(coordinateRegion: $region,
                            annotationItems: attractions) { attraction in
                            MapMarker(coordinate: attraction.coordinates, tint: .orange)
                        }
                            .frame(height: 300)
                    }
                }
            }
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
