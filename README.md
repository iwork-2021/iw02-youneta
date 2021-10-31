# iw02-youneta
iw02-youneta created by GitHub Classroom
# 实验要求：
1. 实现待办事项添加并保存，并以表格（UITableView）实现代办事项列表展示；
2. 实现待办事项更新；（https://developer.apple.com/documentation/uikit/uitableviewdelegate/handling_row_selection_in_a_table_view）
3. 支持以表格中单元格右划的方式完成某个代办事项删除；（https://programmingwithswift.com/uitableviewcell-swipe-actions-with-swift/）
4. 对界面进行个性化/美化设计。
# 运行录屏：
https://www.bilibili.com/video/BV1Q3411r797
# 实现细节
这次的实验同样遵从MVC设计模式，三个界面（主界面、编辑、添加）对应2个viewController（这里把编辑界面和添加界面设计为用同一种vc），view层实现各个界面的UI，每一个待办事项对应一个model，主VC中一个model的array来作为tableview的数据源。

##回调通信
在这次作用中涉及两个页面之间的事件链以及数据通信，这里采用了闭包回调的方式来实现。在OC中叫block，在swift中改称闭包，实际上类似匿名函数。
例如在编辑、添加TODO的页面的VC中定义一个闭包变量`completeBlk`，传递的参数是`model`:
``` swift
  typealias completionBlk = (TodoItemModel) -> ()
  var completeBlk: completionBlk? = nil
```
在完成按钮的响应事件中主动调用这个闭包（当然注意闭包判空）：
``` swift
  @objc func _handleCompleteAdd(sender: UIBarButtonItem) {
      ...
      //注意闭包判空
      if(self.completeBlk == nil) {
      }
      else {
          self.completeBlk!(self.model)
      }
      self.navigationController?.popViewController(animated: true)
  }
```
在主界面的对应按钮响应事件（右上角添加、每个事项的编辑按钮）中创建一个新的对应的VC，并给`completeBlk`赋值：
``` swift 
  weak var weakSelf = self
  addNewVC.completeBlk = {(model:TodoItemModel) -> () in
      if model.itemName != ""{
          weakSelf?._handleCompleteAddTodoItem(model: model)
      }
  }
```
如此一来，添加/编辑TODO界面的完成按钮的响应事件就可以关联到主界面，并把添加/编辑过的新的TODO对应的`model`传递给主界面，紧接着主界面可以根据这个`model`插入/修改原来的`cellModelArray`中的对应内容并更新`tableView`。
除了这种闭包回调方法实现的通信之外，其实还可以采用`delegate`方法，在主界面的添加/编辑按钮的响应事件中新建VC的时候，将该VC的`delegate`设置为`self`（即主界面），同时在`addNewTodoViewController`类中定义一个代理方法`didComplete`，在`complete`按钮的响应事件中调用该代理方法，主界面类中则需要实现这个代理方法。其实这样通过代理来实现通信的方法和通过闭包来实现大同小异。
除了这里的应用之外，这次作业我在每个cell的编辑按钮点击响应等地方都有用到闭包回调。


##持久化
1. 持久化的部分用了UserDefaults，其实就是一个json，一开始虽然想用app的沙盒目录读写文件，想了想也没那么多东西就直接用UserDefaults了。实质上就是读写键值对。
2. 多线程部分用了GCD来做，实际上也只用在了I/O操作（即读写UserDefaults持久化）的一些部分，其他的应用场景我想到的是用在网络请求（虽然这个作业没有网络请求部分）这些耗时较长的地方开一个异步线程执行，不要在主线程串行执行
``` swift 
// write
  DispatchQueue.global().async {
    let defaults = UserDefaults.standard
    let modelPropertyArray = NSArray.init(array: [model.itemName ?? "", model.date ?? Date.now, model.check ?? false, model.itemDescription ?? ""])
    defaults.set(modelPropertyArray, forKey: String(indexPath?.row ?? 0))
    defaults.synchronize()
  }
// read
  private lazy var cellModelArray : NSMutableArray = {
      var arr = NSMutableArray.init()
      let defaults = UserDefaults.standard
      let num : Int = defaults.integer(forKey: rootTableViewController.rowsNumberKey)
      for i in 0..<num {
          let modelParams = defaults.array(forKey: String(i))
          if modelParams != nil {
              var model = TodoItemModel.init(name: modelParams![0] as! String, date: modelParams![1] as! Date, check: modelParams![2] as! Bool, description: modelParams![3] as! String)
              arr.addObjects(from: [model])
          }
      }
      return arr
  }()

```



# 反思总结
1. 先说说目前存在的问题，因为icon是用的外部图片，在cell重用的时候会根据image的大小来重设cell的大小，所以导致下滑再上滑的时候或者偶尔旋转的时候cell的布局会混乱，解决办法也很简单，在初始化的时候设置好imageview的size就可以了。
2. 这次作业下来最大的感受就是觉得自己的架构思想和架构能力还是欠缺，有些地方连自己都觉得这是在硬编码了，在设计的时候对于数据和UI之间的交流绑定的设想太过简单了，例如用数组给tableview的cell初始化的时候的弱智判断等等，对于设计模式和设计思想这块的学习任重道远。虽然做是做出来了，但是觉得做的不够优雅。
