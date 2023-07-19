//
//  OutfitPresenter.swift
//  StyleTag
//
//  Created by Mina Ashna on 14/07/2023.
//

import Foundation
import SwiftUI

class OutfitPresenter {
    func dataToImage(_ data: Data) -> Image? {
        do {
            let decoder = JSONDecoder()
            let imageData = try decoder.decode(Data.self, from: data)
            return try imageData.toImage()
        } catch {
            print("Error converting data to image: \(error)")
            return nil
        }
    }
}
