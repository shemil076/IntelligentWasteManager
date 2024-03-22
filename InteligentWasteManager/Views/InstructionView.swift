//
//  InstructionView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-28.
//

import SwiftUI

struct InstructionView: View {
    var wasteItem : WasteItemModel
    var body: some View {
        NavigationStack{
            VStack{
                Image("recycleMain")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }.padding([.top], -60)
                .overlay(
                    VStack{
                        Text(wasteItem.wasteType.capitalized).foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                        ScrollView{
                            VStack(alignment: .leading){
                                ForEach(wasteItem.instructoins,id: \.self ){item in
                                    HStack{
                                        Label(item, systemImage: "leaf.circle").foregroundColor(.black)
                                    }
                                }
                                Spacer()
                                
                            }.padding()
                            Spacer()
                            //                            .ignoresSafeArea()
                        }
                    }.offset(y:100)
                        .background(
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width / 1 , height: UIScreen.main.bounds.height / 1.5)
                                .mask(RoundedRectangle(cornerSize: CGSize(width: 50, height: 50)))
                        )
                        .offset(y:200)
                )
                .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                .navigationTitle(wasteItem.category.rawValue)
                .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
        }.onAppear{
            wasteItem.instructoins = HelperFunctions().fetchInstructions(forWasteType: wasteItem.wasteType) ?? [""]
        }
    }
}

#Preview {
    
    InstructionView(wasteItem: WasteItemModel(wasteType: "Aluminium", category: WasteCategory.recylable, icon: "recylable"))
}



