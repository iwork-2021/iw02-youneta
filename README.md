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

##持久化
1. 持久化的部分用了UserDefaults，其实就是一个json，一开始虽然想用app的沙盒目录读写文件，想了想也没那么多东西就直接用UserDefaults了。实质上就是读写键值对。
2. 多线程部分用了GCD来做，实际上也只用在了I/O操作（即读写UserDefaults持久化）部分，其他的应用场景我想到的是用在网络请求（虽然这个作业没有网络请求部分）这些耗时较长的地方开一个异步线程执行，不要在主线程串行执行
``` swift 
DispatchQueue.global().async {
                let defaults = UserDefaults.standard
                let modelPropertyArray = NSArray.init(array: [model.itemName ?? "", model.date ?? Date.now, model.check ?? false, model.itemDescription ?? ""])
                defaults.set(modelPropertyArray, forKey: String(indexPath?.row ?? 0))
                defaults.synchronize()
            }
```



# 反思总结
1. 先说说目前存在的问题，因为icon是用的外部图片，在cell重用的时候会根据image的大小来重设cell的大小，所以导致下滑再上滑的时候或者偶尔旋转的时候cell的布局会混乱，解决办法也很简单，在初始化的时候设置好imageview的size就可以了。有时间就修了。
2. 这次作业下来最大的感受就是觉得自己的架构思想和架构能力还是欠缺，有些地方连自己都觉得这是在硬编码了，在设计的时候对于数据和UI之间的交流绑定的设想太过简单了，例如用数组给tableview的cell初始化的时候的弱智判断等等，对于设计模式和设计思想这块的学习任重道远。虽然做是做出来了，但是觉得做的不够优雅。
