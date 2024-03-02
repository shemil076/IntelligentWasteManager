//
//  SliderButton.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-24.
//

import SwiftUI

struct SliderButton: View {
    
    let feature : String
    @State private var isShowingCameraView = false
    let networkManager = NetworkManager()
    var body: some View {
        Button(action: {
            isShowingCameraView = true
        }){
            VStack{
                ZStack{
                    VStack{
                        HStack{
                            Image(feature)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width/1.5)
                            Spacer()
                            
                        }.padding([.top], -60)
                            .padding([.horizontal], -20)
                        
                        Text(feature).padding(.bottom)
                            .foregroundColor(.white)
                    }
                    
                }
                .background(
                    Rectangle()
                        .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
    //                    .opacity(0.4)
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                        .cornerRadius(50))
                
            }
        }.sheet(isPresented: $isShowingCameraView) {
            LiveCameraPreview()
        }
    }
}

#Preview {
    SliderButton(feature: "Upload Image")
}
