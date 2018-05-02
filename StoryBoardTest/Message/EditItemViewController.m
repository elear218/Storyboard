//
//  EditItemViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "EditItemViewController.h"

#import "AlipayItemModel.h"

@interface EditItemViewController () {
    NSMutableArray *itemArr;
}

@end

@implementation EditItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AlipayItem" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化
        NSError *err;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (!err) {
            NSArray *dataArr = [NSArray yy_modelArrayWithClass:[AlipayItemModel class] json:json];
            int count = arc4random_uniform(11) + 1;
//            NSMutableArray *newItemArr = [NSMutableArray arrayWithCapacity:count];
            NSMutableSet *set = [NSMutableSet set];
            for (int i = 0; i < count; i ++) {
                AlipayItemModel *model = dataArr[arc4random()%(dataArr.count-1)];
                [set addObject:model];
            }
            itemArr = [NSMutableArray arrayWithArray:set.allObjects];
            [itemArr addObject:[dataArr lastObject]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新的Item数：" message:[NSString stringWithFormat:@"%lu个",(unsigned long)itemArr.count - 1] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (self.changeBlock) {
                    self.changeBlock(itemArr);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    });
   
}

- (void)dealloc {
    NSLog(@"Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
