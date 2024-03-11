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

struct Box: Decodable {
    let x1: Double
    let y1: Double
    let x2: Double
    let y2: Double
}

@Observable class WasteItemModel: Identifiable{
    let id : String = UUID().uuidString
    var wasteType : String = ""
    let category : WasteCategory
    var icon : String = ""
    let confidence: Double = 0.0
//    let box: Box? = nil
    
    
    init(wasteType : String, category: WasteCategory, icon: String) {
        self.wasteType = wasteType
        self.category = category
        self.icon = icon
    }
}
