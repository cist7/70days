//
//  awsAmplifyTutoApp.swift
//  Shared
//
//  Created by SamsungFireMobileiOS on 2022/01/19.
//

import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin

//import AWSAppSync

import SwiftUI



class MemoryList: ObservableObject {
    @Published var memoryList: [CTMemory] = []
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
//    type CTMemory @model @auth(rules: [{allow: public}]) {
//      id: ID!
//      name: String
//    }
    
    @Published var memoryList: MemoryList = MemoryList()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            
//            createMemory()
            print("Amplify configured with API plugin")
            listMemories()
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
    
    func saveMemory(name: String) {
        let memory = CTMemory(name: name)
        Amplify.API.mutate(request: .create(memory)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let memory):
                    print("Successfully created the todo: \(memory)")
                    self.listMemories()
                case .failure(let graphQLError):
                    print("Failed to create graphql \(graphQLError)")
                }
            case .failure(let apiError):
                print("Failed to create a todo", apiError)
            }
        }
    }
    
    func createMemory() {
//        let todo = Todo(name: "my first todo", description: "todo description")
        let memory = CTMemory(name: "asfd")
        Amplify.API.mutate(request: .create(memory)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let memory):
                    print("Successfully created the todo: \(memory)")
                case .failure(let graphQLError):
                    print("Failed to create graphql \(graphQLError)")
                }
            case .failure(let apiError):
                print("Failed to create a todo", apiError)
            }
        }
    }
    
    func getMemories() { //(completionHandler: @escaping () -> Void) {
//        Amplify.API.query(request: .get(CTMemory.self, byId: "l7i2mvbdgbfcrb7gc3v6ceqmuu")) { event in
        Amplify.API.query(request: .get(CTMemory.self, byId: "1234")) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let todo):
                    guard let todo = todo else {
                        print("Could not find todo")
                        return
                    }
                    print("Successfully retrieved todo: \(todo)")
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
            }
        }
    }

    // replace  Amplify.API.mutate(request: .create(todo))
    // delete   Amplify.API.mutate(request: .delete(todo))
    func updateMemory() {
        // Retrieve your Memory using Amplify.API.query
        var memory = CTMemory(name: "my first todo")
//        memory.description = "updated description"
        Amplify.API.mutate(request: .update(memory)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let memory):
                    print("Successfully created todo: \(memory)")
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
            }
        }
    }
    
    func listMemories() {
        let todo = CTMemory.keys
        let predicate = todo.name == "my first todo" // && todo.description == "todo description"
        Amplify.API.query(request: .paginatedList(CTMemory.self, where: nil, limit: 1000)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let todos):
                    print("Successfully retrieved list of todos: \(todos)")
                    
                    DispatchQueue.main.async {
                        self.memoryList.memoryList.removeAll()
                        for mem in todos {
                            self.memoryList.memoryList.append(mem)
                        }
                    }
                    
                    
                    
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
            }
        }
    }
    
//    var todos: [Todo] = []
//    var currentPage: List<Todo>?
//
//    func listFirstPage() {
//        let todo = Todo.keys
//        let predicate = todo.name == "my first todo" && todo.description == "todo description"
//        Amplify.API.query(request: .paginatedList(Todo.self, where: predicate, limit: 1000)) { event in
//            switch event {
//            case .success(let result):
//                switch result {
//                case .success(let todos):
//                    print("Successfully retrieved list of todos: \(todos)")
//                    self.currentPage = todos
//                    self.todos.append(contentsOf: todos)
//                case .failure(let error):
//                    print("Got failed result with \(error.errorDescription)")
//                }
//            case .failure(let error):
//                print("Got failed event with error \(error)")
//            }
//        }
//    }
//
//    func listNextPage() {
//        if let current = currentPage, current.hasNextPage() {
//            current.getNextPage { result in
//                switch result {
//                case .success(let todos):
//                    self.todos.append(contentsOf: todos)
//                    self.currentPage = todos
//                case .failure(let coreError):
//                    print("Failed to get next page \(coreError)")
//                }
//            }
//        }
//    }
    
    
    @IBAction func createMemoryUsingAppSync(){
        
//        sharedModelManager.createMemory(memoryString: "메모리스트링");
////        sharedModelManager.createMemory(memoryString: <#T##String#>)
//        let mutationInput = CreateCTMEMORYInput(memoryId: "20191205")
//
//        appSyncClient?.perform(mutation: CreateCtmemoryMutation(input: mutationInput)) { (result, error) in
//
//            if let error = error as? AWSAppSyncClientError {
//                print("Error occurred: \(error.localizedDescription )")
//            }
//            if let resultError = result?.errors {
//                print("Error saving the item on server: \(resultError)")
//                return
//            }
//            print("Mutation complete.")
//
//            self.runMemoryQuery()
//        }
//
//        self.runMemoryQuery()
    }
}

@main
struct awsAmplifyTutoApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(appDelegate: _appDelegate, memoryList: appDelegate.memoryList, memoryName: "sdf")
        }
    }
}
