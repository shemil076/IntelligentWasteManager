//
//  IdentifiedWasteItemsView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import SwiftUI

struct IdentifiedWasteItemsView: View {
    @EnvironmentObject var wasteItemViewModel : WasteItemViewModel
    @EnvironmentObject var netWorkManager : NetworkManager
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(wasteItemViewModel.wasteItems){item in
                    NavigationLink{
                        
                    }label: {
                        ListItem(wasteItemModel: item)
                    }
                }.listRowSeparator(.hidden)
                .listRowBackground(Capsule().padding(.vertical,5).foregroundColor(Color(red: 248 / 255, green: 250 / 255, blue: 237 / 255)))
                
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
            
        }.background(Color.black)
    }
}

#Preview {
    IdentifiedWasteItemsView()
}
