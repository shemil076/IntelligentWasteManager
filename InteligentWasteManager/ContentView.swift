//
//  ContentView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-22.
//

import SwiftUI

struct ContentView: View {
    var features = ["Open Camera", "Upload Video", "Upload Image"]
    var mainImages = ["Waste management-bro", "Waste management-cuate", "Waste management-rafiki", "wasteManagementPurple"  ]
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
        
        
//        VStack {
//            Text(networkManager.dataFromApi.message)
//                        .padding()
//                    Button("Fetch Data") {
//                        networkManager.fetchData(from: "http://192.168.8.120:5000/data")
//                        print(networkManager.dataFromApi.message)
//                        print("fuck")
//                        networkManager.sendSimpleTextMessage()
//                    }
//                }
        
        NavigationStack{
            ZStack{
                Color(red: 248 / 255, green: 250 / 255, blue: 237 / 255)
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Waste Manager")
                            .font(.title2)
                            .foregroundColor(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                        Spacer()
                    }.padding([.top], -10)
                    Spacer()
                    SlideShowView(images: mainImages)
                    Spacer()
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(features.indices, id: \.self){ index in
                                SliderButton(feature: features[index])
                                
                            }
                        }
                    }
                    
                }.padding(.horizontal)
                
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
