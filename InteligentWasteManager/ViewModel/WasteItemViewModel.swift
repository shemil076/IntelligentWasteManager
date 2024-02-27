//
//  WasteItemViewModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-28.
//

import Foundation
import Observation

@Observable class WasteItemViewModel{
    var wasteItems : [WasteItemModel] = []
    
    
    func addNewWasteItem(wastType : String, category : WasteCategory, icon : String){
        let newWasteItem = WasteItemModel(wasteType: wastType, category: category, icon: icon)
        
        wasteItems.append(newWasteItem)
    }
    
    
    func getCategoryFromRawData(input: String) -> String? {
        var category: String
        let textAfterDash = StringHelperFunctions.getStringAfterFirstDash(input: input)
        
        if textAfterDash == RawWasteCategory.recylable.rawValue{
            category = WasteCategory.recylable.rawValue
        }else if textAfterDash == RawWasteCategory.biodegradable.rawValue{
            category = WasteCategory.biodegradable.rawValue
        }else {
            category = WasteCategory.nonBiodegradable.rawValue
        }
        return category
    }
}
