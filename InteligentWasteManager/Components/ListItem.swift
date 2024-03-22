//
//  ListItem.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import SwiftUI

struct ListItem: View {
    var wasteItemModel : WasteItemModel
    var body: some View {
        HStack{
            VStack{
                Image(wasteItemModel.icon).resizable().scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 12 , height: UIScreen.main.bounds.height / 25)
                    .padding(5)

                    .background(
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                    )
            }
            Text(wasteItemModel.wasteType.capitalized)
                .font(.headline)
                .foregroundColor(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
        } .padding(10)
    }
}

#Preview {
    ListItem(wasteItemModel: WasteItemModel(wasteType: "Aluminium", category: WasteCategory.recylable, icon: "recycle"))
}
