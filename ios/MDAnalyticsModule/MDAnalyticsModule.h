//
//  MDAnalyticsModule.h
//  MDAnalyticsModule
//
//  Created by 彭远洋 on 2020/12/22.
//

#import <Foundation/Foundation.h>
#if __has_include(<WeexSDK.h>)
#import <weexHeader/WeexSDK.h>
#else
#import "WeexSDK.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MDAnalyticsModule : NSObject <WXModuleProtocol>

@end

NS_ASSUME_NONNULL_END
