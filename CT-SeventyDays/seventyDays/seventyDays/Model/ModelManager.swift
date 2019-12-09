//
//  ModelManager.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
import AWSAppSync
import AWSCore

protocol ModelManagerProtocol : class {
    
}

let sharedModelManager = ModelManager()

class ModelManager : NSObject, ModelManagerProtocol {

    // MARK: - Properties
    //Reference AppSync client
    var appSyncClient: AWSAppSyncClient?

    // Initialization

//    init(baseURL: URL) {
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
    }
    
    func createMemory(memoryString:String){

        
//        let resultMemory = self.isExistMemory(memoryName: "20191206")
        
//        if(resultMemory){
//            return;
//        }
        
        appSyncClient?.fetch(query: ListCtmemoriesQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
                
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("Query complete.")
            
            if(result?.data?.listCtmemories?.items?.count ?? 0 > 0){
                UIAlertAction (title: "존재하는메모리", style: .cancel, handler:nil)
                print("존재하는메모리.")
            }else{
                        
                let mutationInput = CreateCTMEMORYInput(memoryId: "20191206")
                self.appSyncClient?.perform(mutation: CreateCtmemoryMutation(input: mutationInput)) { (result, error) in
                            
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
                    
        //            return searchResult
                }
        
        
        
    }
    
    func updateMemory(memoryName:String, changedObjects:AnyObject){
        
    }
    
    func deleteMemory(memoryName:String){
        
    }
    
    func isExistMemory(memoryName:String) -> ()-> Bool {
        
        var searchResult : Bool! = false
        
        appSyncClient?.fetch(query: ListCtmemoriesQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
        
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("Query complete.")
            
            if(result?.data?.listCtmemories?.items?.count ?? 0 > 0){
                searchResult = true
            }
            
//            return searchResult
        }
        
//        return appSyncResult
        return {()-> Bool in
            return true
        }
    }
    
    func searchMemory(memoryName:String) -> Array<Any> {
        
//        var searchResult : Bool! = false
//                
//                appSyncClient?.fetch(query: ListCtmemoriesQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
//                
//                    if error != nil {
//                        print(error?.localizedDescription ?? "")
//                        return
//                    }
//                    print("Query complete.")
//                    
//                    if(result?.data?.listCtmemories?.items?.count ?? 0 > 0){
////                        return result?.data?.listCtmemories?.items?
//                    }
//                }
        
        return ["m1","m2","m3","m4","m1"]
    }
    
}
