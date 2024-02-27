//
//  StringHelperFunctions.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import Foundation


class StringHelperFunctions {
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
        let textAfterDash = StringHelperFunctions.getStringAfterFirstDash(input: input)
        
        if textAfterDash == RawWasteCategory.recylable.rawValue{
            category = WasteCategory.recylable
        }else if textAfterDash == RawWasteCategory.biodegradable.rawValue{
            category = WasteCategory.biodegradable
        }else {
            category = WasteCategory.nonBiodegradable
        }
        return category
    }
}

