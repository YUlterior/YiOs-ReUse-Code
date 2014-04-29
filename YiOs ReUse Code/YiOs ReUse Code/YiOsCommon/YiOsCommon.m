//
//  YiOsCommon.m
//  YiOs ReUse Code
//
//  Created by Yatin on 29/04/14.
//  Copyright (c) 2014 Yatin. All rights reserved.
//

#import "YiOsCommon.h"

@implementation YiOsCommon

+ (NSString *) YiOSTrim:(NSString *) stringToTrim {
    return [stringToTrim stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL) isEmptyOrNull:(NSString *) stringToCheck {
    if ([stringToCheck isEqual:[NSNull null]]) return YES;
    stringToCheck = [self YiOSTrim:[NSString stringWithFormat:@"%@",stringToCheck]];
    if([stringToCheck isEqualToString:@"(null)"]) stringToCheck = @"";
    return ([stringToCheck isEqualToString:@""])?YES:NO;
}

+ (BOOL) isValidEmail:(NSString *) emailAddress {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:[self YiOSTrim:emailAddress]];
}

+ (NSString *) urlEncodeString:(NSString *) stringUrl
{
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                    (CFStringRef) stringUrl,
                                                                    NULL,
                                                                    (CFStringRef) @"!*'();@&=+$,\?%#[]",
                                                                    kCFStringEncodingUTF8);
    
    stringUrl = [NSString stringWithFormat:@"%@",(__bridge NSString *)stringRef];
    CFRelease(stringRef);
    return stringUrl;
}

+ (UIImage *) rotateImage:(UIImage *)image;
{
    CGImageRef          imgRef = image.CGImage;
    CGFloat             width = CGImageGetWidth(imgRef);
    CGFloat             height = CGImageGetHeight(imgRef);
    CGAffineTransform   transform = CGAffineTransformIdentity;
    CGRect              bounds = CGRectMake(0, 0, width, height);
    CGSize              imageSize = bounds.size;
    CGFloat             boundHeight;
    UIImageOrientation  orientation = image.imageOrientation;
    
    switch(orientation) {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        default:
            // image is not auto-rotated by the photo picker, so whatever the user
            // sees is what they expect to get. No modification necessary
            transform = CGAffineTransformIdentity;
            break;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 1.0);
    
    if ((orientation == UIImageOrientationDown) || (orientation == UIImageOrientationRight) || (orientation == UIImageOrientationUp)){
        // flip the coordinate space upside down
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

@end
