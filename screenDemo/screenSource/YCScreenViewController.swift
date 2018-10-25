//
//  YCScreenViewController.swift
//  screenDemo
//
//  Created by 王志强 on 2018/10/23.
//  Copyright © 2018 王志强. All rights reserved.
//

import UIKit
var kLabel = "label"
var kChildren = "children"
let yc_screenWidth = UIScreen.main.bounds.size.width
let yc_screenHeight = UIScreen.main.bounds.size.height
class YCScreenViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,YCScreenCollectionViewCellDelegate,YCCollectionHeaderReusableViewDelegate{
   
    
  
    
    
    private let resueIdentifier = "YCScreenCollectionViewCell"
    private let marginTop:CGFloat = 200
    private var cureentRow = 0
    var dataSources:[[Dictionary<String,Any>]] = []
    var selectedRow:[Int] = []
    weak var delegate:YCScreenViewControllerDelegate?
    weak var  dataSourcesL:YCScreenViewControllerDataSources?
    
    private var isScroll = false
    init(treeArys ary:[Dictionary<String,Any>],defalutPropsNameKey:String,defalutPropsChildrenKey:String) {
        super.init(nibName: nil, bundle: nil)
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dataSources.append(ary)
        kLabel = defalutPropsNameKey
        kChildren = defalutPropsChildrenKey
        
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
         modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerView)
        view.addSubview(showCollectionView)

        view.backgroundColor = UIColor.init(white: 0, alpha: 0.4)

        // Do any additional setup after loading the view.
    }
    //MARK - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:YCScreenCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: resueIdentifier,for: indexPath) as! YCScreenCollectionViewCell
        cell.tag=indexPath.row
        cell.currentLabel = headerView.dataSources[indexPath.row]
        cell.delegate = self
        cell.sources = dataSources[indexPath.row]
        return cell
    }
    //MARK - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if isScroll {
            let indx:Int = Int(scrollView.contentOffset.x/UIScreen.main.bounds.size.width)
            headerView.count = indx
        }
        isScroll = false
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            isScroll = true
    }

    //MARK - YCScreenCollectionViewCellDelegate
   
    func screenCollectionView(_ collectionView: YCScreenCollectionViewCell, didSelectDatasAt datas: [Dictionary<String, Any>], indexPathAt row: Int, indexPathAt value: Dictionary<String, Any>) {

        isScroll = false
        if datas.count==0 {
            presentingViewController?.dismiss(animated: true, completion: nil)
            return;
        }
      headerView.titleString = value[kLabel] as! String
      headerView.currentTag = row+1
        if dataSources.count>row+1 {
            if dataSources[row+1].count>0{
                for _ in (row+1)..<dataSources.count{
                     dataSources.remove(at: row+1)
                }
            }
        }
   
        dataSources.append(datas)
        showCollectionView.reloadData()
        showCollectionView.scrollToItem(at: IndexPath.init(row: row+1, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        if self.delegate != nil {
            self.delegate!.screenVC!(self, didSeletedDatas: value)
        }
       
        
    }
    func screenCollectionView(_ collectionView: YCScreenCollectionViewCell, equalindexPathAt row: Int) {
            headerView.count = row+1
          showCollectionView.scrollToItem(at: IndexPath.init(row: row+1, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    //MARK - YCCollectionHeaderReusableViewDelegate
    func collectionHeaderReusableView(_ collectionHeaderReusableView: YCCollectionHeaderReusableView, selectedItemAt indexPath: IndexPath) {
        
        
        showCollectionView.scrollToItem(at: IndexPath.init(row: indexPath.row, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    func collectionHeaderReusableViewDisMiss(_ collectionHeaderReusableView: YCCollectionHeaderReusableView) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    //MARK -- Lazy
    lazy var showCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-marginTop)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: headerView.frame.maxY, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-marginTop), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: resueIdentifier, bundle: nil), forCellWithReuseIdentifier: resueIdentifier);
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator=false
        return collectionView
        
    }()
    lazy var  headerView:YCCollectionHeaderReusableView={
        let view = YCCollectionHeaderReusableView.init(frame: CGRect.init(x: 0, y: marginTop, width: UIScreen.main.bounds.size.width, height: 70))
        view.delegate=self
        return view
    }()

}
@objc  protocol  YCScreenViewControllerDelegate:NSObjectProtocol{
  @objc optional
  func screenVC(_ screenVC:YCScreenViewController,didSeletedDatas dic:Dictionary<String, Any>)
    
    
}
@objc  protocol  YCScreenViewControllerDataSources:NSObjectProtocol{
    //返回树形结构数据 ex:[[["lable":"一级菜单","children":[["lable":"1-1级菜单","children": children]]]]]
    @objc func screenVC(_ screenVC:YCScreenViewController)->[Dictionary<String,Any>]
    //返回单独对象 ex:["lable":"一级菜单","children": children]
    @objc func screenVCGetDefalutProps(_ screenVC:YCScreenViewController)->Dictionary<String,Any>
}
