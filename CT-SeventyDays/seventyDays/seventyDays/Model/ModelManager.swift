//
//  ModelManager.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 20..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import Foundation
//import AWSAppSync
//import AWSCore

protocol ModelManagerProtocol : class {
    
}

let sharedModelManager = ModelManager()

class ModelManager : NSObject, ModelManagerProtocol {

    // MARK: - Properties
    //Reference AppSync client
//    var appSyncClient: AWSAppSyncClient?

    weak var mainViewController:MainViewController?
    // Initialization

//    init(baseURL: URL) {
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appSyncClient = appDelegate.appSyncClient
    }
    func loadAllMemory(){
//        let tableStringFilterInput = TableStringFilterInput()
////        tableStringFilterInput.eq = memoryString
//        var tableStringFilterInputUserID = TableStringFilterInput()
//        tableStringFilterInputUserID.eq = sharedUserManager.userID
//
//        let tableCTMemoryFilterInput =  TableCTMEMORYFilterInput.init(memoryId: nil, memoryName: nil, userId:tableStringFilterInputUserID)
//
//        let listCTMemoriesQuery = ListCtmemoriesQuery.init(filter: tableCTMemoryFilterInput, limit: nil, nextToken: nil)
////        let listCTMemoriesQuery = ListCtmemoriesQuery()
//
//        self.appSyncClient?.fetch(query: listCTMemoriesQuery, cachePolicy: .fetchIgnoringCacheData) {(result, error) in
//
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            print("Query complete.")
//
//            var resultMemoryArray : Array<Dictionary<String,String>> = []
////            resultMemoryArray.append()
//
//            result?.data?.listCtmemories?.items!.forEach {
////                self.resultLabel.text = $0?.memoryId
////                    print(($0?.memoryId)! + " " + ($0?.memoryId)!)
//
//                resultMemoryArray.append([$0?.memoryId as! String:$0?.memoryName as! String])
//            }
//
//
//            self.mainViewController?.loadMemory(resultArray: resultMemoryArray)
//
//        }
////        return []
    }
    
//    public typealias CTCompletionHandler<Operation: GraphQLOperation> = (_ result: GraphQLResult<Operation.Data>?, _ error: Error?) -> Void
//        returnCacheDataAndFetch네트워크를 통해 데이터를 검색하기 전에 먼저 로컬 캐시에서 결과를 가져옵니다. 이것은 빠른 UX 및 오프라인 지원을 제공합니다.
//    func createMemory<Query: GraphQLQuery>(memoryString:String!, completionHandler:CTCompletionHandler<Query>? = nil){

//    func createMemory(memoryString:String!, completionHandler:(_ result:GraphQLResult<Data>,_ error:Error)->Void){

    func createMemory(memoryString:String!, completionHandler:(_ error:Error?)->Void){
        
//        var tableStringFilterInput = TableStringFilterInput()
//        tableStringFilterInput.eq = memoryString
//        var tableStringFilterInputUserID = TableStringFilterInput()
//        tableStringFilterInputUserID.eq = sharedUserManager.userID
//
//        let tableCTMemoryFilterInput =  TableCTMEMORYFilterInput.init(memoryId: TableStringFilterInput(), memoryName: tableStringFilterInput, userId:tableStringFilterInputUserID)
//
//        let listCTMemoriesQuery = ListCtmemoriesQuery.init(filter: tableCTMemoryFilterInput, limit: 20, nextToken: "1")
//
//        appSyncClient?.fetch(query: listCTMemoriesQuery, cachePolicy: .fetchIgnoringCacheData) {(result, error) in
//
//
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            print("Query complete.")
//
////            if(result?.data?.listCtmemories?.items?.count ?? 0 > 0){
////                UIAlertAction (title: "존재하는메모리", style: .cancel, handler:nil)
////                print("존재하는메모리.")
////            }else{
//            let dateFormatter = DateFormatter.init()
//            dateFormatter.dateFormat = "YYYYMMddHHmmss"
//            let dateString = dateFormatter.string(from: Date())
//
//            let memoryID = "M\(dateString)"
//            let memoryName = memoryString!
//            let userID = sharedUserManager.userID!
//            let createDate = dateString
//            let description = "설명문구.."
//
//
//            let mutationInput = CreateCTMEMORYInput(memoryId: memoryID, memoryName: memoryName, userId: userID, createDate: createDate, description: description)
//
//            self.appSyncClient?.perform(mutation: CreateCtmemoryMutation(input: mutationInput)) { (result, error) in
//
//                if let error = error as? AWSAppSyncClientError {
//                    print("Error occurred: \(error.localizedDescription )")
//                }
//                if let resultError = result?.errors {
//                    print("Error saving the item on server: \(resultError)")
//                    return
//                }
//
//
////                completionHandler(error)
//                self.loadAllMemory()
//                print("Mutation complete.")
//
//            }
//
//        }
    }
    
    func updateMemory(memoryName:String, changedObjects:AnyObject){
        
    }
    
    func deleteMemory(memoryName:String){
        
    }
    
    func isExistMemory(memoryName:String) -> ()-> Bool {
        
        var searchResult : Bool! = false
        
//        appSyncClient?.fetch(query: ListCtmemoriesQuery(), cachePolicy: .fetchIgnoringCacheData) {(result, error) in
//
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            print("Query complete.")
//
//            if(result?.data?.listCtmemories?.items?.count ?? 0 > 0){
//                searchResult = true
//            }
//
////            return searchResult
//        }
        
//        return appSyncResult
        return {()-> Bool in
            return true
        }
    }
    
    func searchMemory(memoryName:String) -> Array<Any> {
        
        
//                appSyncClient?.fetch(query: ListCtmemoriesQuery(), cachePolicy: .fetchIgnoringCacheData) {(result, error) in
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
