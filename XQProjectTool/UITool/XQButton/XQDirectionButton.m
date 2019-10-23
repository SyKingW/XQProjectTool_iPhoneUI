//
//  XQDirectionButton.m
//  XQTestStepSlider
//
//  Created by WXQ on 2019/4/12.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "XQDirectionButton.h"

@interface XQDirectionButton ()

/**
 badge
 */
@property (nonatomic, strong) UILabel *xq_badgeLab;

@end

@implementation XQDirectionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.xq_labTop = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.xq_labTop = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self reloadUI];
}

- (void)reloadUI {
    if (self.xq_direction == XQDirectionButtonDirectionNormal) {
        
    }else {
        CGRect imgRect = CGRectNull;
        CGRect labRect = CGRectNull;
        
        
        switch (self.xq_direction) {
            case XQDirectionButtonDirectionUp: {
                CGFloat imgSize = self.frame.size.width - self.xq_imgMargin * 2;
                imgRect = CGRectMake(self.xq_imgMargin, self.xq_imgMargin, imgSize, imgSize);
                
                CGFloat y = imgRect.size.height + imgRect.origin.y + self.xq_imgAndLabSpacing;
                CGFloat height = self.bounds.size.height - y - self.xq_labMargin;
                CGFloat width = self.frame.size.width - self.xq_labMargin * 2;
                
                if (self.xq_labTop) {
                    CGFloat nHeight = [XQDirectionButton getStringHeightWithText:self.titleLabel.text font:self.titleLabel.font viewWidth:width];
                    if (nHeight < height) {
                        height = nHeight;
                    }
                    
                }
                
                labRect = CGRectMake(self.xq_labMargin, y, width, height);
            }
                break;
                
            case XQDirectionButtonDirectionDown: {
                CGFloat imgSize = self.frame.size.width - self.xq_imgMargin * 2;
                CGFloat y = self.bounds.size.height - imgSize - self.xq_imgMargin;
                imgRect = CGRectMake(self.xq_imgMargin, y, imgSize, imgSize);
                
                CGFloat height = self.bounds.size.height - imgRect.origin.y - self.xq_imgAndLabSpacing - self.xq_labMargin;
                CGFloat width = self.frame.size.width - self.xq_labMargin * 2;
                
                if (self.xq_labTop) {
                    CGFloat nHeight = [XQDirectionButton getStringHeightWithText:self.titleLabel.text font:self.titleLabel.font viewWidth:width];
                    if (nHeight < height) {
                        height = nHeight;
                    }
                }
                
                CGFloat labY = imgRect.origin.y - self.xq_imgAndLabSpacing - height;
                
                labRect = CGRectMake(self.xq_labMargin, labY, width, height);
            }
                break;
                
            case XQDirectionButtonDirectionLeft: {
                CGFloat imgSize = self.frame.size.height - self.xq_imgMargin * 2;
                imgRect = CGRectMake(self.xq_imgMargin, self.xq_imgMargin, imgSize, imgSize);
                
                CGFloat height = self.bounds.size.height - self.xq_labMargin * 2;
                CGFloat x = self.frame.size.width - (imgRect.origin.x + imgRect.size.width) - self.xq_imgAndLabSpacing;
                CGFloat width = self.frame.size.width - x - self.xq_labMargin;
                labRect = CGRectMake(x, self.xq_labMargin, width, height);
                
                if (self.xq_labTop) {
                    self.titleLabel.textAlignment = NSTextAlignmentLeft;
                }
            }
                break;
                
            case XQDirectionButtonDirectionRight: {
                CGFloat imgSize = self.frame.size.height - self.xq_imgMargin * 2;
                CGFloat x = self.frame.size.width - imgSize - self.xq_imgMargin;
                imgRect = CGRectMake(x, self.xq_imgMargin, imgSize, imgSize);
                
                CGFloat height = self.bounds.size.height - self.xq_labMargin * 2;
                CGFloat width = self.bounds.size.width - self.xq_labMargin - self.xq_imgAndLabSpacing - imgRect.origin.x;
                labRect = CGRectMake(self.xq_labMargin, self.xq_labMargin, width, height);
                
                if (self.xq_labTop) {
                    self.titleLabel.textAlignment = NSTextAlignmentRight;
                }
            }
                break;
                
            default:
                break;
        }
        
        
        self.imageView.frame = imgRect;
        self.titleLabel.frame = labRect;
        
    }
    
    if (self.xq_showBadge) {
        if (!self.xq_badgeLab) {
            self.xq_badgeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
            self.xq_badgeLab.backgroundColor = [UIColor redColor];
            self.xq_badgeLab.textColor = [UIColor whiteColor];
            self.xq_badgeLab.font = [UIFont systemFontOfSize:11];
            self.xq_badgeLab.textAlignment = NSTextAlignmentCenter;
            
            self.xq_badgeLab.layer.cornerRadius = self.xq_badgeLab.frame.size.width/2;
            
        }
        
        if (self.xq_badge.integerValue == 0) {
            if (self.xq_badgeZeroShow) {
                self.xq_badgeLab.hidden = NO;
            }else {
                self.xq_badgeLab.hidden = YES;
            }
        }else {
            self.xq_badgeLab.hidden = NO;
        }
        
        self.xq_badgeLab.center = CGPointMake(self.imageView.frame.origin.x + self.imageView.frame.size.width, self.imageView.frame.origin.y + 0);
        self.xq_badgeLab.text = self.xq_badge;
        [self addSubview:self.xq_badgeLab];
    }
}


/**
 获取字符串高度
 */
+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    // ceilf 小数点去掉，进 1
    CGSize size = [self getStringSizeWithText:text font:font height:MAXFLOAT width:width];
    return ceilf(size.height) + 1;
}

/**
 获取字符串宽度
 */
+ (CGFloat)getStringWidthWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height {
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    // ceilf 小数点去掉，进 1
    CGSize size = [self getStringSizeWithText:text font:font height:height width:MAXFLOAT];
    return ceilf(size.width) + 1;
}

/**
 获取文字大小
 */
+ (CGSize)getStringSizeWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height width:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, height);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // ceilf 小数点去掉，进 1
    return size;
}

+ (CGFloat)getString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}

@end



















