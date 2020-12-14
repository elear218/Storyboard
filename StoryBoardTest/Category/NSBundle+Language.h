//
//  NSBundle+Language.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/14.
//  Copyright © 2020 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString *const LANGUAGEKEY;

@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end

NS_ASSUME_NONNULL_END
