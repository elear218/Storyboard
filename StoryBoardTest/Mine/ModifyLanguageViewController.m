//
//  ModifyLanguageViewController.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/14.
//  Copyright © 2020 eall. All rights reserved.
//

#import "ModifyLanguageViewController.h"

@interface ModifyLanguageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *zhBtn;
@property (weak, nonatomic) IBOutlet UIButton *enBtn;

@end

@implementation ModifyLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTopBarWithTitle:NSLocalizedString(@"切换语言", nil)];
    [self addLeftButtonWithImage:[kImageNamed(@"back_white") colorizewithColor:kBlackColor]];
    [self addRightButtonText:NSLocalizedStringFromTable(@"完成", @"Elear", nil)];
    
    [self.zhBtn setTitle:NSLocalizedStringFromTable(@"简体中文", @"Elear", nil) forState:UIControlStateNormal];
    [self.enBtn setTitle:NSLocalizedStringFromTable(@"英文", @"Elear", nil) forState:UIControlStateNormal];
}

- (void)leftButtonPress {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonPress {
    
}

- (IBAction)languageBtnClick:(UIButton *)sender {
    
}

@end
