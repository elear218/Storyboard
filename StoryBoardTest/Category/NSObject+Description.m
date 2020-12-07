//
//  NSObject+Description.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/7.
//  Copyright © 2020 eall. All rights reserved.
//

#import "NSObject+Description.h"

@implementation NSObject (Description)

- (NSString *)ivar_description {
    unsigned int count;
    const char *clasName    = object_getClassName(self);
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[ \n", clasName, self];
    Class clas              = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars             = class_copyIvarList(clas, &count);
    
    for (int i = 0; i < count; i++) {
        
        @autoreleasepool {
            
            Ivar       ivar  = ivars[i];
            const char *name = ivar_getName(ivar);
            
            //得到类型
            NSString *type   = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key    = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id       value   = [self valueForKey:key];
            
            //确保BOOL值输出的是YES 或 NO
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }
            
            [string appendFormat:@"\t%@: %@\n", [self deleteUnderLine:key], value];
        }
    }
    
    [string appendFormat:@"]"];
    return string;
}

// 去掉下划线
- (NSString *)deleteUnderLine:(NSString *)string {
    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}

@end
