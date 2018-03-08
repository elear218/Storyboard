//
//  MineTableViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/28.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "MineTableViewController.h"

@interface MineTableViewController ()<CAAnimationDelegate>{
    
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UIButton *bottomButton;
    
}

@end

@implementation MineTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"33333");
    
    [self contentInsetAdjustment];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"refreshing");
        
        __strong __typeof(self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSLog(@"end");
            [strongSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_header = header;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
//    footerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
    
    UILabel *copyRightLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -5, [UIScreen mainScreen].bounds.size.width, 65)];
    copyRightLab.backgroundColor = [UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1];
    copyRightLab.textColor = [UIColor colorWithRed:177/255.f green:177/255.f blue:177/255.f alpha:1];
    copyRightLab.textAlignment = NSTextAlignmentCenter;
    copyRightLab.font = [UIFont systemFontOfSize:13.f];
    copyRightLab.numberOfLines = 0;
    copyRightLab.text = @"Storyboard\niOS版 v1.0.0\n©2018-2020 elear.com\n";
    [footerView addSubview:copyRightLab];
//    copyRightLab.center = footerView.center;
    
    self.tableView.tableFooterView = footerView;
    
    nameLabel.text = @"elear 18630308257\ncompany-CEO";
    
    bottomButton.layer.borderWidth = 1.f;
    bottomButton.layer.borderColor = [UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1].CGColor;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)bottomBtnClick:(UIButton *)sender {
    
    [self.tabBarController setSelectedIndex:0];
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
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    return section == 0 ? CGFLOAT_MIN : tableView.sectionHeaderHeight;
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (1 == indexPath.section) {
        
        switch (indexPath.row) {
            case 0:
            case 1:
            case 2:{
                
                UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                [self.navigationController pushViewController:login.instantiateInitialViewController animated:YES];
            }
                break;
            case 3:
            case 4:
            case 5:{
             
                UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                
                /*
                //模拟present方式跳转
                CATransition *transition = [CATransition animation];
                transition.duration = 0.3f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionMoveIn;
                transition.subtype = kCATransitionFromTop;
                transition.delegate = self;
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                [self.navigationController pushViewController:login.instantiateInitialViewController animated:NO];
                */
                CustomNaviViewController *navi = [[CustomNaviViewController alloc] initWithRootViewController:login.instantiateInitialViewController];
                [self presentViewController:navi animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
