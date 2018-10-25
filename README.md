# screenTree
仿京东的地址选择界面
# 效果
![image](https://github.com/wzq21590105/screenTree/edit/master/images/nongshalie.jpg)
# 使用方法
将screenSource 放入自己的工程
```
  //树形结构数据
  let arys = [
                    ["PRJ_SRC_ID":"一级","children":[["PRJ_SRC_ID":"1-1级","children":[]]]],
                    ["PRJ_SRC_ID":"二级","children":[["PRJ_SRC_ID":"2-1级","children":[["PRJ_SRC_ID":"2-2级","children":[]]]]],],
                    ["PRJ_SRC_ID":"三级","children":[["PRJ_SRC_ID":"3-1级","children":[["PRJ_SRC_ID":"小西涧河-矿机区间","children":[["PRJ_SRC_ID":"3-3级","children":[["PRJ_SRC_ID":"3-4级","children":[["PRJ_SRC_ID":"3-5级","children":[["PRJ_SRC_ID":"3-6级","children":[["PRJ_SRC_ID":"3-7级","children":[]]]]]]]]]]]]]]]],
                    ["PRJ_SRC_ID":"四级","children":[["PRJ_SRC_ID":"4-1级","children":[]]]],
                    ["PRJ_SRC_ID":"五级","children":[["PRJ_SRC_ID":"5-1级","children":[]]]]
                    ]
  //treeArys:树形结构数据   defalutPropsNameKey:需要显示的名称的字段名 defalutPropsChildrenKey:需要显示的子数据字段名
 let vc = YCScreenViewController.init(treeArys: arys, defalutPropsNameKey: "PRJ_SRC_ID", defalutPropsChildrenKey: "children");
 vc.delegate=self
 //获取点击选择数据
 func screenVC(_ screenVC: YCScreenViewController, didSeletedDatas dic: Dictionary<String, Any>) {
      print(dic)
    }
    
```
