//
//  ViewController.m
//  YiOs ReUse Code
//
//  Created by Yatin on 29/04/14.
//  Copyright (c) 2014 Yatin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@">%@<",[YiOsCommon YiOSTrim:@" Testing "]);
    
    
    if ([YiOsCommon isEmptyOrNull:nil])
        NSLog(@"nil == Yes");
    if ([YiOsCommon isEmptyOrNull:NULL])
        NSLog(@"NULL == Yes");
    if ([YiOsCommon isEmptyOrNull:@""])
        NSLog(@"\"\" == Yes");
    if ([YiOsCommon isEmptyOrNull:@"Testing"])
        NSLog(@"Testing == Yes");
    else
        NSLog(@"Testing == NO");
    
    
    if ([YiOsCommon isValidEmail:@"test@test.com"])
        NSLog(@"test@test.com isValidEmail");
    if ([YiOsCommon isValidEmail:@"Testing"])
        NSLog(@"Testing isValidEmail");
    
    if (isHeight568)
        NSLog(@"Height == 568");
    
    if (isiPad)
        NSLog(@"is iPad");
    
    if (isiPhone)
        NSLog(@"is iPhone");
    
    if (SystemVersionIsGreaterThen(@"7.0"))
        NSLog(@"System Version Is Greater Then 7.0");
    
    if (SystemVersionIsEqualTo(@"7.0"))
        NSLog(@"System Version Is Equal To 7.0");
}

- (void) listAllFonts {
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

@end
