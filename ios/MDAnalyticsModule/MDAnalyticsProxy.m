//
//  MDAnalyticsProxy.m
//  MDAnalyticsModule
//
//  Created by 彭远洋 on 2021/1/6.
//

#import "MDAnalyticsProxy.h"
#import <UIKit/UIKit.h>
#if __has_include(<SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>)
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#else
#import "SensorsAnalyticsSDK.h"
#endif

@implementation MDAnalyticsProxy

#pragma mark - proxy method
- (nullable id)objectForInfoDictionaryKey:(NSString *)key {
    if (!key.length) {
        return nil;
    }
    // TODO: 修改 module 名称
    NSDictionary *analytics = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MDAnalyticsModule"];
    return analytics[key];
}

- (void)startWithLaunchOptions:(NSDictionary *)launchOptions {
    NSString *serverUrl = [self objectForInfoDictionaryKey:@"serverUrl"];
    NSNumber *enableLog = [self objectForInfoDictionaryKey:@"enableLog"];
    NSString *message = [NSString stringWithFormat:@"获取到的数据接收地址为：%@", serverUrl];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:action];
    [root presentViewController:alert animated:YES completion:nil];
    if (!serverUrl) {
        return;
    }

    SAConfigOptions *options = [[SAConfigOptions alloc] initWithServerURL:serverUrl launchOptions:launchOptions];
    //TODO: 读取参数设置
    options.enableLog = enableLog.boolValue;
    options.autoTrackEventType = SensorsAnalyticsEventTypeAppStart | SensorsAnalyticsEventTypeAppEnd;

    [SensorsAnalyticsSDK startWithConfigOptions:options];
}

#pragma mark - uni-app plugin lifeCycle
-(void)onCreateUniPlugin {
    NSLog(@"[uni-app SensorsAnalyticsModule] initialize sucess !!!");
}

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions {
    [self startWithLaunchOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *_Nullable)application handleOpenURL:(NSURL *_Nullable)url {
    return [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url];
}

- (BOOL)application:(UIApplication *_Nullable)application openURL:(NSURL *_Nullable)url sourceApplication:(NSString *_Nullable)sourceApplication annotation:(id _Nonnull )annotation {
    return [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url];
}

- (BOOL)application:(UIApplication *_Nullable)app openURL:(NSURL *_Nonnull)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *_Nullable)options {
    return [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url];
}

- (BOOL)application:(UIApplication *_Nullable)application continueUserActivity:(NSUserActivity *_Nullable)userActivity restorationHandler:(void(^_Nullable)(NSArray * __nullable restorableObjects))restorationHandler {
    return [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:userActivity.webpageURL];
}

@end
