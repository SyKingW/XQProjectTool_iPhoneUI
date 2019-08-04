//
//  XQEqualSpaceFlowLayout.h
//  CMPageTitleView
//
//  Created by WXQ on 2019/8/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 cell位置

 - XQEqualSpaceFlowLayoutAlignTypeLeft: 左
 - XQEqualSpaceFlowLayoutAlignTypeCenter: 中
 - XQEqualSpaceFlowLayoutAlignTypeRight: 右
 */
typedef NS_ENUM(NSInteger, XQEqualSpaceFlowLayoutAlignType) {
    XQEqualSpaceFlowLayoutAlignTypeLeft,
    XQEqualSpaceFlowLayoutAlignTypeCenter,
    XQEqualSpaceFlowLayoutAlignTypeRight
};

/**
 使用这个有问题, 还没解决
 就是会影响在外面设置好的间距这些了, 这个要优化
 */
@interface XQEqualSpaceFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWthType:(XQEqualSpaceFlowLayoutAlignType)cellType;

/**
 两个Cell之间的距离
 */
@property (nonatomic,assign) CGFloat betweenOfCell;

/**
 cell对齐方式
 */
@property (nonatomic,assign) XQEqualSpaceFlowLayoutAlignType cellType;


@end

NS_ASSUME_NONNULL_END
