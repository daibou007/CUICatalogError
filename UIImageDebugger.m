//
//  UIImageDebugger.m
//  MOP
//
//  Created by 杨朋亮 on 2/11/16.
//  Copyright © 2016年 NewLand. All rights reserved.
//

#import "UIImageDebugger.h"
#import "JRSwizzle.h"


@implementation UIImageDebugger

+ (void)startDebugging
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        NSError *error=NULL;
        
        [UIImage jr_swizzleClassMethod:@selector(imageNamed:)
                       withClassMethod:@selector(hs_xxz_imageNamed:)
                                 error:&error];
        
        
        if (error)
        {
            NSLog(@"error setting up UIImageDebugger : %@",error);
        }
        else
        {
            NSLog(@"!!!!!!!!!!!!!!!!!!!!  UIImage swizzle in effect - take this out for release!!");
        }
        
        
    });
    
}

@end

@interface UIImage (UIViewDebugger)

+ (UIImage*)hs_xxz_imageNamed:(NSString *)name;

@end


@implementation UIImage (UIViewDebugger)

+ (UIImage*)hs_xxz_imageNamed:(NSString *)name
{
    if (!name)
    {
        NSLog(@"null image name at \n%@",[NSThread callStackSymbols]);
    }
    
    UIImage *image=[self hs_xxz_imageNamed:name];
    
    if (!image)
    {
        NSLog(@"failed to make image at \n%@",[NSThread callStackSymbols]);
    }
    
    return image;
}

@end
