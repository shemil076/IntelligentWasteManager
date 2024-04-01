//
//  SliderButton.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-24.
//

import SwiftUI

struct SliderButton: View {
    
    @EnvironmentObject var netWorkManager : NetworkManager
    
    let feature: String
    @State private var isActive = false
    
    var body: some View {
        NavigationLink(
            destination: CameraContainerView().ignoresSafeArea(),
            isActive: $isActive
        ) {
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            Text(feature)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                            Spacer()
                            Image(feature)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2.9)
                            Spacer()
                        }
                        
                    }

                }
                .background(
                    Rectangle()
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 52 / 255, green: 87 / 255, blue: 58 / 255), Color(red: 42 / 255, green: 60 / 255, blue: 47 / 255)]), startPoint: .leading, endPoint: .trailing))
//                        .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                        .cornerRadius(30)
                )
            }.padding(.bottom)
            .onTapGesture {
                isActive = true
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SliderButton(feature: "Upload Image")
}
