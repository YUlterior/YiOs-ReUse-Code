//
//  YiOsCommon.h
//  YiOs ReUse Code
//
//  Created by Yatin on 29/04/14.
//  Copyright (c) 2014 Yatin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YiOsCommon : NSObject

+ (NSString *) YiOSTrim:(NSString *) stringToTrim;
+ (BOOL) isEmptyOrNull:(NSString *) stringToCheck;
+ (BOOL) isValidEmail:(NSString *) emailAddress;
+ (NSString *) urlEncodeString:(NSString *) stringUrl;
+ (UIImage *) rotateImage:(UIImage *)image;

@end
