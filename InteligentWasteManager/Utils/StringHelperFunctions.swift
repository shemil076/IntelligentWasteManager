//
//  StringHelperFunctions.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import Foundation
import RealmSwift

class sStringHelperFunctions {
    static func getStringBeforeFirstDash(input: String) -> String {
        let components = input.components(separatedBy: "-")
        return components.first ?? ""
    }
    
    static func getStringAfterFirstDash(input: String) -> String {
        let components = input.components(separatedBy: "-")
        guard components.count > 1 else { return "" }
        let remainingComponents = components[1...].joined(separator: "-")
        return remainingComponents.trimmingCharacters(in: .whitespaces)
    }
    
    static func getCategoryFromRawData(input: String) -> WasteCategory {
        var category: WasteCategory
        let textAfterDash = sStringHelperFunctions.getStringAfterFirstDash(input: input)
        
        if textAfterDash == RawWasteCategory.recylable.rawValue{
            category = WasteCategory.recylable
        }else if textAfterDash == RawWasteCategory.biodegradable.rawValue{
            category = WasteCategory.biodegradable
        }else {
            category = WasteCategory.nonBiodegradable
        }
        return category
    }    
    
    
    func loadInstructionsFromJSONFile() {
        let realm = try! Realm()
        let existingInstructionsCount = realm.objects(WasteDisposalInstruction.self).count
        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        print("Default Realm file location: \(defaultRealmPath)")
            
            // If there are already instructions in the database, skip the loading process
            if existingInstructionsCount > 0 {
                print("Instructions already loaded in the database.")
                return
            }
        if let fileURL = Bundle.main.url(forResource: "instructions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let allInstructions = try decoder.decode([WasteDisposalInstruction].self, from: data)
                
                // Assuming you have initialized Realm in your application
                
                
                // Write your objects to the Realm database
                try! realm.write {
                    for instruction in allInstructions {
                        realm.add(instruction)
                    }
                }
                
                print("Successfully added all instructions to Realm database.")
                
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
}

