//
//  ErrorView.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import SwiftUI

struct ErrorView: View {
    
    var action: (() -> Void)?
    @State private var reloadCount = 3
    private var isEnabled: Bool {
        reloadCount > 0
    }
    private var errorTitle: String {
        reloadCount == 0 ? "Too many requests" : "Something went wrong"
    }
    
    private var errorMessage: String {
        // If there's no action then the user doesn't have the option to reload.
        if action == nil { return "" }
        return reloadCount == 0 ? "Please try later again" :
                           "Details could not be loaded, please try again"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.red)
            Group {
                Text(errorTitle)
                    .font(.system(size: 16, weight: .bold))
                Text(errorMessage)
                    .font(.system(size: 16))
            }
            if let action = action {
                // Show the button only if there's an action for the user to reload the page.
                Button() {
                    self.reloadCount -= 1
                    action()
                } label: {
                    Text("Please try again")
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                        .opacity(isEnabled ? 1 : 0)
                }
                .padding(.top)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(action: nil)
    }
}
