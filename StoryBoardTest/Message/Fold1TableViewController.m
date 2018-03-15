//
//  Fold1TableViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "Fold1TableViewController.h"

#import "FoldSectionView.h"
#import "FoldTableViewCell.h"

@interface Fold1TableViewController (){
    
    NSArray<FoldModel *> *dataArr;
}
@property (nonatomic, strong) NSMutableArray *sectionStatusArr;

@end

@implementation Fold1TableViewController

- (NSMutableArray *)sectionStatusArr {
    if (!_sectionStatusArr) {
        _sectionStatusArr = [NSMutableArray array];
    }
    return _sectionStatusArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self contentInsetAdjustment];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Fold" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化
        NSError *err;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (!err) {
            dataArr = [NSArray yy_modelArrayWithClass:[FoldModel class] json:json];
            for (int i = 0; i < dataArr.count; i++) {
                [self.sectionStatusArr addObject:i==0?@1:@0];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        });
    });
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.sectionStatusArr[section] boolValue]) {
        return [[dataArr[section] rowArr] count];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FoldSectionView *view = [[FoldSectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), tableView.sectionHeaderHeight)];
    WeakSelf(self);
    view.block = ^{
        NSLog(@"section:%ld",(long)section);
        StrongSelf(self);
        BOOL status = [self.sectionStatusArr[section] boolValue];
        NSNumber *num = status? @0 :@1;
        [self.sectionStatusArr replaceObjectAtIndex:section withObject:num];
        //重新加载当前区
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    };
    [view updateContent:dataArr[section]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FoldTableViewCell class]) forIndexPath:indexPath];
    cell.model = [dataArr[indexPath.section] rowArr][indexPath.row];
    return cell;
}

- (void)dealloc {
    NSLog(@"Dealloc");
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
