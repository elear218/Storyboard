//
//  PresentViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/28.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "PresentViewController.h"

#import "SelectTableViewCell.h"

@interface PresentViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    __weak IBOutlet UIButton *editBtn;
    __weak IBOutlet UIButton *selectBtn;
    
    NSArray *localArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataMutArr;

@property (nonatomic, strong) NSMutableSet *deleteMutSet; //用set保存要删除的元素可以保证没有重复的元素

@end

static NSString *const cellId = @"SelectCellIdentifer";

@implementation PresentViewController

- (NSMutableArray *)dataMutArr{
    
    if (!_dataMutArr) {
        _dataMutArr = [NSMutableArray array];
    }
    return _dataMutArr;
}

- (NSMutableSet *)deleteMutSet{
    
    if (!_deleteMutSet) {
        _deleteMutSet = [NSMutableSet set];
    }
    return _deleteMutSet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self contentInsetAdjustment];
    
    self.tableView.tableFooterView = [UIView new];
//    self.tableView.estimatedRowHeight = 50.f;
//    self.tableView.allowsMultipleSelectionDuringEditing = YES; //代码或xib配置
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Check" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化
        NSError *err;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (!err) {
            NSArray *dataArr = [NSArray yy_modelArrayWithClass:[CheckModel class] json:json];
            localArr = dataArr;
            [self.dataMutArr addObjectsFromArray:dataArr];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataMutArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        });
    });
}

- (void)resetState{
    
    editBtn.selected = NO;
    self.tableView.editing = NO;
    selectBtn.selected = NO;
}

- (IBAction)dismiss:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addData:(id)sender {
    
    [self resetState];
    
    [self.dataMutArr addObject:[localArr[arc4random()%localArr.count] copy]];
    [self.tableView reloadData];

    //延时防止跳动(效果一般)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataMutArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
    
    //效果更不好
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self scrollToBottom:YES];
//    });
}

- (void)scrollToBottom:(BOOL)animated{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    
    if (self.tableView.editing) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            //全选
            [self.dataMutArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.deleteMutSet addObject:obj];
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }];
        }else {
            //反选
            [self.deleteMutSet removeAllObjects];
            [self.dataMutArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:YES];
            }];
        }
    }
}

- (IBAction)deleteClick:(id)sender {
    
    [self.dataMutArr removeObjectsInArray:self.deleteMutSet.allObjects];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetState];
        if (self.dataMutArr.count) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    });
}

- (IBAction)editBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.tableView.editing = sender.selected;
    
    selectBtn.selected = NO;
    //清空delete集合
    [self.deleteMutSet removeAllObjects];
}

#pragma mark -- tableView method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataMutArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(SelectTableViewCell *cell) {
        cell.model = self.dataMutArr[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.editing) {
        
        [self.deleteMutSet addObject:self.dataMutArr[indexPath.row]];
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.editing) {
        [self.deleteMutSet removeObject:self.dataMutArr[indexPath.row]];
    }
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
