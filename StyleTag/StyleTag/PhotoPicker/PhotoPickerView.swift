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
    @ObservedObject private var photoPickerModel: PhotoPickerModel

    init(viewModel: PhotoPickerModel? = nil) {
        if let viewModel = viewModel {
            self.photoPickerModel = viewModel
        } else {
            self.photoPickerModel = PhotoPickerModel()
        }
    }
    
    var body: some View {
        VStack {
            OutfitImageView(imageState: photoPickerModel.imageState)
                .scaledToFit()
                .padding()
            
            Spacer()
            
            PhotosPicker(selection: $photoPickerModel.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
                Text("Choose a photo from your library")
                    .padding(16)
                    .foregroundColor(.white)
                    .background(.black)
                    .padding()
            }
                        
            if case PhotoPickerModel.ImageState.success(_, _) = photoPickerModel.imageState {
                Button {
                    let outfitMoc = Outfit(context: moc)
                    outfitMoc.id = UUID()
                    
                    let encoder = JSONEncoder()
                    if let data = try? encoder.encode(photoPickerModel.selectedImageData) {
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


