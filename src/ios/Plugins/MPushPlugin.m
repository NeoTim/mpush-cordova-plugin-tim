#import "MPushPlugin.h"
#import "PushManager.h"

@implementation MPushPlugin

- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView {
    if (self = [super initWithWebView:theWebView]) {


    }
    return self;
}
 

- (void)setTags:(CDVInvokedUrlCommand *)command { 

    NSArray *arguments = [command arguments];
    [PushManager setTags:arguments];
}

- (void)deleteTags:(CDVInvokedUrlCommand *)command {

    NSArray *arguments = [command arguments];
    [PushManager setTags:arguments];
}

- (void)setAlias:(CDVInvokedUrlCommand *)command {

    NSArray *arguments = [command arguments];

    NSLog(@"alias = %@", [arguments objectAtIndex:0]);
    [PushManager setAlias:[arguments objectAtIndex:0]];
}

- (void)authSms:(CDVInvokedUrlCommand *)command {

    NSArray *arguments = [command arguments];
    NSString *mobile = [arguments objectAtIndex:0];

    [PushManager authSms:mobile timeInterval:3 finished:^(NSString *code, NSString *errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [self writeJavascript:[NSString stringWithFormat:@"window.plugins.mPushPlugin.receiveVerificationCodeCallback('%@')", code]];

        });
    }];

}

- (void)addLocalNotification:(CDVInvokedUrlCommand *)command withDict:(NSMutableDictionary *)options {
    // notif settings
    double timestamp = [[options objectForKey:@"date"] doubleValue];
    NSString *title = [options objectForKey:@"title"];
    NSString *msg = [options objectForKey:@"message"];
    NSDictionary *actionOptions = [options objectForKey:@"action"];
    LocalPushAction *localPushAction = [[LocalPushAction alloc]init];
    localPushAction.type = [actionOptions objectForKey:@"type"];
    localPushAction.value = [actionOptions objectForKey:@"value"];
    NSDictionary *extention = [options objectForKey:@"extention"];
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSString *notificationId = [PushManager sendLocalPushMsg:title content:msg action:localPushAction extentions:extention fireDate:fireDate];

    dispatch_async(dispatch_get_main_queue(), ^{

        [self writeJavascript:[NSString stringWithFormat:@"window.plugins.mPushPlugin.receiveLocalNotificationCreatedCallback('%@')", notificationId]];

    });
}

- (void)cancelNotification:(CDVInvokedUrlCommand *)command withOptions:(NSMutableDictionary *)options {
    NSString *notificationId = [[command arguments] objectAtIndex:0];
    [PushManager cancelLocalPushForKey:notificationId];
}

- (void)cancelAllNotification:(CDVInvokedUrlCommand *)command whtiOptions:(NSMutableDictionary *)options {
    [PushManager cancelAllLocalPush];
}

- (void)didReceiveRemoteMessage:(NSDictionary *)userInfo {

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSLog(@"%@", jsonString);

    dispatch_async(dispatch_get_main_queue(), ^{

        [self writeJavascript:[NSString stringWithFormat:@"window.plugins.mPushPlugin.receiveRemoteMessageForiOSCallback('%@')", jsonString]];

    });

}

@end
