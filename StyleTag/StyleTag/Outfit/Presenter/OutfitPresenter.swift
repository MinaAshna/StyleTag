//
//  OutfitPresenter.swift
//  StyleTag
//
//  Created by Mina Ashna on 14/07/2023.
//

import Foundation
import CoreData

class OutfitPresenter {
    private var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func save(outfit: OutfitModel) {
        let outfitMoc = Outfit(context: moc)
        outfitMoc.name = outfit.name
        outfitMoc.image = outfit.selectedImageData
        try? moc.save()
    }
}
