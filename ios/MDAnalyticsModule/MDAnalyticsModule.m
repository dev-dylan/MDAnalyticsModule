//
//  MDAnalyticsModule.m
//  MDAnalyticsModule
//
//  Created by 彭远洋 on 2020/12/22.
//

#import "MDAnalyticsModule.h"
#if __has_include(<SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>)
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#else
#import "SensorsAnalyticsSDK.h"
#endif
#import <UIKit/UIKit.h>

@implementation MDAnalyticsModule

- (void)performSelectorWithImplementation:(void(^)(void))implementation {
    @try {
        implementation();
    } @catch (NSException *exception) {
        NSLog(@"[uni-app SensorsAnalyticsModule] error:%@",exception);
    }
}

- (nullable id)objectForInfoDictionaryKey:(NSString *)key {
    if (!key.length) {
        return nil;
    }
    // TODO: 修改 module 名称
    NSDictionary *analytics = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MDAnalyticsModule"];
    return analytics[key];
}

WX_EXPORT_METHOD(@selector(track:properties:))
- (void)track:(NSString *)eventName properties:(NSDictionary *)properties {
    NSString *serverUrl = [self objectForInfoDictionaryKey:@"serverUrl"];
    NSString *message = [NSString stringWithFormat:@"获取到的数据接收地址为：%@", serverUrl];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:action];
    UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [root presentViewController:alert animated:YES completion:nil];

    [self performSelectorWithImplementation:^{
        [[SensorsAnalyticsSDK sharedInstance] track:eventName withProperties:properties];
    }];
}

WX_EXPORT_METHOD(@selector(login:properties:))
- (void)login:(NSString *)loginId properties:(NSDictionary *)properties {
    [self performSelectorWithImplementation:^{
        [[SensorsAnalyticsSDK sharedInstance] login:loginId withProperties:properties];
    }];
}

WX_EXPORT_METHOD(@selector(identify:))
- (void)identify:(NSString *)distinctId {
    [self performSelectorWithImplementation:^{
        [[SensorsAnalyticsSDK sharedInstance] identify:distinctId];
    }];
}

WX_EXPORT_METHOD_SYNC(@selector(getPresetProperties))
- (NSDictionary *)getPresetProperties {
    __block NSDictionary *preset = nil;
    [self performSelectorWithImplementation:^{
        preset = [[SensorsAnalyticsSDK sharedInstance] currentSuperProperties];
    }];
    return preset;
}

@end
