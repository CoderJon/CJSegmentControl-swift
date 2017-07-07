# CJSegmentControl-swift
As the content of each application expands, segment control switching is necessary.
blog:<http://blog.csdn.net/H_Qiao/article/details/74698071>
## function
* SegmentControl
* When switching color gradient
* A fixed number of titles
* Multiple titles
* Slide switch the title
* Select the title in the middle
* Support slider
## rendering
![s1](https://github.com/CoderJon/CJSegmentControl-swift/blob/master/CJSegmentControl/segment.gif)　　![s2](https://github.com/CoderJon/CJSegmentControl-swift/blob/master/CJSegmentControl/segment2.gif)
### Usage
##### A fixed number of titles
```
let titles = ["推荐", "手游", "娱乐", "美女", "颜值"]
let style = CJTitleStyle()
style.isShowScrollLine = true
        
var childVcs = [UIViewController]()
  for _ in 0..<titles.count {
       let vc = UIViewController()
       childVcs.append(vc)
    }
        
let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
let pageView = CJPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style: style)
view.addSubview(pageView)
```
##### Multiple titles
```
let titles = ["最新", "内涵段子", "轻松一刻", "电视台", "邮箱", "数码", "房产", "教育"]
let style = CJTitleStyle()
style.isScrollEnable = true
style.isShowScrollLine = true
        
var childVcs = [UIViewController]()
    for _ in 0..<titles.count {
        let vc = UIViewController()
        childVcs.append(vc)
    }
        
let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)

let pageView = CJPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style: style)
view.addSubview(pageView)
```
