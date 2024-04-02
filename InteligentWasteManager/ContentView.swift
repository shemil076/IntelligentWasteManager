//
//  ContentView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var wasteItemViewModel : WasteItemViewModel
    var features = ["Open Camera", "Upload Video", "Upload Image"]
    var mainImages = ["Waste management-bro", "Waste management-cuate", "Waste management-rafiki", "wasteManagementPurple"  ]
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                VStack {
                    Spacer()
                    CurvedShape()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 248 / 255, green: 250 / 255, blue: 237 / 255), Color(red: 238 / 255, green: 242 / 255, blue: 218 / 255)]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                }.ignoresSafeArea()
                
                Image("wasteManagementPurple")
                    .resizable()
                    .scaledToFit()
                    .padding([.top], UIScreen.main.bounds.width)

                VStack{
                    HStack{
                        Text("Waste Manager")
                            .font(.title2)
                            .foregroundColor(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                        
                        Spacer()
                    }
                    .padding([.top], -10)
                    Spacer()

                    
                    ScrollView() {
                        LazyVStack {
//                            ForEach(features.indices, id: \.self){ index in
//                                SliderButton( feature: features[index])
//                                
//                            }
                            
                            ForEach(MainOptions.allCases, id: \.self){ option in
                                SliderButton( option: option)
                                    
                            }
                        }
                    }.padding(.top)
                    
                    
                    
                    Label("2024", systemImage: "c.circle").font(.footnote)
                    
                }
                .padding(.horizontal)
                
                
            }
            .navigationTitle("Intelligent")
            .foregroundColor(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Label("", systemImage: "list.bullet")
                    })
                }
            }
        }
        
    }
}

extension Color {
    static let customBackground = Color(red: 248 / 255, green: 250 / 255, blue: 237 / 255)
}

#Preview {
    ContentView()
}
