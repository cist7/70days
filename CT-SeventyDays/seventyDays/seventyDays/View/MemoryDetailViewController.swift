//
//  MemoryDetailViewController.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/07.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation
import AWSAppSync
import UIKit

class MemoryDetailViewController : BaseMemoryViewController {
    
    @IBOutlet weak var mainTableView:UITableView!
 
    var memoryDetailArray : Array = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appSyncClient = appDelegate.appSyncClient
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        // Register table cell class from nib
        let cellNib = UINib(nibName: "MemoryTableViewCell", bundle: nil)
        self.mainTableView.register(cellNib, forCellReuseIdentifier: "MemoryTableViewCell")
        
        
//        self.mainTableView.register(UINib(nibName: "MemoryTableViewCell", bundle: nil), forCellReuseIdentifier: "MemoryTableViewCell")
        
        self.initMemoryDetailArray()
    }
    
    func initMemoryDetailArray(){
        
        
//        let number = Int.random(in: 1 ..< 5)
        let number = Int.random(in: 1 ..< 30)
        
//        var i = 0
        for _ in 1...number {
            memoryDetailArray.append(getRandomString())
        }
        
    }
    
    @IBAction func editingMode(buttonSelected:UIButton) {
        buttonSelected.isSelected = !buttonSelected.isSelected
        self.mainTableView.isEditing = buttonSelected.isSelected
        self.mainTableView.reloadData()
//        self.mainTableView.row
    }
    
    func getRandomString() -> String{
        
        let number = Int.random(in: 0 ..< 6)

        var randomString = "\n 오늘의 계획\n\n latter suffers from a condition called “modulo bias”. This causes particular numbers to appear more often than others, undermining the “randomness” of the function. Keep in mind that the random numbers from these functions are semi-random and theyre generated with a mathematical function. Although they appear random, if you repeat the random function often enough you’ll see patterns and repetitions. This "
        switch number {
        case 1:
            randomString = "나의 메모리들 \n 오늘의 계획"
            break
        case 2:
            randomString = "오늘의 작업들/기록할것들"
        break
        case 3:
            randomString = "The above example generates a random integer number between 0 and 10. The half-open range operator ..< is used, and the result is a range that runs from 0 to 10, not including 10."
        break
        case 4:
            randomString = "It’s recommended to use the arc4random_uniform(_:) instead of arc4random(), because the latter suffers from a condition called “modulo bias”. This causes particular numbers to appear more often than others, undermining the “randomness” of the function. Keep in mind that the random numbers from these functions are semi-random and theyre generated with a mathematical function. Although they appear random, if you repeat the random function often enough you’ll see patterns and repetitions. This is fine for games or shuffling an array, but you shouldn’t use these random functions for cryptography or security purposes."
            
        break
        case 5:
        randomString = "Fun fact: early computers, and especially computer games, included a file with random numbers. The program would sequentially pick random numbers from this file whenever it needed a random number, instead of calculating a random number on its These days the mechanism isn’t much different, although iOS or Android has a large reserve of randomly generated numbers. Calculating a large set of random numbers before using it is known as seeding."
        break
            case 6:
            randomString = "Fun fact: early computers, and especially computer games, included a file with random numbers. The program would sequentially pick random numbers from this file whenever it needed a random number, instead of calculating a random number on its These days the mechanism isn’t much different, although iOS or Android has a large reserve of randomly generated numbers. Calculating a large set of random numbers before using it is known as seeding."
            break

        default:
            randomString = "Fun fact: early computers, and especially computer games, included a file with random numbers. The program would sequentially pick random numbers from this file whenever it needed a random number, instead of calculating a random number on its These days the mechanism isn’t much different, although iOS or Android has a large reserve of randomly generated numbers. Calculating a large set of random numbers before using it is known as seeding."
            
            break
                
        }
        
        
        
        return randomString
    }
}
//
extension MemoryDetailViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryDetailArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "MemoryTableViewCell"
        var cell: MemoryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MemoryTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "MemoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MemoryTableViewCell
        }
        
        cell.descLabel.text = memoryDetailArray[indexPath.row]
        cell.descTextView.text = memoryDetailArray[indexPath.row]

//
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedObject = self.headlines[sourceIndexPath.row]
//        headlines.remove(at: sourceIndexPath.row)
//        headlines.insert(movedObject, at: destinationIndexPath.row)
    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.isEditing {
            return 40
        }
         
        
//        var cell = tableView.cellForRow(at: indexPath) as? MemoryTableViewCell
//        cell?.textLabel?.text = memoryDetailArray[indexPath.row]
        
        return 80.0
    }
}


class MemorySelectionTableViewCell : UITableViewCell {
    
}
