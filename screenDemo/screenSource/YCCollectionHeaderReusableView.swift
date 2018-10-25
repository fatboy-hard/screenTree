//
//  YCCollectionHeaderReusableView.swift
//  screenDemo
//
//  Created by 王志强 on 2018/10/23.
//  Copyright © 2018 王志强. All rights reserved.
//

import UIKit
@objc protocol YCCollectionHeaderReusableViewDelegate:NSObjectProtocol {
    @objc func collectionHeaderReusableView(_ collectionHeaderReusableView:YCCollectionHeaderReusableView, selectedItemAt indexPath:IndexPath)
    @objc func collectionHeaderReusableViewDisMiss(_ collectionHeaderReusableView:YCCollectionHeaderReusableView)
}
class YCCollectionHeaderReusableView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    private let resueIdentifier = "YLHeaderCollectionViewCell"
    var dataSources:[String] = []
    weak var delegate:YCCollectionHeaderReusableViewDelegate?
    var titleString:String = ""
    var count:Int = 0 {
        didSet{
             showCollectionView.reloadData()
                 showCollectionView.scrollToItem(at: IndexPath.init(row: count, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
    var currentTag:Int = 0{
        didSet{
            if dataSources.count>currentTag {
                for _ in currentTag..<dataSources.count-1{
                    dataSources.remove(at: currentTag)
                }
    
                dataSources[currentTag-1] = titleString
            }else{
                dataSources.insert(titleString, at: dataSources.count-1)
            }
            count = dataSources.count-1
            showCollectionView.reloadData()
            showCollectionView.scrollToItem(at: IndexPath.init(row: currentTag, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataSources.append("请选择")
        addSubview(titleLabel)
        addSubview(dissMissBtn)
        addSubview(showCollectionView)
        addSubview(lineView)
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func disMissClick() {
        self.delegate?.collectionHeaderReusableViewDisMiss(self)
    }
    //MARK-UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resueIdentifier, for: indexPath) as! YLHeaderCollectionViewCell
        cell.titleString = dataSources[indexPath.row]
        if indexPath.row ==  count {
            cell.bottomView.isHidden = false
            cell.titleLabel.textColor = UIColor.red
        }else{
            cell.bottomView.isHidden = true
            cell.titleLabel.textColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        }
        return cell
    }
  // MARK - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionHeaderReusableView(self, selectedItemAt: indexPath)
        count = indexPath.row
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let value = dataSources[indexPath.row]
 
            return CGSize.init(width:value.ga_widthForComment(fontSize: 14), height: 30)
    }

    //MARK -- Lazy
    lazy var showCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView.init(frame:CGRect.init(x: 10, y: dissMissBtn.frame.maxY, width: UIScreen.main.bounds.size.width-20, height: 30), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: resueIdentifier, bundle: nil), forCellWithReuseIdentifier: resueIdentifier);
        collectionView.showsHorizontalScrollIndicator=false
        return collectionView
        
    }()
    lazy var lineView:UIView = {
       let  view = UIView.init(frame: CGRect.init(x: 0, y:69 , width: UIScreen.main.bounds.size.width, height: 1))
        view.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        return view
        
    }()
    lazy var titleLabel:UILabel = {
       let  label = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: yc_screenWidth/2, height:20))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.text = "项目为"
        return label
    }()
    
    lazy var dissMissBtn:UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.frame = CGRect.init(x: yc_screenWidth-35, y: 5, width: 30, height: 30)
        btn.backgroundColor = UIColor.clear
        btn.setTitle("X", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(disMissClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
}
extension String {
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 20) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}

