//
//  TestTableViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/1.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "TestTableViewController.h"
#import "CodePushViewController.h"
#import "LinePushViewController.h"

#import "HobbyTableViewCell.h"
#import "HobbyModel.h"

typedef enum : NSUInteger {
    SectionTypeInfo = 0,
    SectionTypeHobby,
    SectionTypeSecurity,
} SectionType;

@interface TestTableViewController (){
    
    NSArray *hobbyLocalData;
}

@property (nonatomic, strong) UIView *selectBackgroundView;

@property (nonatomic, strong) NSMutableArray *hobbysArr;

@end

@implementation TestTableViewController

/**
 懒加载

 @return 爱好数组
 */
- (NSMutableArray *)hobbysArr{
    if (!_hobbysArr) {
        _hobbysArr = [NSMutableArray array];
    }
    return _hobbysArr;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadHobbyData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contentInsetAdjustment];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HobbyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"hobbyCellIdentifer"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadHobbyData{
    if (hobbyLocalData.count) {
        [self.hobbysArr removeAllObjects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionTypeHobby] withRowAnimation:UITableViewRowAnimationNone];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.hobbysArr addObjectsFromArray:hobbyLocalData];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionTypeHobby] withRowAnimation:UITableViewRowAnimationNone];
            //        [self addData];
        });
    }else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 获取文件路径
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Hobby" ofType:@"json"];
            // 将文件数据化
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            // 对数据进行JSON格式化
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *dataArr = [NSArray yy_modelArrayWithClass:[HobbyModel class] json:json];
            hobbyLocalData = dataArr;
            [self.hobbysArr addObjectsFromArray:dataArr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionTypeHobby] withRowAnimation:UITableViewRowAnimationNone];
//                [self addData];
            });
        });
    }
}

- (void)addData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hobbysArr addObject:hobbyLocalData[arc4random()%4]];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionTypeHobby] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.hobbysArr.count > 8 ? : [self addData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
//     NSLog(@"class ==== %@",NSStringFromClass([sender class]));
     
     //代码跳转触发
     if ([segue.identifier isEqualToString:@"codePush"]) {
         CodePushViewController *codeVC = segue.destinationViewController;
         codeVC.receivedArr = [sender copy]; //sender为[self performSegueWithIdentifier:@"codePush" sender:self.hobbysArr];传过来的self.hobbysArr
         return;
     }
     
     //连线跳转触发
     LinePushViewController *lineVC = segue.destinationViewController;
     UITableViewCell *cell = sender; //连线跳转时sender为连线的控件
     if (2 == cell.tag) {
         UILabel *customLab = [cell viewWithTag:111];
         lineVC.receivedStr = customLab.text;
     }else
         lineVC.receivedStr = cell.detailTextLabel.text;
}

#pragma mark - 爱好action
- (void)snookerAction:(HobbyModel *)model{
    
    NSLog(@"--- %@ ---",model.item);
}

- (void)badmintonAction:(HobbyModel *)model{
    
    NSLog(@"--- %@ ---",model.item);
}

- (void)skiAction:(HobbyModel *)model{
    
    NSLog(@"--- %@ ---",model.item);
}

- (void)skiddingAction:(HobbyModel *)model{
    
    NSLog(@"--- %@ ---",model.item);
}

#pragma mark - Table view data source
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView.sectionHeaderHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (SectionTypeHobby == section) {//爱好 （动态cell）
        return self.hobbysArr.count;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (SectionTypeHobby == indexPath.section) {//爱好 （动态cell）
        return 60.f;
    }
    return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SectionTypeHobby == indexPath.section) {//爱好 （动态cell）
        HobbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hobbyCellIdentifer" forIndexPath:indexPath];
        cell.model = self.hobbysArr[indexPath.row];
        if (!_selectBackgroundView) {
            _selectBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            _selectBackgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
            UIView *custom = [UIView new];
            custom.backgroundColor = [UIColor cyanColor];
            [_selectBackgroundView addSubview:custom];
            [custom mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 5, 5));
            }];
        }
        cell.selectedBackgroundView = _selectBackgroundView;
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case SectionTypeInfo:
            
            break;
        case SectionTypeHobby:{
         
            HobbyModel *model = self.hobbysArr[indexPath.row];
            
            SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Action:",model.action]);
            if ([self respondsToSelector:sel]) {
                IMP imp = [self methodForSelector:sel];
                void (* func)(id,SEL,HobbyModel *) = (void *)imp;
                func(self,sel,model);
            }else{
                NSLog(@"没有找到这个方法");
            }
        }
            break;
        default:
            [self performSegueWithIdentifier:@"codePush" sender:self.hobbysArr];
            break;
    }
//    if (SectionTypeSecurity == indexPath.section) {
//        [self performSegueWithIdentifier:@"codePush" sender:self.hobbysArr];
//    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(SectionTypeHobby == indexPath.section){//爱好 （动态cell）
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:SectionTypeHobby]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
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

@end
