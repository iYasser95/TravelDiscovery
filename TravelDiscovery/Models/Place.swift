//
//  Place.swift
//  TravelDiscovery
//
//  Created by Apple on 29/04/2023.
//

import Foundation
import Kingfisher
struct Place: Decodable, Hashable {
    let name, thumbnail: String

     var image: KFImage {
        guard let url = URL(string: thumbnail) else { return KFImage(source: .none) }
        return KFImage(url)
    }
}
