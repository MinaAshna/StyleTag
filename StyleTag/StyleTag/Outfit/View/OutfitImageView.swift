//
//  OutfitImageView.swift
//  StyleTag
//
//  Created by Mina Ashna on 13/07/2023.
//

import SwiftUI

struct OutfitImageView: View {
    let imageState: OutfitModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()

        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct OutfitImageView_Previews: PreviewProvider {
    static var previews: some View {
        OutfitImageView(imageState: .empty)
    }
}
