//
//  AmplifyTutoApp.swift
//  Shared
//
//  Created by SamsungFireMobileiOS on 2022/02/16.
//

import SwiftUI
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin

@main

class AppDelegate: NSObject, UIApplicationDelegate {
    
//    type CTMemory @model @auth(rules: [{allow: public}]) {
//      id: ID!
//      name: String
//    }
    
//    @Published var memoryList: MemoryList = MemoryList()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            
            //S3 filesave
//            try Amplify.add(plugin: AWSCognitoAuthPlugin())       //CognitoAuthPlgin auth 에러 발생하여 주석처리
//            try Amplify.add(plugin: AWSS3StoragePlugin())         //AWSS3StoragePlugin auth 에러 발생하여 주석처리
            
            try Amplify.configure()
            
            listMemories()
//            createMemory()
            print("Amplify configured with API plugin")
//            listMemories()
//            getMemories()
//                switch result {
//                    case .success:
//                        print("Post saved")
//                    case .failure(let dataStoreError):
//                        print("An error occurred saving the post: \(dataStoreError)")
//                }
//            })
            
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
        return true
    }
    
    func listMemories() {
        let todo = AmplifyTuto.keys
        let predicate = todo.name == "my first todo" // && todo.description == "todo description"
        Amplify.API.query(request: .paginatedList(AmplifyTuto.self, where: nil, limit: 1000)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let todos):
                    print("Successfully retrieved list of todos: \(todos)")
                    
                    DispatchQueue.main.async {
//                        self.memoryList.memoryList.removeAll()
//                        for mem in todos {
//                            self.memoryList.memoryList.append(mem)
//                        }
                    }
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
            }
        }
    }
}
struct AmplifyTutoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
