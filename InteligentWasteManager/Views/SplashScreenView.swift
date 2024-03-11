//
//  SplashScreenView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-23.
//

import SwiftUI

struct SplashScreenView: View {
    // This binding variable will control the navigation to the main content
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text("Sort Smart")
                    .font(.custom("" ,size: 63))
                    .foregroundColor(.white)
                
                Text("Live Green:")
                    .font(.custom("" ,size: 56))
                    .foregroundColor(.green)
                
                
                Text("A Cleaner Tomorrow")
                    .font(.custom("" ,size: 31))
                    .foregroundColor(.green)
                
                Text("Start Today")
                    .font(.custom("" ,size: 50))
                    .foregroundColor(.white)
                
            }).padding([.leading], -50)
            Spacer()
            VStack{
                
                RoundedRectangle(cornerRadius: 100)
                                   .frame(width: 400, height: 150)
                                   .foregroundColor(.green)
                                
                                   .rotationEffect(.degrees(15))
            }.padding(.leading, 200)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0))) 
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // Start a timer to transition to the main content after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView(isActive: .constant(true))
}
