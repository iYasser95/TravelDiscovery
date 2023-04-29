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

class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Int]()
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.isLoading = false
            self.places = [0, 1, 2]
        })
    }
}

struct CategoryDetailsView: View {
    @ObservedObject private var viewModel = CategoryDetailsViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else {
                ScrollView {
                    ForEach(viewModel.places, id: \.self) { num in
                        VStack(alignment: .leading, spacing: 0) {
                            Image("art1")
                                .resizable()
                                .scaledToFill()
                            Text("Demo")
                                .font(.system(size: 12, weight: .semibold))
                                .padding()
                        }
                        .tileModifier()
                        .padding()
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
