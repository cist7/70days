//
//  ViewController.swift
//  seventyDays
//
//  Created by NAVER on 2017. 3. 17..
//  Copyright © 2017년 CISTREE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func didTouchCurrentView () {
        
//        nameLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        labelLabel.alpha = 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

