//
//  OutfitsView.swift
//  StyleTag
//
//  Created by Mina Ashna on 14/07/2023.
//

import SwiftUI

struct OutfitsView: View {
    @FetchRequest(sortDescriptors: []) var outfits: FetchedResults<Outfit>
    @State var isPresented = false
    var presenter: OutfitPresenter
    
    init(presenter: OutfitPresenter? = nil) {
        if let presenter = presenter {
            self.presenter = presenter
        } else {
            self.presenter = OutfitPresenter()
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                List(outfits) { outfit in
                    if let imageData = outfit.image,
                       let image = presenter.dataToImage(imageData) {
                        NavigationLink {
                            OutfitDetailsView(outfitModel: OutfitModel(image: image, createdData: .now))
                        } label: {
                            image
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                
                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("+")
                        .font(.title)
                        .padding()
                }
                .background(.black)
                .frame(width: 45, height: 45)
                .cornerRadius(22.5)
                .foregroundColor(.white)
                .padding()
            }
        }
        .sheet(isPresented: $isPresented) {
            PhotoPickerView()
        }
    }
}

struct OutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        OutfitsView()
    }
}
