//
//  ios-shared.h
//  ios-shared
//
//  Created by Brandon Sneed on 3/15/2013.
//  Copyright (c) 2013 SetDirection. All rights reserved.
//

#ifdef __OBJC__

// Required frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Low level bits
#import "SDMacros.h"
#import "ObjectiveCGenerics.h"
#import "SDLog.h"

// Foundation Extensions
#import "NSArray+SDExtensions.h"
#import "NSData+SDExtensions.h"
#import "NSDate+SDExtensions.h"
#import "NSDictionary+SDExtensions.h"
#import "NSError+SDExtensions.h"
#import "NSObject+SDExtensions.h"
#import "NSRunLoop+SDExtensions.h"
#import "NSShadow+SDExtensions.h"
#import "NSString+SDExtensions.h"

// UIKit Extensions
#import "SDAlertView.h"
#import "UIAlertView+SDExtensions.h"
#import "UIApplication+SDExtensions.h"
#import "UIColor+SDExtensions.h"
#import "UIDevice+machine.h"
#import "UIResponder+SDExtensions.h"
#import "UIScreen+SDExtensions.h"
#import "UIView+SDExtensions.h"
#import "UIViewController+SDExtensions.h"

// Application Additions
#import "SDApplication.h"

// Services
#import "SDURLConnection.h"
#import "SDWebService.h"
#import "SDWebService+SDProcessingBlocks.h"

#endif
