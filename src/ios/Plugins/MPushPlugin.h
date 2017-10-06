#import <Cordova/CDV.h>

@interface MPushPlugin : CDVPlugin {

}

- (void)srartPushService;

- (void)setTags:(CDVInvokedUrlCommand *)command;

- (void)deleteTags:(CDVInvokedUrlCommand *)command;

- (void)setAlias:(CDVInvokedUrlCommand *)command;

- (void)authSms:(CDVInvokedUrlCommand *)command;

- (void)didReceiveVerificationCode:(NSString *)vcode;

- (void)addLocalNotification:(CDVInvokedUrlCommand *)command withDict:(NSMutableDictionary *)options;
- (void)cancelNotification:(CDVInvokedUrlCommand *)command withOptions:(NSMutableDictionary *)options;
- (void)cancelAllNotification:(CDVInvokedUrlCommand *)command whtiOptions:(NSMutableDictionary *)options;


- (void)didReceiveRemoteMessage:(NSDictionary *)userInfo;

@end
