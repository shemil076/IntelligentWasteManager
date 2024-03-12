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
                            Image(feature)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 1.5)
                            Spacer()
                        }
                        .padding([.top], -60)
                        .padding([.horizontal], -20)
                        
                        Text(feature)
                            .padding(.bottom)
                            .foregroundColor(.white)
                    }
                }
                .background(
                    Rectangle()
                        .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                        .cornerRadius(50)
                )
            }
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
