//
//  ModifyLanguageViewController.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/14.
//  Copyright © 2020 eall. All rights reserved.
//

#import "ModifyLanguageViewController.h"
#import "CustomTabBarController.h"

@interface ModifyLanguageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *zhBtn;
@property (weak, nonatomic) IBOutlet UIButton *enBtn;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property (nonatomic, copy) NSString *language;

@property (nonatomic, copy) NSString *currentLanguage;

@property (nonatomic, assign) BOOL isChange;

@end

@implementation ModifyLanguageViewController

- (NSString *)currentLanguage {
    if (!_currentLanguage) {
        _currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGEKEY];
    }
    return _currentLanguage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTopBarWithTitle:NSLocalizedString(@"切换语言", nil)];
    [self addLeftButtonWithImage:[kImageNamed(@"back_white") colorizewithColor:kBlackColor]];
    [self addRightButtonText:NSLocalizedStringFromTable(@"完成", @"Elear", nil)];
    
    [self.zhBtn setTitle:NSLocalizedStringFromTable(@"简体中文", @"Elear", nil) forState:UIControlStateNormal];
    [self.enBtn setTitle:NSLocalizedStringFromTable(@"英文", @"Elear", nil) forState:UIControlStateNormal];
    
    self.language = [self.currentLanguage copy];
}

- (void)leftButtonPress {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonPress {
    if (!self.isChange) {
        return;
    }
    [self showLoading:[self.language isEqualToString:@"en"] ? @"switching..." : @"切换中..."];
    [[NSUserDefaults standardUserDefaults] setObject:self.language forKey:LANGUAGEKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //设置语言
        [NSBundle setLanguage:self.language];
        
        // 我们要把系统windown的rootViewController替换掉
        CustomTabBarController *tab = [[CustomTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        tab.selectedIndex = 2;
        
        [[(CustomNaviViewController *)tab.selectedViewController topViewController] performSegueWithIdentifier:@"pushPersonCenter" sender:nil];
        
        HUDNormal([self.language isEqualToString:@"en"] ? @"switch success" : @"切换成功");
    });
}

- (IBAction)languageBtnClick:(UIButton *)sender {
    self.testLabel.text = sender.tag ? @"TestLabel" : @"测试文本";
    self.language = sender.tag ? @"en" : @"zh-Hans";
    self.isChange = ![self.language isEqualToString:self.currentLanguage];
}

@end
