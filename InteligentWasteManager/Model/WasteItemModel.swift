//
//  WasteItemModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import Foundation
import Observation


enum RawWasteCategory : String, CaseIterable{
    case recylable = "Non_biodegradable-Recyclable"
    case biodegradable = "Biodegradable"
    case nonBiodegradable = "Non_Biodegradable"
}

enum WasteCategory : String, CaseIterable{
    case recylable = "Recylable"
    case biodegradable = "Biodegradable"
    case nonBiodegradable = "Non-Biodegradable"
}

@Observable class WasteItemModel: Identifiable{
    let id : String = UUID().uuidString
    var wasteType : String = ""
    let category : WasteCategory
    var icon : String = ""
    
    
    init(wasteType : String, category: WasteCategory, icon: String) {
        self.wasteType = wasteType
        self.category = category
        self.icon = icon
    }
}
