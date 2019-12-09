//
//  MemoryTableviewCell.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/07.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation
import UIKit

class MemoryTableViewCell : UITableViewCell {
//    @IBOutlet weak var descriptionLabel:UILabel!
//    @IBOutlet weak var descLabel:UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
