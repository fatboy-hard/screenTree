//
//  YCScreenTableViewCell.swift
//  screenDemo
//
//  Created by 王志强 on 2018/10/24.
//  Copyright © 2018 王志强. All rights reserved.
//

import UIKit

class YCScreenTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var titleString:String = ""{
        didSet{
            titleLabel.text = titleString
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        if selected {
           self.accessoryType = UITableViewCell.AccessoryType.checkmark
           titleLabel.textColor = UIColor.red
        }else{
            self.accessoryType = UITableViewCell.AccessoryType.none
            titleLabel.textColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        }
    
    }
   
    
}
