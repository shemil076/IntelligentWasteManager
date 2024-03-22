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
        
//        print("Waste Type is: \(wasteType)")
        
//        if let instructions = HelperFunctions().fetchInstructions(forWasteType: wasteType) {
//            print("Gonna print the instructoins related to alumiunm")
//            print(instructions)
//        } else {
//            print("No instructions found for the specified wasteType.")
//        }
//        
//        let instructions = [""]
        let newWasteItem = WasteItemModel(wasteType: wasteType, category: category, icon: icon)
        
        if !wasteItems.contains(where: { $0.wasteType == wasteType }) {
            wasteItems.append(newWasteItem)
        }
    }
}


