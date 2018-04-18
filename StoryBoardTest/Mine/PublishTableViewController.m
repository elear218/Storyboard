//
//  PublishTableViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/3.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "PublishTableViewController.h"
#import "ProductImageCell.h"

@interface PublishTableViewController (){
    NSDictionary *localDic;
}

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation PublishTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    localDic = @{
                 @"name" : @[@"商品主图", @"商品轮播图", @"商品详情图"],
                 @"detail" : @[@"1张", @"最多5张", @"最多9张"],
                 @"count" : @[@1, @5, @9]
                 };
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProductImageCell class])];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [UILabel new];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.text = @"请输入描述内容";
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font = [UIFont systemFontOfSize:16.5f];
    [_contentTextView addSubview:placeHolderLabel];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [_contentTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc");
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 != indexPath.section) {
        return 200.f;
    }
    
    NSInteger rowCount = [tableView numberOfRowsInSection:indexPath.section];
    return indexPath.row == rowCount-1 ? 160.f : 60.f;
}

//cell的缩进级别，动态静态cell必须重写，否则会造成崩溃
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(0 != indexPath.section){
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:1]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return tableView.sectionFooterHeight;
}

//设置区尾背景色（group样式无效）
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    // Background color
//    view.tintColor = [UIColor blackColor];
//
//    // Text Color
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    [header.textLabel setTextColor:[UIColor whiteColor]];
//
//    // Another way to set the background color
//    // Note: does not preserve gradient effect of original header
//    // header.contentView.backgroundColor = [UIColor blackColor];
//}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 != section) {
        return [localDic[@"name"] count];
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 != indexPath.section) {
        ProductImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductImageCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = localDic[@"name"][indexPath.row];
        cell.detailLabel.text = localDic[@"detail"][indexPath.row];
        NSInteger maxCount = [localDic[@"count"][indexPath.row] integerValue];
        cell.maxCount = maxCount;
        return cell;
    }

    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
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
