//
//  NetworkManager.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-29.
//


import Foundation
import Starscream

class NetworkManager: ObservableObject, WebSocketDelegate {

    @Published var dataFromApi = ApiResponse(message: "")
    @Published var isConnected = false
    var socket: WebSocket?
    
    init() {
        connectToWebSocket()
    }
    
    func fetchData(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.dataFromApi = decodedResponse
                    }
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
    func connectToWebSocket() {
        guard let url = URL(string: "ws://192.168.8.120:5000/socket.io/?EIO=4&transport=websocket") else {
            print("WebSocket URL is invalid")
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        
        socket = WebSocket(request: request)
//        socket?.onEvent = { event in
//            print("WebSocket Event:", event)
//            switch event {
//            case .connected(let headers):
//                print("WebSocket connected with headers: \(headers)")
//            case .disconnected(let reason, let code):
//                print("WebSocket disconnected with reason: \(reason) and code: \(code)")
//            case .text(let string):
//                print("Received text: \(string)")
//            case .binary(let data):
//                print("Received data: \(data)")
//            case .ping(_), .pong(_), .viabilityChanged(_), .reconnectSuggested(_), .cancelled, .error(_):
//                break // Handle these events as needed
//            case .peerClosed:
//                print("HI")
//            }
//        }
        
        socket?.onEvent = { [weak self] event in
                   switch event {
                   case .connected(_):
                       self?.isConnected = true
                       print("WebSocket connected")
                   case .disconnected(let reason, _):
                       self?.isConnected = false
                       print("WebSocket disconnected: \(reason)")
                   default:
                       break // Handle other events as needed
                   }
               }
//        socket?.delegate = self
        socket?.connect()
    }
    
    
//    func sendFrame( imageData: Data) {
//        // Assuming `socket` is a `WebSocket` instance and it's connected
//        let dataString = imageData.base64EncodedString() // Convert to base64 if sending as text
//        socket?.write(string: "{\"event\": \"frame\", \"data\": \"\(dataString)\"}") // Adjust based on how you plan to encode and send the data
//    }

    
    func sendFrame(_ imageData: Data) {
            guard isConnected else { return }
            let dataString = imageData.base64EncodedString()
            print("{\"event\": \"frame\", \"data\": \"\(dataString)\"}")
            socket?.write(string: "{\"event\": \"frame\", \"data\": \"\(dataString)\"}")
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
                   case .connected(let headers):
                       isConnected = true
                       print("websocket is connected: \(headers)")
                   case .disconnected(let reason, let code):
                       isConnected = false
                       print("websocket is disconnected: \(reason) with code: \(code)")
                   case .text(let string):
                       print("Received text: \(string)")
                   case .binary(let data):
                       print("Received data: \(data.count)")
                   case .ping(_):
                       break
                   case .pong(_):
                       break
                   case .viabilityChanged(_):
                       break
                   case .reconnectSuggested(_):
                       break
                   case .cancelled:
                       isConnected = false
                   case .error(let error):
                       isConnected = false
                       print(error!)
        case .peerClosed: break
            
        }
    }
}



