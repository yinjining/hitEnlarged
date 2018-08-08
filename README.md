# hitEnlarged
扩大控件响应区域

这是一个view的category，主要是为了扩大view的点击或交互区域，并且能不受父视图的约束，想怎么扩大就怎么扩大。

主要解决：

        1、点击区域太小，交互不灵敏问题

        2、子试图太大，超出父视图范围导致无法响应点击事件问题。
        
【注】如要超出父视图点击，要先把试图加到view上才能使用扩展属性，否则不生效
详情请看[https://www.jianshu.com/p/c687b61d5251](https://www.jianshu.com/p/c687b61d5251)

Podfile
To integrate HitEnlarged into your Xcode project using CocoaPods, specify it in your Podfile:

      source 'https://github.com/yinjining/hitEnlarged.git'
      platform :ios, '8.0'

      target 'TargetName' do
      pod 'HitEnlarged', '~> 1.0.0'
      end
      
Then, run the following command:

      $ pod install
        
![show.jpg](https://upload-images.jianshu.io/upload_images/2953881-49c2926fd74e9f91.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
