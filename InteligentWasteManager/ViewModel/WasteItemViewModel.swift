//
//  WasteItemViewModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-28.
//

import Foundation
import Observation

class WasteItemViewModel : ObservableObject{
    @Published var wasteItems : [WasteItemModel] = []
    
    
    func addNewWasteItem(wasteType : String, category : WasteCategory, icon : String){
        let newWasteItem = WasteItemModel(wasteType: wasteType, category: category, icon: icon)
        
        if !wasteItems.contains(where: { $0.wasteType == wasteType }) {
            wasteItems.append(newWasteItem)
        }
    }
}


