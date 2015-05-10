# Herald_iOS
> 先声iOS客户端

# 编译环境
	OS X 10.10.2
	Xcode 6.3.1

# 支持平台
	iOS 7.0 以上
	
# 测试机型
	iPhone 4S
	iPhone 5
	iPhone 5S
	iPhone 6
	iPhone 6 Plus
	暂只支持竖屏模式

# 语言
	Swift (1.2以上) 和 Objective-C
	基础功能全部使用Swift
	在第三方库的使用或者第三方库的自定义上，使用Objective-C

# 项目目录简介

1. Libraries/ 第三方库
2. Herald/ 主目录
	1. loginControllers/ 信息门户登录和个人资料补全
	
	2. schoolLifeControllers/ 校园功能：  	
	跑操查询  
	空闲教室  
	课表查询  
	GPA查询  
	教务查询  
	SRTP查询  
	校园网查询  
	一卡通查询  
	一卡通详情查询  
	物理实验查询  
	人文讲座查询  
	人文讲座预告  
	
	3. LibraryControllers/ 图书馆功能：  
	图书馆地图  
	图书搜索  
	已借图书查询  
	图书续借  
	校车时刻  
	
	4. TakeOutControllers/ 外卖模块  
	
	5. 其他视图控制器：  
	CenterViewController.swift 首页模块  
	LeftDrawerTableViewController 左侧抽屉列表导航模块  
	CommonNavViewController 左侧抽屉视图控制器  
	SimsimiViewController.swift SimSimi模块  
	SettingsViewController.swift 设置页面 
	 
	6. 其他工具类或者代理类：  
	AppDelegate.swift 应用入口代理  
	HttpProtocol.swift 一个对AFNetworking的返回对象进行各种代理方法的接口    
	Tool.swift 加载动画效果的封装，以及一个便携初始化普通VC的方法initNavigationAPI()
	Config.swift 包括了所有需要存储在用户本地UserDefault的控制类    
	API.swift    
	核心API封装类，对于普通的VC，首先要声明实现APIGetter接口，然后定义一个HeraldAPI全局对象，并且设置代理为自己，即可以使用相应的API，包括：    
	sendAPI()   //通过API标签tag和参数列表String...来调用响应API请求    
	getResult()   //获得结果    
	getError()    //错误处理

3. Pictures/ 图片资源
4. Supporting Files/ 存放Info.plist配置文件

# 更新日志

> 3.0.0

1、配合先声服务端接口进行改动，所有现有功能可用  
2、加入了校园网流量查询，一卡通余额查询，一卡通详单查询  
3、加入了物理实验查询，人文讲座查询，人文讲座预测  
4、加入了校车时刻查询  
5、修复了部分UI在iPhone6 / iPhone 6 Plus上的显示问题  
6、网络请求会在离开相应功能页面后关闭，减少流量消耗  
7、课表和GPA模块会自动进行缓存而无需联网，GPA查询第一次可能会多次超时，可耐心多尝试几次