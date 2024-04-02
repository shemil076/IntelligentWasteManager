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
    @Published var detectedObjectsList : [DetectedObject] = []
    
    
    
    lazy var wasteViewModel: WasteItemViewModel = AppDependencyContainer.shared.wasteItemViewModel
    
    private let manager: SocketManager
    private var socket: SocketIOClient
    
    
    init() {
        // Configure Socket.IO manager
        let url = URL(string: "ws://192.168.1.2:5000")!
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager.defaultSocket
        setupSocketEvents()
        socket.connect()
        
    }
    
    
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
                        self.wasteViewModel.addNewWasteItem(wasteType: HelperFunctions.getStringBeforeFirstDash(input: name),
                                                            category: HelperFunctions.getCategoryFromRawData(input: name),
                                                            icon: HelperFunctions.getCategoryFromRawData(input: name).rawValue)
                    }
                    
                    self.detectedObjectsList = detectedObjects
                    
                    NotificationCenter.default.post(name: .didReceiveDetectionResults, object: nil, userInfo: ["detectedObjects": detectedObjects])
                
                }                                              
            } catch {
                print("Error decoding detected objects: \(error)")
            }
        }
        
        
    }
    
    func sendFrame(_ imageData: Data) {
        guard isConnected else { return }
        print("ready to send")
        let dataString = imageData.base64EncodedString()
        print("Sent the image,\(dataString)")
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

extension Notification.Name {
    static let didReceiveDetectionResults = Notification.Name("didReceiveDetectionResults")
}
