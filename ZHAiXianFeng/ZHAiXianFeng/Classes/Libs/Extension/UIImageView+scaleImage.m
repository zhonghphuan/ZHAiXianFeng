//
//  UIImageView+scaleImage.m
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/22.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

#import "UIImageView+scaleImage.h"

@implementation UIImage (scaleImage)
+(UIImage *)createNewImageWithColor:(UIImage *)image multiple:(CGFloat)multiple{

    CGFloat newMultiple = multiple;
    if (multiple == 0) {
        newMultiple = 1;
    }
    else if((fabs(multiple) > 0 && fabs(multiple) < 1) || (fabs(multiple)>1 && fabs(multiple)<2))
    {
        newMultiple = multiple;
    }
    else
    {
        newMultiple = 1;
    }
    CGFloat w = image.size.width*newMultiple;
    CGFloat h = image.size.height*newMultiple;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *tempImage = nil;
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:0] addClip];
    [image drawInRect:imageFrame];
    tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;

}


@end
