//
//  ViewController.swift
//  screenDemo
//
//  Created by 王志强 on 2018/10/23.
//  Copyright © 2018 王志强. All rights reserved.
//

import UIKit

class ViewController: UIViewController,YCScreenViewControllerDelegate{

   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }
 
    @IBAction func presentClick(_ sender: UIButton) {
        let arys = [
                    ["PRJ_SRC_ID":"一级","children":[["PRJ_SRC_ID":"1-1级","children":[]]]],
                    ["PRJ_SRC_ID":"二级","children":[["PRJ_SRC_ID":"2-1级","children":[["PRJ_SRC_ID":"2-2级","children":[]]]]],],
                    ["PRJ_SRC_ID":"三级","children":[["PRJ_SRC_ID":"3-1级","children":[["PRJ_SRC_ID":"小西涧河-矿机区间","children":[["PRJ_SRC_ID":"3-3级","children":[["PRJ_SRC_ID":"3-4级","children":[["PRJ_SRC_ID":"3-5级","children":[["PRJ_SRC_ID":"3-6级","children":[["PRJ_SRC_ID":"3-7级","children":[]]]]]]]]]]]]]]]],
                    ["PRJ_SRC_ID":"四级","children":[["PRJ_SRC_ID":"4-1级","children":[]]]],
                    ["PRJ_SRC_ID":"五级","children":[["PRJ_SRC_ID":"5-1级","children":[]]]]
                    ]
        let vc = YCScreenViewController.init(treeArys: arys, defalutPropsNameKey: "PRJ_SRC_ID", defalutPropsChildrenKey: "children");
        vc.delegate=self
        present(vc, animated: true, completion: nil)
    }
    //MARK --YCScreenViewControllerDelegate
    func screenVC(_ screenVC: YCScreenViewController, didSeletedDatas dic: Dictionary<String, Any>) {
//        print(dic)
    }
    
}

