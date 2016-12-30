# MXHotdog
react-native 自己搭建版本升级的demo ios
运行iOS工程可以看到效果。
初始为1.0.0版本，然后更新后升级到1.0.1版本。


打包方式：
1.在RN工程目录新建一个文件夹，比如叫bundle-ios
2.每次打包用下面的命令：
react-native bundle --platform ios --dev false --entry-file index.ios.js --bundle-output ./bundle-ios/main.jsbundle  --assets-dest ./bundle-ios
会把工程内的资源和JS都打包出来，放入bundle-ios文件夹，分别是assets文件夹和main.jsbundle文件
3.然后将assets和main.jsbundle压缩成zip文件，放到服务器，也就是我工程里需要下载的ZIP包的URL




由于工作较忙，这里只是提供一个实现的简单思路。距离实际完美的框架还太远。
主要流程是这样：
APP打开时，通过接口判断本地版本和远程版本差异，如果需要更新，可将远程的JS和assets文件压缩包下载到本地并解压，然后刷新APP即可完成更新。

几个可优化的点：
1.远程接口里包含版本更新的配置项，比如某版本（1）强制更新JSBundle（2）弹框可选更新（3）需要更新原生APP
   这个版本的管理，需要一个后端服务器和数据库的支持。
   
2.将原生启动更新的函数桥接给RN，这样可以由RN触发更新操作。

3.更新的进度回调：下载bundle的时候，原生可以把进度传递给RN,然后RN来做界面。


欢迎交流，我的博客是：http://www.cnblogs.com/rayshen/

