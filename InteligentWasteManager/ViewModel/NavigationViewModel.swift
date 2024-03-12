//
//  NavigationViewModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-11.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var navigate: Bool = false
}
