//
//  YLHeaderCollectionViewCell.swift
//  screenDemo
//
//  Created by 王志强 on 2018/10/23.
//  Copyright © 2018 王志强. All rights reserved.
//

import UIKit

class YLHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var titleString:String?{
        didSet{
            if titleString == nil{
                return
            }
            titleLabel.text = titleString!
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
