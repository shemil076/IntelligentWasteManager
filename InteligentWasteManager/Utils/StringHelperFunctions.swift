//
//  StringHelperFunctions.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import Foundation


class StringHelperFunctions {
    static func getStringBeforeFirstDash(input: String) -> String? {
        let components = input.components(separatedBy: "-")
        return components.first
    }
    
    static func getStringAfterFirstDash(input: String) -> String? {
        let components = input.components(separatedBy: "-")
        guard components.count > 1 else { return nil }
        let remainingComponents = components[1...].joined(separator: "-")
        return remainingComponents.trimmingCharacters(in: .whitespaces)
    }
    
}

