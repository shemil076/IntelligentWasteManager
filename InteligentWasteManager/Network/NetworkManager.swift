//
//  NetworkManager.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-29.
//




import Foundation
import SocketIO

class NetworkManager: ObservableObject {
    @Published var dataFromApi = ApiResponse(message: "")
    @Published var isConnected = false
    @Published var detectedClasses = []
    @Published var detectedObjects : [DetectedObject] = []
    
    
    
    lazy var wasteViewModel: WasteItemViewModel = AppDependencyContainer.shared.wasteItemViewModel
    
    private let manager: SocketManager
    private var socket: SocketIOClient
    
    
    init() {
        // Configure Socket.IO manager
        //        let url = URL(string: "ws://192.168.8.120:5000")!
        let url = URL(string: "ws://192.168.8.120:5000")!
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager.defaultSocket
        setupSocketEvents()
        socket.connect()
        
    }
    
    //    func fetchData(from urlString: String) {
    //        // ... (Your existing code remains the same) ...
    //    }
    
    private func setupSocketEvents() {
        socket.on(clientEvent: .connect) { [weak self] _, _ in
            self?.isConnected = true
            print("WebSocket connected")
        }
        
        socket.on(clientEvent: .disconnect) { [weak self] data, ack in
            self?.isConnected = false
            if let reason = data.first as? String {
                print("WebSocket disconnected: \(reason)")
            }
        }
        
        
        socket.on("detection_result") { data, _ in
            guard let results = data as? [[String: Any]],
                  let detectedObjectsString = results.first?["detected_objects"] as? String,
                  let detectedObjectsData = detectedObjectsString.data(using: .utf8) else {
                return
            }
            
            do {
                let detectedObjects = try JSONDecoder().decode([DetectedObject].self, from: detectedObjectsData)
                
                
                DispatchQueue.main.async {
                    let detectedClasses = detectedObjects.map { ($0.name, $0.class, $0.box, $0.confidence) }
                    self.detectedClasses = detectedClasses
                    
                    detectedClasses.forEach { (name, class, box, confidence) in
                        self.wasteViewModel.addNewWasteItem(wastType: StringHelperFunctions.getStringAfterFirstDash(input: name),
                                                            category: StringHelperFunctions.getCategoryFromRawData(input: name),
                                                            icon: name)
                    }
                }
                
                self.detectedClasses.forEach { item in
                    print("Printing the item", item)
                }
                
                print("The response is ", detectedObjects)
            } catch {
                print("Error decoding detected objects: \(error)")
            }
        }
        
        
    }
    
    func sendFrame(_ imageData: Data) {
        guard isConnected else { return }
        let dataString = imageData.base64EncodedString()
        socket.emit("frame", ["data": dataString]) // Event name and data payload
    }
    
    func sendMessage(_ message: String) {
        guard isConnected else {
            print("WebSocket is not connected.")
            return
        }
        socket.emit("message", message)
    }
}


extension WasteItemViewModel {
    // Add a function to process DetectedObjects and add them to the wasteItems
    func processDetectedObjects(detectedObjects: [DetectedObject]) {
        for object in detectedObjects {
            let wasteType = StringHelperFunctions.getStringBeforeFirstDash(input: object.name)
            let category = StringHelperFunctions.getCategoryFromRawData(input: object.name)
            let icon = "" // Determine the icon based on the category or other logic
            addNewWasteItem(wastType: wasteType, category: category, icon: icon)
        }
    }
}
