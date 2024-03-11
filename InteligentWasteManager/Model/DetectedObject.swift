//
//  DetectedObject.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-10.
//

import Foundation

struct DetectedObject: Decodable, Identifiable {
    var id : String = UUID().uuidString // Add if you want a unique identifier
    let name: String
    let `class`: Int  // Assuming 'class' is an integer
    let confidence: Double
    let box: Box

    struct Box: Decodable {
        let x1: Double
        let y1: Double
        let x2: Double
        let y2: Double
    }
    
    private enum CodingKeys: String, CodingKey {
            case name, `class`, confidence, box
        }
}
