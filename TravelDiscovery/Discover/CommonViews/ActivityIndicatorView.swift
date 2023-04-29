//
//  ActivityIndicatorView.swift
//  TravelDiscovery
//
//  Created by Apple on 28/04/2023.
//

import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        VStack(alignment: .center) {
            ActivityIndicatorLoadingView()
            Text("Loading..")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
    }
}

struct ActivityIndicatorLoadingView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.color = .white
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        // No implementation needed
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
