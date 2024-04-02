//
//  Enums.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-04-01.
//

import Foundation


enum MainOptions : String, CaseIterable{
    case scan = "Open Camera"
    case uploadVideo = "Upload Video"
    case uploadImage = "Upload Image"
}

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
