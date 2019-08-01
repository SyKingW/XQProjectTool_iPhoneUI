//
//  XQDirectionButton.h
//  XQTestStepSlider
//
//  Created by WXQ on 2019/4/12.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 图片的位置

 - XQDirectionButtonDirectionNormal: 默认, 用系统的
 - XQDirectionButtonDirectionLeft: 左
 - XQDirectionButtonDirectionRight: 右
 - XQDirectionButtonDirectionUp: 上
 - XQDirectionButtonDirectionDown: 下
 */
typedef NS_ENUM(NSInteger, XQDirectionButtonDirection) {
    XQDirectionButtonDirectionNormal = 0,
    XQDirectionButtonDirectionLeft,
    XQDirectionButtonDirectionRight,
    XQDirectionButtonDirectionUp,
    XQDirectionButtonDirectionDown,
};


/**
 对齐

 - XQDirectionButtonAlignmentCenter: 中间
 - XQDirectionButtonAlignmentLead: 头部
 - XQDirectionButtonAlignmentTail: 尾部
 */
typedef NS_ENUM(NSInteger, XQDirectionButtonAlignment) {
    XQDirectionButtonAlignmentLead = 0,
    XQDirectionButtonAlignmentTail,
    XQDirectionButtonAlignmentCenter
};



NS_ASSUME_NONNULL_BEGIN

@interface XQDirectionButton : UIButton

/** 图片方向, 默认 XQDirectionButtonDirectionNormal
 
 @note 图片都是正方形
 XQDirectionButtonDirectionLeft, XQDirectionButtonDirectionRight 以高为大小
 XQDirectionButtonDirectionUp, XQDirectionButtonDirectionDown 以宽为大小
 */
@property (nonatomic, assign) XQDirectionButtonDirection xq_direction;

/** 图片和文字位置 */
//@property (nonatomic, assign) XQDirectionButtonAlignment xq_alignment;

/** 图片边距, 默认 0
 
 @note 不包括和文字的间距
 */
@property (nonatomic, assign) CGFloat xq_imgMargin;
    
/**
 图片大小
 
 @note 如果设置这个了, xq_imgMargin 就无效
 */
@property (nonatomic, assign) CGFloat xq_imgSize;

/** 文字边距, 默认 0
 
 @note 不包括和图片的间距
 */
@property (nonatomic, assign) CGFloat xq_labMargin;

/** 图片和文字的间距, 默认 0 */
@property (nonatomic, assign) CGFloat xq_imgAndLabSpacing;

/** 是否靠边, 默认YES
 
 @note XQDirectionButtonDirectionUp, XQDirectionButtonDirectionDown 情况下会去计算文字高度, 然后文字靠图片, 而不会出现居中情况
 XQDirectionButtonDirectionLeft, XQDirectionButtonDirectionRight 则直接设置 textAlignment 属性, 左右而已
 */
@property (nonatomic, assign) BOOL xq_labTop;

/**
 YES 显示 badge
 */
@property (nonatomic, assign) BOOL xq_showBadge;

/** 显示数字 */
@property (nonatomic, copy) NSString *xq_badge;

/** 0的时候是否显示
 YES: 显示
 NO: 不显示
 默认为 NO
 */
@property (nonatomic, assign) BOOL xq_badgeZeroShow;



/**
 获取字符串高度
 */
+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;

/**
 获取字符串宽度
 */
+ (CGFloat)getStringWidthWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height;

/**
 获取文字大小
 */
+ (CGSize)getStringSizeWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END














