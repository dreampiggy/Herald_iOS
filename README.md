# Herald_iOS
> 先声iOS客户端

[![travis](https://img.shields.io/travis/HeraldStudio/Herald_iOS.svg)](https://travis-ci.org/HeraldStudio/Herald_iOS)
[![License](https://img.shields.io/dub/l/vibe-d.svg)](https://opensource.org/licenses/MIT)
[![Star](https://img.shields.io/github/stars/HeraldStudio/Herald_iOS.svg?style=social&label=Star)](https://github.com/HeraldStudio/Herald_iOS)

##### 注：
1. 由于服务器被水表，所以新的API不再用域名，而直接用URL：`115.28.27.150`
2. 推送功能暂时放在另一台服务器上，使用[PyAPNs](https://github.com/djacobs/PyAPNs)
3. 用Swift 2.1语法重写了，在Xcode7.1.1下编译，如果需要历史版本，查看`swift1.2`branch

# 编译环境
	OS X 10.11.1
	Xcode 7.1.1

# 支持平台
	iOS 7.1 以上
	
# 测试机型
	iPhone 4S
	iPhone 5
	iPhone 5S
	iPhone 6
	iPhone 6 Plus
	iPhone 6S
	iPhone 6S Plus
	只支持竖屏模式

# 语言
	Swift (2.1以上) 和 Objective-C
	所有业务，核心代码使用Swift
	在第三方库的使用或者第三方库的自定义上，使用Objective-C

# 项目目录简介

1. **Libraries/** 第三方库
2. **Herald/** 主目录
	1. **LoginControllers/** 信息门户登录和个人资料补全
	
	2. **SchoolLifeControllers/** 校园功能：
		+ **RunningViewController** 跑操查询  
		+ **EmptyRoomViewController** 空闲教室  
		+ **CurriculumViewController** 课表查询  
		+ **AcademicViewController** 教务查询  
		+ **NicViewController** 校园网查询  
		+ **SeuCardViewController** 一卡通查询  
		+ **SeuCardTableViewController** 一卡通详情查询  
	3. **StudyLectureControllers** 学习讲座功能：
		+ **GradeViewController** GPA查询  
		+ **SRTPViewController** SRTP查询  
		+ **ExamViewController** 考试查询
		+ **LabTableViewController** 物理实验查询  
		+ **LectureViewController** 人文讲座查询  
		+ **LecturePredictTableViewController** 人文讲座预告
		+ **LecturePredictDetailViewController** 人文讲座详情
	3. **LibraryControllers/** 图书馆功能：  
		+ **LibNavViewController** 图书馆地图  
		+ **SearchBookViewController** 图书搜索  
		+ **BorrowedBooksViewController** 已借图书查询  
		+ **BorrowedBooksViewController** 图书续借  
		+ **SchoolBusViewController** 校车时刻  
	
	4. **TakeOutControllers/** 外卖模块  
	
	5. 其他视图控制器：  
		+ **CenterViewController.swift** 首页模块  
		+ **LeftDrawerTableViewController** 左侧抽屉列表导航模块  
		+ **CommonNavViewController** 左侧抽屉视图控制器  
		+ **SimsimiViewController.swift** SimSimi模块  
		+ **SettingsViewController.swift** 设置页面 
	 
	6. 其他工具类或者代理类：  
		1. **AppDelegate.swift** 应用入口代理 
		2. **Tool.swift** 加载动画效果的封装，以及一个便携初始化普通VC的方法initNavigationAPI()    
		3. **Config.swift** 包括了所有需要存储在用户本地UserDefault的控制类    
		4. **API.swift**    核心API封装类，对于普通的VC，首先要声明实现APIGetter接口，然后定义一个HeraldAPI全局对象，并且设置代理为自己，即可以使用相应的API，包括：    
	***sendAPI()***   //通过API标签tag和参数列表String...来调用响应API请求    
	***getResult()***   //获得结果    
	***getError()***    //错误处理

3. **Pictures/** 图片资源
4. **Supporting Files/** 存放属性表    
	1. **API List.plist** 核心API列表的数据，用XML存储，确保URL是正确，参数列表里面，uuid或者appid一定放在最后一个，并且所有参数顺序和代码中传入参数顺序一致即可。加入新的API请在这里改动，并在对应的VC中加入调用参数和方法，API.swift不需要做任何改动！    
	2. **Info.plist** 项目配置文件

# 截图
![](http://pic4.zhimg.com/61a75b73bb600844c66f7aac893c6e37_b.jpg)

# 目标
1. UI更新，重新设计 50%
2. 重构代码，使整体架构可扩展，容错性高，支持热更新 95%

# 更新日志


> 3.4.0

1、由于服务器的原因以及各种因素，现在重新修复所有接口  
2、加入了跑操预测推送的功能，内容同小猴，不过使用推送，无需打开应用即可接收，每天早上6:45发送，大家酌情考虑使用。若无法接收，可以在先声->设置->跑操推送开启  
3、加入了考试查询功能  
4、重新布局了一下各个功能的位置  
5、加入了API更新功能，防止服务器再次更换导致的问题，通过先声->设置->更新API使用  
6、修复了iOS9上可能存在的无法发送网络请求的问题  
7、修复了部分潜在Bug和错别字  

> 3.2.0

1、加入了iPhone 6S 和 iPhone 6S Plus的3D Touch支持

> 3.0.0

1、配合先声服务端接口进行改动，所有现有功能可用  
2、加入了校园网流量查询，一卡通余额查询，一卡通详单查询  
3、加入了物理实验查询，人文讲座查询，人文讲座预测  
4、加入了校车时刻查询  
5、修复了部分UI在iPhone6 / iPhone 6 Plus上的显示问题  
6、网络请求会在离开相应功能页面后关闭，减少流量消耗  
7、课表和GPA模块会自动进行缓存而无需联网，GPA查询第一次可能会多次超时，可耐心多尝试几次