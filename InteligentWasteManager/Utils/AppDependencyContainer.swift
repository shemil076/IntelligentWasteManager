//
//  AppDependencyContainer.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-11.
//

import Foundation

class AppDependencyContainer {
    static let shared = AppDependencyContainer()

    let wasteItemViewModel = WasteItemViewModel()
    
    let networkManager = NetworkManager()

    private init() {}
}
