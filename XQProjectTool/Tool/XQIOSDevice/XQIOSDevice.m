//
//  XQIOSDevice.m
//  XQAddProperty
//
//  Created by ladystyle100 on 2017/9/25.
//  Copyright © 2017年 WangXQ. All rights reserved.
//

#import "XQIOSDevice.h"

//#import "XQIPAddress.h"
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

/*
 手机系统版本：9.1
 NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
 
 手机系统：iPhone OS
 NSString * iponeM = [[UIDevice currentDevice] systemName];
 
 电池电量
 CGFloat batteryLevel=[[UIDevicecurrentDevice] batteryLevel];
 
 状态栏
 [UIApplication sharedApplication].statusBarFrame
 */

// 避免重复计算

static CGFloat statusHeight_ = -1;

@implementation XQIOSDevice

+ (CGFloat)getNavigationHeight {
    CGFloat nHeight = 44;
    return nHeight + [self getStatusHeight];
}

+ (CGFloat)getStatusHeight {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if TARGET_OS_IPHONE
        
        CGFloat height = 0;
        if (@available(iOS 13.0, *)) {
            UIWindowScene *ws = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
            height = ws.statusBarManager.statusBarFrame.size.height;
        } else {
            height = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        
        // statusHeight_ 20 是正常高度, 40 是开启热点, QQ语音, 定位等等, 会增加20
        // 但是全面屏就 statusHeight_ 都有44以上了
        // iOS 14 之后，iPhone x 这些获取的是 48, 47 这样
        
//        height == 44 ||
//            height == 64 ||
//            height == 48
        
        // 不能 44，在放大模式下，如果字体默认情况下，是39 (iPhone 12 Pro测)，有些机型是 43 等等
//        if (height >= 44) {
        if (height >= 30) {
//            statusHeight_ = 44;
            statusHeight_ = height;
        }else {
            statusHeight_ = 20;
        }
#endif
    });
    
    return statusHeight_;
}

+ (CGFloat)getTabbarHeight {
    if ([self getStatusHeight] >= 30) {
        return 83;
    }
    return 49;
}

+ (CGFloat)getSubNavHeight {
    CGFloat height = 0;
#if TARGET_OS_IPHONE
    height = [UIScreen mainScreen].bounds.size.height - [self getNavigationHeight];
#endif
    return height;
}

+ (CGFloat)getSubNavAndTabHeight {
    return [self getSubNavHeight] - [self getTabbarHeight];
}

/**
 是否默认机型...就是iPhoneX为NO, iPhone7这种为YES
 */
+ (BOOL)isNormalModel {
    if ([self getStatusHeight] != 20) {
        return NO;
    }
    return YES;
}




@end





