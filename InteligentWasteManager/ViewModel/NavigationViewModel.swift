//
//  NavigationViewModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-11.
//

import Foundation
import SwiftUI
import Combine

class NavigationViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var navigate: Bool = false
    @Published var shouldRestartTimer: Bool = false
}
