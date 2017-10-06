添加src/ios/Plugins/到project中
添加src/ios/lib/到project中
确认一下的框架是存在的(Target -> Build Phases -> Link Binary With Libraries)

 CFNetwork.framework
 CoreFoundation.framework
 CoreTelephony.framework
 SystemConfiguration.framework
 CoreGraphics.framework
 Foundation.framework
 ADSupport.framework
调用代码,监听系统事件。使用mPush SDK API来实现基础功能。
必须设置PushManagerDelegate代理才能正常使用!!

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];

        // Required
        [PushManager startPushServicePushDelegate:self tokenDelegate:self];

        return YES;
    }

    -(BOOL)onMessage:(NSString *)title content:(NSString *)content extention:(NSDictionary *)extention{

    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:title forKey:@"title"];
    [userInfo setObject:content forKey:@"content"];
    if (extention) {
            [userInfo setObject:extention forKey:@"extention"];  
    }   
    MPushPlugin *pluginHandler = [self.viewController getCommandInstance:@"MPushPlugin"];  
    [pluginHandler didReceiveRemoteMessage:userInfo];  

    return YES;
}
修改cordova config.xml文件用来包含Plugin/内的插件
    <feature name="MPushPlugin">
        <param name="ios-package" value="MPushPlugin" />
        <param name="onload" value="true" />
    </feature>
复制www/timPlugin.js到工程的www目录下面
在需要使用插件处加入

 <script type="text/javascript" src="timPlugin.js"></script>
