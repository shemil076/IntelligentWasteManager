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
                    Text("Aluminium").foregroundColor(.white).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    ScrollView{
                        VStack{
                            Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam recusandae alias error harum maxime adipisci amet laborum. Perspiciatis minima nesciunt dolorem! Off iciis iure rerum voluptates a cumque velit quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur fugiat, temporibus enim commodi iusto libero magni deleniti quod quam consequuntur! Commodi minima excepturi repudiandae velit hic maxime doloremque.").foregroundStyle(.white)
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
        }
    }
}

#Preview {
    InstructionView(wasteItem: WasteItemModel(wasteType: "Aluminium", category: WasteCategory.recylable, icon: "recylable"))
}



