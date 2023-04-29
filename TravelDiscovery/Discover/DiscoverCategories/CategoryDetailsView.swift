//
//  CategoryDetailsView.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import SwiftUI

struct CategoryDetailsView: View {
    init(name: String) {
        self.name = name
        self.viewModel = CategoryDetailsViewModel(name: name)
    }
    private let name: String
    @ObservedObject private var viewModel: CategoryDetailsViewModel
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else {
                ZStack {
                    if  viewModel.error != nil {
                        ErrorView(action: viewModel.fetchCategoryDetails)
                    }
                    ScrollView {
                        ForEach(viewModel.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0) {
                                place.image
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
        .navigationBarTitle(name, displayMode: .inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Category Name")
        }
    }
}
