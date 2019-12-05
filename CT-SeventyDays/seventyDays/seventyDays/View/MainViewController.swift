//
//  MainViewController.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/04.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation
import AWSAppSync

class MainViewController : ViewController {
    
    //Reference AppSync client
    var appSyncClient: AWSAppSyncClient?

    @IBOutlet weak var resultLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
        
//        runMutation()
    }
    
    @IBAction func createMemory(){
        
        let mutationInput = CreateCTMEMORYInput(memoryId: "20191205")
        
        appSyncClient?.perform(mutation: CreateCtmemoryMutation(input: mutationInput)) { (result, error) in
            
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
            }
            if let resultError = result?.errors {
                print("Error saving the item on server: \(resultError)")
                return
            }
            print("Mutation complete.")
            
            self.runMemoryQuery()
        }
        
//        self.runMemoryQuery()
    }
    
    func runMutation(){
        let mutationInput = CreateTodoInput(name: "Use AppSync", description:"Realtime and Offline")
        appSyncClient?.perform(mutation: CreateTodoMutation(input: mutationInput)) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
            }
            if let resultError = result?.errors {
                print("Error saving the item on server: \(resultError)")
                return
            }
            print("Mutation complete.")
        }
    }
    
    func runMutationAndQuery(){
        let mutationInput = CreateTodoInput(name: "Use AppSync", description:"Realtime and Offline")
        appSyncClient?.perform(mutation: CreateTodoMutation(input: mutationInput)) { [weak self] (result, error) in
            // ... do whatever error checking or processing you wish here
            self?.runQuery()
        }
    }
    
    func runQuery(){
        appSyncClient?.fetch(query: ListTodosQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("Query complete.")
            result?.data?.listTodos?.items!.forEach { print(($0?.name)! + " " + ($0?.description)!) }
        }
    }
    
    func runMemoryQuery(){
        appSyncClient?.fetch(query: ListCtmemoriesQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("Query complete.")
            result?.data?.listCtmemories?.items!.forEach { self.resultLabel.text = $0?.memoryId
                print(($0?.memoryId)! + " " + ($0?.memoryId)!) }
        }
    }

    
    
    var discard: Cancellable?

    func subscribe() {
        do {
            discard = try appSyncClient?.subscribe(subscription: OnCreateTodoSubscription(), resultHandler: { (result, transaction, error) in
                if let result = result {
                    print("CreateTodo subscription data:" + result.data!.onCreateTodo!.name + " " + result.data!.onCreateTodo!.description!)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            })
            print("Subscribed to CreateTodo Mutations.")
            } catch {
                print("Error starting subscription.")
            }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}
