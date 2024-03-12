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
    
    
//    =======================================> REMOVE EVERYTHING BELOW UNTIL YOU MEET THE NEXT LINE ==========>
    
    //        var classes = ["aluminum - Non_biodegradable-Recyclable", "cardboard - Non_Biodegradable-Recyclable", "egg shell - Biodegradable", "facemask - Non_Biodegradable", "food wrapper - Non_Biodegradable", "fruit peels - Biodegradable", "glass bottle - Non_Biodegradable", "left-over food - Biodegradable", "paper - Biodegradable-Recyclable", "pet bottle - Non_Biodegradable-Recyclable", "plastic bag - Non_Biodegradable", "plastic bottle - Non_Biodegradable", "plastic container - Non_Biodegradable", "plastic sachet - Non_Biodegradable", "plastic straw - Non_Biodegradable", "styrofoam containers - Non_Biodegradable", "treeleaves - Biodegradable", "uht carton - Non_Biodegradable-Recyclable", "vegetable peels - Biodegradable"]
    
    
//    THIS IS TEMP FUNCTION
//    PLEASE REMOVE THIS FUCNTION AFTER INTEGRATING THE
    
    init(){
//        getInitialWasteItems()
    }
    
    let rawAluminium = "aluminum - Non_biodegradable-Recyclable"
    let rawCardboard = "cardboard - Non_Biodegradable-Recyclable"
    let rawEggShell =  "egg shell - Biodegradable"
    let rawTreeleaves = "treeleaves - Biodegradable"
    let rawFacemask = "facemask - Non_Biodegradable"
    let rawPlasticBag = "plastic bag - Non_Biodegradable"
    
    
    
    func getInitialWasteItems(){
        let aluminium = WasteItemModel(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: rawAluminium.capitalized), category: StringHelperFunctions.getCategoryFromRawData(input:  rawAluminium), icon: "recycle")
        
        let cardboard = WasteItemModel(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: rawCardboard.capitalized), category: StringHelperFunctions.getCategoryFromRawData(input:  rawCardboard), icon: "recycle")
        
        let eggShell = WasteItemModel(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: rawEggShell.capitalized), category: StringHelperFunctions.getCategoryFromRawData(input:  rawEggShell), icon: "biodegradable")
        
        let treeleaves = WasteItemModel(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: rawTreeleaves.capitalized), category: StringHelperFunctions.getCategoryFromRawData(input:  rawTreeleaves), icon: "biodegradable")
        
        let facemask = WasteItemModel(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: rawFacemask.capitalized), category: StringHelperFunctions.getCategoryFromRawData(input:  rawFacemask), icon: "non-biodegradable")
        
        let plasticBag = WasteItemModel(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: rawPlasticBag.capitalized), category: StringHelperFunctions.getCategoryFromRawData(input:  rawPlasticBag), icon: "non-biodegradable")
        
        wasteItems.append(aluminium)
        wasteItems.append(cardboard)
        wasteItems.append(eggShell)
        wasteItems.append(treeleaves)
        wasteItems.append(facemask)
        wasteItems.append(plasticBag)
    }
    
//==========================================================>
    
    
    func addNewWasteItem(wasteType : String, category : WasteCategory, icon : String){
        let newWasteItem = WasteItemModel(wasteType: wasteType, category: category, icon: icon)
        
        if !wasteItems.contains(where: { $0.wasteType == wasteType }) {
                wasteItems.append(newWasteItem)
            }
    }
    
    
  
    
}


