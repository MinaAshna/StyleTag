//
//  CameraView.swift
//  StyleTag
//
//  Created by Mina Ashna on 11/07/2023.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel? = nil) {
        if let viewModel = viewModel {
            self.viewModel = viewModel
        } else {
            self.viewModel = ViewModel()
        }
    }
    
    var body: some View {
        PhotosPicker(selection: $viewModel.imageSelection,
                     matching: .images,
                     photoLibrary: .shared()) {
            Text("Choose a photo from your library")
                .font(.system(size: 18))
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}

class ViewModel: ObservableObject {
    @Published var imageSelection: PhotosPickerItem? = nil
}
