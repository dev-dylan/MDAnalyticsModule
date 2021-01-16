//
//  MDAnalyticsProxy.h
//  MDAnalyticsModule
//
//  Created by 彭远洋 on 2021/1/6.
//

#import <Foundation/Foundation.h>
#if __has_include(<WeexSDK.h>)
#import <WeexSDK.h>
#else
#import "WeexSDK.h"
#endif

#import "UniPluginProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDAnalyticsProxy : NSObject <UniPluginProtocol>

@end

NS_ASSUME_NONNULL_END
