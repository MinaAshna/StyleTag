//
//  OutfitDetailsView.swift
//  StyleTag
//
//  Created by Mina Ashna on 19/07/2023.
//

import SwiftUI

struct OutfitDetailsView: View {
    var outfitModel: OutfitModel
    
    var body: some View {
        outfitModel.image
            .resizable()
            .scaledToFit()
    }
}

struct OutfitDetailsView_Previews: PreviewProvider {
    static var ViewModel = OutfitModel(image: .init(systemName: "profile"),
                                       createdData: .now)
    static var previews: some View {
        OutfitDetailsView(outfitModel: OutfitDetailsView_Previews.ViewModel)
    }
}
