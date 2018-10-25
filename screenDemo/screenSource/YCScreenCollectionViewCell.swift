//
//  YCScreenCollectionViewCell.swift
//  screenDemo
//
//  Created by 王志强 on 2018/10/23.
//  Copyright © 2018 王志强. All rights reserved.
//

import UIKit
@objc protocol  YCScreenCollectionViewCellDelegate:NSObjectProtocol{
    @objc func screenCollectionView(_ collectionView:YCScreenCollectionViewCell,didSelectDatasAt datas:[Dictionary<String,Any>],indexPathAt row:Int,indexPathAt value:Dictionary<String,Any>)
      @objc func screenCollectionView(_ collectionView:YCScreenCollectionViewCell,equalindexPathAt row:Int)
}
class YCScreenCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var showTableView: UITableView!
    private let indentifier = "YCScreenTableViewCell"
    weak var delegate:YCScreenCollectionViewCellDelegate?
     var  currentLabel = ""
    public var sources:[Dictionary<String,Any>] = []{
        didSet{
           
            showTableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        showTableView.register(UINib.init(nibName: indentifier, bundle: nil), forCellReuseIdentifier: indentifier)
        showTableView.dataSource = self
        showTableView.delegate = self
        showTableView.tableFooterView = UIView.init()
        showTableView.rowHeight = 40
        
        
        // Initialization code
    }
    //MARK-UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return sources.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier) as! YCScreenTableViewCell
        cell.titleString = sources[indexPath.row][kLabel] as? String ?? ""
        if currentLabel == (sources[indexPath.row][kLabel] as? String)!{
            showTableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)

        }

        return cell
    }
    //MARK -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentLabel != (sources[indexPath.row][kLabel] as? String)! {
             self.delegate?.screenCollectionView(self, didSelectDatasAt:sources[indexPath.row][kChildren] as? Array ?? [],indexPathAt: self.tag,indexPathAt:sources[indexPath.row])
        }else if currentLabel == (sources[indexPath.row][kLabel] as? String)!{
            self.delegate?.screenCollectionView(self, equalindexPathAt: self.tag)
        }
//          [showTableView selectRowAtIndexPath:ind animated:false scrollPosition:UITableViewScrollPositionNone];
  
       
    }
}
