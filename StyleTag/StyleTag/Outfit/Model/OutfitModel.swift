//
//  OutfitModel.swift
//  StyleTag
//
//  Created by Mina Ashna on 19/07/2023.
//

import Foundation
import SwiftUI

class OutfitModel: ObservableObject {
    @Published var image: Image
    @Published var tags: [String] = []
    @Published var createdData: Date
    
    // For later
    // Temperature
    // Location
    
    init(image: Image, createdData: Date) {
        self.image = image
        self.createdData = createdData
    }
}
