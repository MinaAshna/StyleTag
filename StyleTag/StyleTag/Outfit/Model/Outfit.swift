//
//  OutfitModel.swift
//  StyleTag
//
//  Created by Mina Ashna on 13/07/2023.
//

import SwiftUI
import PhotosUI

enum TransferError: Error {
    case importFailed
}

//@MainActor
class OutfitModel: ObservableObject {
    
    init(imageState: ImageState = .empty) {
        self.imageState = imageState
    }
    
    // MARK: - Profile Details
    
    @Published var name: String = ""
    @Published var aboutMe: String = ""
    var selectedImageData: Data?
    
    // MARK: - Profile Image
    
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image, Data)
        case failure(Error)
    }
    
    
    
    struct OutfitImage: Transferable {
        let image: Image
        let imageData: Data
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                do {
                    return try OutfitImage(image: data.toImage(), imageData: data)
                } catch {
                    throw error
                }
            }
        }
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: OutfitImage.self) { result in
            Task { @MainActor in
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let outfitImage?):
                    self.imageState = .success(outfitImage.image, outfitImage.imageData)
                    self.selectedImageData = outfitImage.imageData
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

extension Data {
    func toImage() throws -> Image {
#if canImport(AppKit)
        guard let nsImage = NSImage(data: self) else {
            throw TransferError.importFailed
        }
        return Image(nsImage: nsImage)
#elseif canImport(UIKit)
        guard let uiImage = UIImage(data: self) else {
            throw TransferError.importFailed
        }
        return Image(uiImage: uiImage)
#else
        throw TransferError.importFailed
#endif
    }
}
