//
//  ListItem.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-27.
//

import SwiftUI

struct ListItem: View {
    var wasteType: String
    var category: String
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
            HStack{
                VStack{
                    Image(category).resizable().scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 12 , height: UIScreen.main.bounds.height / 25)
                        .padding(5)

                        .background(
                            Rectangle()
                                .foregroundColor(.green)
                                .cornerRadius(10)
                        )
                }.padding([.leading], -90)
                Text(wasteType)
                    .font(.headline)
                    .foregroundColor(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
            }.background(
                Rectangle()
                    .foregroundColor(Color(red: 248 / 255, green: 250 / 255, blue: 237 / 255))
                    .frame(width: UIScreen.main.bounds.width / 1.2 , height: UIScreen.main.bounds.height / 10)
                    .cornerRadius(50)
                    .shadow(radius: 10,y: 10))
        }.padding(20)
        
    }
}

#Preview {
    ListItem(wasteType: "Aluminium", category: "recycle")
}
