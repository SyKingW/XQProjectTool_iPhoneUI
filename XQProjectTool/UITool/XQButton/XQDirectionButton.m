//
//  XQDirectionButton.m
//  XQTestStepSlider
//
//  Created by WXQ on 2019/4/12.
//  Copyright © 2019 WXQ. All rights reserved.
//

#import "XQDirectionButton.h"

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
    if (self.xq_direction == XQDirectionButtonDirectionNormal) {
        // 不做任何操作
        return;
    }
    
    
    switch (self.xq_direction) {
        case XQDirectionButtonDirectionUp: {
            CGFloat imgSize = self.frame.size.width - self.xq_imgMargin * 2;
            self.imageView.frame = CGRectMake(self.xq_imgMargin, self.xq_imgMargin, imgSize, imgSize);
            
            CGFloat y = self.imageView.frame.size.height + self.imageView.frame.origin.y + self.xq_imgAndLabSpacing;
            CGFloat height = self.bounds.size.height - y - self.xq_labMargin;
            CGFloat width = self.frame.size.width - self.xq_labMargin * 2;
            
            if (self.xq_labTop) {
                CGFloat nHeight = [XQDirectionButton getStringHeightWithText:self.titleLabel.text font:self.titleLabel.font viewWidth:width];
                if (nHeight < height) {
                    height = nHeight;
                }
                
            }
            
            self.titleLabel.frame = CGRectMake(self.xq_labMargin, y, width, height);
        }
            break;
            
        case XQDirectionButtonDirectionDown: {
            CGFloat imgSize = self.frame.size.width - self.xq_imgMargin * 2;
            CGFloat y = self.bounds.size.height - imgSize - self.xq_imgMargin;
            self.imageView.frame = CGRectMake(self.xq_imgMargin, y, imgSize, imgSize);
            
            CGFloat height = self.bounds.size.height - self.imageView.frame.origin.y - self.xq_imgAndLabSpacing - self.xq_labMargin;
            CGFloat width = self.frame.size.width - self.xq_labMargin * 2;
            
            if (self.xq_labTop) {
                CGFloat nHeight = [XQDirectionButton getStringHeightWithText:self.titleLabel.text font:self.titleLabel.font viewWidth:width];
                if (nHeight < height) {
                    height = nHeight;
                }
            }
            
            CGFloat labY = self.imageView.frame.origin.y - self.xq_imgAndLabSpacing - height;
            
            self.titleLabel.frame = CGRectMake(self.xq_labMargin, labY, width, height);
        }
            break;
            
        case XQDirectionButtonDirectionLeft: {
            CGFloat imgSize = self.frame.size.height - self.xq_imgMargin * 2;
            self.imageView.frame = CGRectMake(self.xq_imgMargin, self.xq_imgMargin, imgSize, imgSize);
            
            CGFloat height = self.bounds.size.height - self.xq_labMargin * 2;
            CGFloat x = self.frame.size.width - (self.imageView.frame.origin.x + self.imageView.frame.size.width) - self.xq_imgAndLabSpacing;
            CGFloat width = self.frame.size.width - x - self.xq_labMargin;
            self.titleLabel.frame = CGRectMake(x, self.xq_labMargin, width, height);
            
            if (self.xq_labTop) {
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
            }
        }
            break;
            
        case XQDirectionButtonDirectionRight: {
            CGFloat imgSize = self.frame.size.height - self.xq_imgMargin * 2;
            CGFloat x = self.frame.size.width - imgSize - self.xq_imgMargin;
            self.imageView.frame = CGRectMake(x, self.xq_imgMargin, imgSize, imgSize);
            
            CGFloat height = self.bounds.size.height - self.xq_labMargin * 2;
            CGFloat width = self.bounds.size.width - self.xq_labMargin - self.xq_imgAndLabSpacing - self.imageView.frame.origin.x;
            self.titleLabel.frame = CGRectMake(self.xq_labMargin, self.xq_labMargin, width, height);
            
            if (self.xq_labTop) {
                self.titleLabel.textAlignment = NSTextAlignmentRight;
            }
        }
            break;
            
        default:
            break;
    }
    
    
}


/**
 获取字符串高度
 */
+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    // ceilf 小数点去掉，进 1
    CGSize size = [self getStringSizeWithText:text font:font height:MAXFLOAT width:width];
    return ceilf(size.height);
}

/**
 获取字符串宽度
 */
+ (CGFloat)getStringWidthWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height {
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    // ceilf 小数点去掉，进 1
    CGSize size = [self getStringSizeWithText:text font:font height:height width:MAXFLOAT];
    return ceilf(size.width);
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



















