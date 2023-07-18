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
    
    var body: some View {
        VStack {
            List(outfits) { outfit in
                let decoder = JSONDecoder()
                if let image = outfit.image,
                   let imageState = try? decoder.decode(Data.self, from: image) {
                    let recoveredImage = try? imageState.toImage()
                    recoveredImage?
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
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
