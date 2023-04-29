//
//  DiscoverCategoriesView.swift
//  TravelDiscovery
//
//  Created by Apple on 28/04/2023.
//

import SwiftUI

struct DiscoverCategoriesView: View {
    let categories: [Category] = [
        Category(name: "Art", imageName: "paintpalette.fill"),
        Category(name: "Sport", imageName: "sportscourt.fill"),
        Category(name: "Live Events", imageName: "music.mic"),
        Category(name: "Food", imageName: "cart.fill"),
        Category(name: "History", imageName: "chart.bar.fill")
    ]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink {
                        CategoryDetailsView()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: category.imageName)
                                .font(.system(size: 20))
                                .frame(width: 64, height: 64)
                                .foregroundColor(Color.orange)
                                .background(Color.white)
                                .cornerRadius(.infinity)
                            Text(category.name)
                                .font(.system(size: 12, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }.frame(width: 68)
                    }

                }
            }
            .padding(.horizontal)
        }
    }
}

struct Place: Decodable, Hashable {
    let id, name, thumbnail: String
}

class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init() {
        let stringURL = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=art"
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }.resume()
    }
}

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

struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView()
        }
        DiscoverView()
//        ZStack {
//            Color.orange
//            DiscoverCategoriesView()
//        }
    }
}
