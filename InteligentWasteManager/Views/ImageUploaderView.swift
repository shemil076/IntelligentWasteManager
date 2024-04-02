//
//  ImageUploaderView.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-04-01.
//

import SwiftUI

struct ImageUploaderView: View {
    
    @State private var image: UIImage?
    @State private var isImagePickerDisplayed = false
    var networkManager : NetworkManager = AppDependencyContainer.shared.networkManager
    @State var shouldNavigate : Bool = false
    
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 248 / 255, green: 250 / 255, blue: 237 / 255)
                    .ignoresSafeArea()
                if let image = image {
                    
                    
                    VStack{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        
                        Button(action: {
                            sendImageToServer()
                            shouldNavigate = true
                        }, label: {
                            Text("Upload")
                                .frame(width: UIScreen.main.bounds.width / 3)
                                .padding()
                                .background(Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1.0)))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            
                        }).padding(.top)
                    }.padding()
                    
                    
                    NavigationLink(destination: IdentifiedWasteItemsView(), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    
                    .padding()
                }else {
                    VStack{
                        
                        
                        Button(action: {
                            isImagePickerDisplayed = true
                        }){
                            Image("upload-png-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 3)
                        }
                    }
                    
                }
                
            }.navigationTitle("Upload an image").navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isImagePickerDisplayed) {
            ImagePicker(image: $image)
        }
    }
    
    private func sendImageToServer() {
        guard let imageData = image?.jpegData(compressionQuality: 0.3) else { return }
        networkManager.sendFrame(imageData)
    }
}

#Preview {
    ImageUploaderView()
}
