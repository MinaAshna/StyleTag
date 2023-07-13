//
//  CameraView.swift
//  StyleTag
//
//  Created by Mina Ashna on 11/07/2023.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @ObservedObject private var outfitModel: OutfitModel
    
    init(viewModel: OutfitModel? = nil) {
        if let viewModel = viewModel {
            self.outfitModel = viewModel
        } else {
            self.outfitModel = OutfitModel()
        }
    }
    
    var body: some View {
        VStack {
     
            Spacer()
            
            OutfitImageView(imageState: outfitModel.imageState)
                .scaledToFit()
            
            Spacer()
            
            PhotosPicker(selection: $outfitModel.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
                Text("Choose a photo from your library")
                    .foregroundColor(.black)
            }
            
            Spacer()
                        
        }
    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}

