//
//  ErrorView.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import SwiftUI

struct ErrorView: View {
    
    var action: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.red)
            Group {
                Text("Something went wrong")
                    .font(.system(size: 16, weight: .bold))
                Text("Details could not be loaded, please try again")
                    .font(.system(size: 16))
            }
            Button() {
                if let action = action {
                    action()
                }
            } label: {
                Text("Please try again")
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
            }
            .padding(.top)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(action: nil)
    }
}
