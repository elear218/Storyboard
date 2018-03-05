//
//  UITableViewCell+Action.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/1.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "UITableViewCell+Action.h"

#import <objc/runtime.h>

@implementation UITableViewCell (Action)

static void *actionIdentifierKey = &actionIdentifierKey;

- (void)setActionIdentifier:(NSString *)actionIdentifier{
    
    objc_setAssociatedObject(self, &actionIdentifierKey, actionIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)actionIdentifier{
    
    return objc_getAssociatedObject(self, &actionIdentifierKey);
}

@end
