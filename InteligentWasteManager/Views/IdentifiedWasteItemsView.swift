//
//  IdentifiedWasteItemsView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import SwiftUI

struct IdentifiedWasteItemsView: View {
    
    var classes = ["aluminum - Non_biodegradable-Recyclable", "cardboard - Non_Biodegradable-Recyclable", "egg shell - Biodegradable", "facemask - Non_Biodegradable", "food wrapper - Non_Biodegradable", "fruit peels - Biodegradable", "glass bottle - Non_Biodegradable", "left-over food - Biodegradable", "paper - Biodegradable-Recyclable", "pet bottle - Non_Biodegradable-Recyclable", "plastic bag - Non_Biodegradable", "plastic bottle - Non_Biodegradable", "plastic container - Non_Biodegradable", "plastic sachet - Non_Biodegradable", "plastic straw - Non_Biodegradable", "styrofoam containers - Non_Biodegradable", "treeleaves - Biodegradable", "uht carton - Non_Biodegradable-Recyclable", "vegetable peels - Biodegradable"]
    
    var wasteViewModel : WasteItemViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack {
                    ForEach(classes.indices, id: \.self){ index in
                        ListItem(wasteType: StringHelperFunctions.getStringBeforeFirstDash(input: classes[index].capitalized) ?? "", category: wasteViewModel.getCategoryFromRawData(input: classes[index]) ?? "")
                        
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
    IdentifiedWasteItemsView( wasteViewModel: WasteItemViewModel())
}
