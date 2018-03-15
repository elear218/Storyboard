//
//  Fold2TableViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/14.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "Fold2TableViewController.h"

#import "FoldTagTableViewCell.h"

@interface Fold2TableViewController ()

@property (nonatomic, copy) NSArray *allTags;
@property (nonatomic, strong) NSMutableArray *cellInfos;
@property (nonatomic, strong) NSMutableArray *stateArr;

@end

@implementation Fold2TableViewController

- (NSMutableArray *)stateArr {
    if (!_stateArr) {
        _stateArr = [NSMutableArray array];
    }
    return _stateArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self contentInsetAdjustment];
    
    _allTags = @[
                 @"AutoLayout", @"dynamically", @"calculates", @"the", @"size", @"and", @"position",
                 @"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",
                 @"on", @"constraints", @"placed", @"on", @"those", @"views"
                 ];
    _cellInfos = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        [_cellInfos addObject:[_allTags subarrayWithRange:NSMakeRange(0, arc4random()%_allTags.count+1)]];
        [self.stateArr addObject:i==0?@0:@1];
    }
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FoldTagTableViewCell class]) forIndexPath:indexPath];
    [cell.button setTitle:[NSString stringWithFormat:@"Cell: %ld", (long)indexPath.row] forState:UIControlStateNormal];
    [cell setTagsArr:_cellInfos[indexPath.row] foldState:[self.stateArr[indexPath.row] boolValue]];
    WeakSelf(self);
    cell.tap = ^{
        StrongSelf(self);
        BOOL state = [self.stateArr[indexPath.row] boolValue];
        [self.stateArr replaceObjectAtIndex:indexPath.row withObject:state?@0:@1];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([FoldTagTableViewCell class]) cacheByIndexPath:indexPath configuration:^(FoldTagTableViewCell *cell) {
        [cell setTagsArr:_cellInfos[indexPath.row] foldState:[self.stateArr[indexPath.row] boolValue]];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置tableView每个分区cell圆角  链接：https://www.jianshu.com/p/abd7738e146b
    
    // 圆角弧度半径
    CGFloat cornerRadius = 5.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 10);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    //单独一个cell
    CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor grayColor].CGColor;
    layer.lineWidth = 2.5f;

    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    //    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    //    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    //    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    //    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    //    cell.selectedBackgroundView = selectedBackgroundView;
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
