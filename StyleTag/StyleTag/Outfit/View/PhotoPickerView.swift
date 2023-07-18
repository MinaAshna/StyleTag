//
//  CameraView.swift
//  StyleTag
//
//  Created by Mina Ashna on 11/07/2023.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
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
            OutfitImageView(imageState: outfitModel.imageState)
                .scaledToFit()
                .padding()
            
            Spacer()
            
            PhotosPicker(selection: $outfitModel.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
                Text("Choose a photo from your library")
                    .padding(16)
                    .foregroundColor(.white)
                    .background(.black)
                    .padding()
            }
                        
            if case OutfitModel.ImageState.success(_, _) = outfitModel.imageState {
                Button {
                    let outfitMoc = Outfit(context: moc)
                    outfitMoc.id = UUID()
                    outfitMoc.name = outfitModel.name
                    
                    let encoder = JSONEncoder()
                    if let data = try? encoder.encode(outfitModel.selectedImageData) {
                        outfitMoc.image = data
                    }
                    try? moc.save()
                    
                    dismiss()
                } label: {
                    Text("Save my outfit")
                        .padding(16)
                        .foregroundColor(.white)
                        .background(.black)
                        .padding(4)
                }
            }
        }
    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}


