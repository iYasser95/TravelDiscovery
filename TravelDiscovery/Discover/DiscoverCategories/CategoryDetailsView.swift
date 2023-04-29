//
//  CategoryDetailsView.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import SwiftUI

struct CategoryDetailsView: View {
    @ObservedObject private var viewModel = CategoryDetailsViewModel()
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else {
                ZStack {
                    Text(viewModel.errorMessage)
                    ScrollView {
                        ForEach(viewModel.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0) {
                                Image("art1")
                                    .resizable()
                                    .scaledToFill()
                                Text(place.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding()
                            }
                            .tileModifier()
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Category", displayMode: .inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView()
    }
}
