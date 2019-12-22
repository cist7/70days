//
//  MainViewController.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/04.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation
import AWSAppSync
import AWSCore

class MainViewController : BaseMemoryViewController, UITextFieldDelegate {
    
    //Reference AppSync client
    var appSyncClient: AWSAppSyncClient?

    @IBOutlet weak var resultLabel:UILabel!
    
    @IBOutlet weak var mainTableView:UITableView!
    
    var memoryArray : Array<Dictionary<String,String>> = [] {
        didSet{
            self.mainTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
        
        sharedModelManager.mainViewController = self
        
//        if let memory = UserDefaults.standard.object(forKey: "MemoryArray") {
//            memoryArray = memory as! [String]
//        }
//        loadMemory { () -> Array<Dictionary<String, String>> in
//
//        }
        
        
        sharedModelManager.loadAllMemory()
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
//        runMutation()
    }
    
    func loadMemory(resultArray:Array<Dictionary<String,String>>){
//        sharedModelManager.loadAllMemory(resultHandler)
        self.memoryArray = resultArray
    }
    
    
    @IBAction func createMemory(){
        
//        sharedModelManager.createMemory(memoryString: "메모리스트링");
//        sharedModelManager.createMemory(memoryString: <#T##String#>)
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
    
    func searchMemory(memoryString:String) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        guard let memoryText = textField.text else{return false}
        
        let saveToServer = true
        //server
        if saveToServer {
//            sharedModelManager.searchMemory(memoryName: textField.text!)
//            GetCtmemoryQuery(MemoryID: nil, MemoryName: memoryText, UserID: sharedUserManager.userID)
            
            var filterMemoryID = TableStringFilterInput.init()
            filterMemoryID.eq = "M129"
            var filterMemoryName = TableStringFilterInput.init()
            filterMemoryName.eq = memoryText
            var filterUserID = TableStringFilterInput.init()
            filterUserID.eq = sharedUserManager.userID
            
            
            appSyncClient?.fetch(query:ListCtmemoriesQuery(filter: TableCTMEMORYFilterInput(memoryId: filterMemoryID, memoryName: filterMemoryName, userId: filterUserID), limit: nil, nextToken: nil) , cachePolicy: .returnCacheDataAndFetch) {(result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("Query complete.")
                    
                result?.data?.listCtmemories?.items!.forEach { self.resultLabel.text = $0?.memoryId
                print(($0?.memoryId)! + ":" + ($0?.memoryName)! + ":" + ($0?.userId)!) }
                
                if(result?.data?.listCtmemories?.items?.count ?? 0 > 1){
                    //기존 메모리
//                    print("\(result?.data?.listCtmemories?.items?.count)")
                    let alertVc = UIAlertController(title: "", message: "존재하는 메모리 입니다", preferredStyle: .alert)
//                    let cancelAction = UIAlertAction(
//                        title: "아니오",
//                        style: .cancel) {
//                            action in
//
//                    }
                    let okAction = UIAlertAction(
                        title: "확인",
                        style: .default) {
                            action in
//                            println("pressed Cancel Button")
                    }
//                    alertVc.addAction(cancelAction)
                    alertVc.addAction(okAction)

                    self.present(alertVc, animated: true, completion: {() in

                        })
                }else{
                
                    sharedModelManager.createMemory(memoryString: memoryText, completionHandler: {(error)->Void in
                        
                    }
                    )
                }
                
//                sharedModelManager.createMemory(memoryString: memoryText, completionHandler: (result<Any>,error) in
//
//                )
//                sharedModelManager.createMemory(memoryString: memoryText, completionHandler: (result:GraphQLResult<Any>,error:Error)->Void in
                
                    
//                )
 
                    
            }
        }else{
            //local
            memoryArray.append([textField.text ?? "empty":"\(textField.text)1"])
            mainTableView.reloadData()
            
            UserDefaults.standard.setValue(memoryArray, forKey: "MemoryArray")
            UserDefaults.standard.synchronize()
        }
        
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        sharedModelManager.searchMemory(memoryName: (textField.text ?? "")+string )
        return true
    }
    
    
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "defaultCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if(cell == nil){
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let rowDic :Dictionary<String,String> = memoryArray[indexPath.row]
        
        cell?.textLabel?.text = rowDic.first?.value
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemoryDetailViewController") as? MemoryDetailViewController {

           if let navigator = navigationController {
               navigator.pushViewController(viewController, animated: true)
           }
        }
    }
}


