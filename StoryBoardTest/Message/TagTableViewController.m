//
//  TagTableViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/12.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "TagTableViewController.h"

#import "TagTableViewCell.h"

@interface TagTableViewController ()<TagSelectDelegate>
@property (nonatomic, copy) NSArray *allTags;
@property (nonatomic, strong) NSMutableArray *cellInfos;
@property (nonatomic, strong) NSMutableDictionary *tagDic;

@end

@implementation TagTableViewController

- (NSMutableDictionary *)tagDic {
    
    if (!_tagDic) {
        _tagDic = [NSMutableDictionary dictionary];
    }
    return _tagDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self contentInsetAdjustment];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 80;
    
    _allTags = @[
                 @"AutoLayout", @"dynamically", @"calculates", @"the", @"size", @"and", @"position",
                 @"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",
                 @"on", @"constraints", @"placed", @"on", @"those", @"views"
                 ];
    _cellInfos = [NSMutableArray new];
    for (NSInteger i = 0; i < 10; i++) {
        [_cellInfos addObject:[_allTags subarrayWithRange:NSMakeRange(0, i % (_allTags.count + 1))]];
    }
    
    [_cellInfos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tagDic setObject:@[] forKey:@(idx)];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)logAllSelectedTag:(id)sender {
    NSMutableString *logStr = [NSMutableString stringWithString:@"选中了第:\n\n"];
    [self.tagDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSArray *obj, BOOL * _Nonnull stop) {
        if (obj.count) {
            NSString *str = [NSString stringWithFormat:@"%@行,第%@个tag\n",key.stringValue,[obj componentsJoinedByString:@","]];
            [logStr appendString:str];
        }
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[logStr substringToIndex:logStr.length-1] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    UILabel *sectionLab = [UILabel new];
    sectionLab.font = [UIFont boldSystemFontOfSize:16.f];
    sectionLab.textColor = [UIColor whiteColor];
    sectionLab.textAlignment = NSTextAlignmentCenter;
    sectionLab.numberOfLines = 0;
    [header addSubview:sectionLab];
    
    [sectionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 10, 20));
    }];
    
    NSMutableArray *txtArr = [NSMutableArray arrayWithCapacity:section + 1];
    for (int i = 0; i < section + 1; i ++) {
        [txtArr addObject:[NSString stringWithFormat:@"%ld", section + 1]];
    }
    sectionLab.text = [txtArr componentsJoinedByString:@"\n"];
    
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TagTableViewCell class])
                                                                     forIndexPath:indexPath];
    cell.delegate = self;
    cell.tagView.selectionLimit = indexPath.row % 2 ? 3 : 0;
    cell.label.text = [NSString stringWithFormat:@"Cell: %ld", (long)indexPath.row];
    [cell setTagsArr:_cellInfos[indexPath.row] selectedArr:self.tagDic[@(indexPath.row)]];
    return cell;
}

#pragma mark -- TagSelectDelegate
- (void)selectTagAtIndex:(NSInteger)idx selected:(BOOL)selected in:(TagTableViewCell *)cell {
    
//    NSLog(@"click");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSMutableArray *tagArr = [NSMutableArray arrayWithArray:self.tagDic[@(indexPath.row)]];
    
    /*
    if (cell.tagView.selectionLimit) {
        //有选中个数限制
        if (!selected && tagArr.count == cell.tagView.selectionLimit) {
            [tagArr replaceObjectAtIndex:tagArr.count-1 withObject:@(idx)];
            [self.tagDic setObject:tagArr forKey:@(indexPath.row)];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            if (selected) {
                [tagArr removeObject:@(idx)];
            }else {
                [tagArr addObject:@(idx)];
            }
            [self.tagDic setObject:tagArr forKey:@(indexPath.row)];
        }
    }else{
        //无选中个数限制
        if (selected) {
            [tagArr removeObject:@(idx)];
        }else {
            [tagArr addObject:@(idx)];
        }
        [self.tagDic setObject:tagArr forKey:@(indexPath.row)];
    }
    */
    
    if (cell.tagView.selectionLimit && !selected && tagArr.count == cell.tagView.selectionLimit) {
        //有选中个数限制并且当前已选满  替换最后一个选择的为当前选中的
        [tagArr replaceObjectAtIndex:tagArr.count-1 withObject:@(idx)];
        [self.tagDic setObject:tagArr forKey:@(indexPath.row)];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        if (selected) {
            [tagArr removeObject:@(idx)];
        }else {
            [tagArr addObject:@(idx)];
        }
        [self.tagDic setObject:tagArr forKey:@(indexPath.row)];
    }
    //    NSLog(@" ---- %ld ---- %ld ---- %d ---- ",(long)indexPath.row,(long)idx,selected);
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
