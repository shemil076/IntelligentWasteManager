//
//  WasteItemModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import Foundation
import Observation




@Observable class WasteItemModel: Identifiable{
    let id : String = UUID().uuidString
    var wasteType : String = ""
    let category : WasteCategory
    var icon : String = ""
    var instructoins : [String] = [""]
    
    init(wasteType : String, category: WasteCategory, icon: String) {
        self.wasteType = wasteType
        self.category = category
        self.icon = icon
    }
}
