//
//  IdentifiedWasteItemsView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import SwiftUI

struct IdentifiedWasteItemsView: View {
    
    
    var wasteItemViewModel : WasteItemViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack {
                    ForEach(wasteItemViewModel.wasteItems){item in
                        ListItem(wasteType: item.wasteType, category: item.category.rawValue)
                    }
                }
            }
                .navigationTitle("Identified Waste Types")
                .navigationBarTitleDisplayMode(.inline)
                .foregroundColor(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Label("", systemImage: "list.bullet")
                        })
                    }
                }
                .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
        }
    }
}

#Preview {
    IdentifiedWasteItemsView(wasteItemViewModel: WasteItemViewModel())
}
