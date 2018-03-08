//
//  PushViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/7.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "PushViewController.h"

#import "CheckTableViewCell.h"

@interface PushViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *localArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataMutArr;

@end

static NSString *const cellId = @"CheckCellIdentifer";

@implementation PushViewController

- (NSMutableArray *)dataMutArr{
    
    if (!_dataMutArr) {
        _dataMutArr = [NSMutableArray array];
    }
    return _dataMutArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self contentInsetAdjustment];
    
    self.tableView.tableFooterView = [UIView new];
//    self.tableView.estimatedRowHeight = 50.f;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CheckTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    
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
            /*
            localArr = [dataArr copy]; //数组内的元素地址不会改变 只是数组的内存地址不同罢了（mutableCopy也一样）
            [self.dataMutArr addObjectsFromArray:[dataArr copy]]; //同理
            NSLog(@"local:%@\n-------\ndata:%@\n------\nsource:%@",localArr,dataArr,self.dataMutArr);
             */
            
            //两种解决方法
            //一：遍历添加
//            localArr = dataArr;
//            [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [self.dataMutArr addObject:[obj copy]];
//            }];
            
            //二: - (instancetype)initWithArray:(NSArray<ObjectType> *)array copyItems:(BOOL)flag
            localArr = dataArr;
            [self.dataMutArr addObjectsFromArray:[[NSArray alloc] initWithArray:dataArr copyItems:YES]];
            
//            NSLog(@"local:%@\n-------\ndata:%@\n------\nsource:%@",localArr,dataArr,self.dataMutArr);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    // Do any additional setup after loading the view.
}

- (IBAction)addData:(id)sender {
    
    [self.dataMutArr addObject:[localArr[arc4random()%localArr.count] copy]];
    [self.tableView reloadData];
}

- (IBAction)logSelectedData:(id)sender {
    
    NSMutableString *selectStr = [NSMutableString stringWithString:@"您选中了第："];
    NSMutableArray *idxArr = [NSMutableArray array];
    [self.dataMutArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CheckModel *model = obj;
        if (model.checkStatus) {
            [idxArr addObject:@(idx+1)];
        }
    }];
    
    [selectStr appendFormat:@"%@行",[idxArr componentsJoinedByString:@"、"]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:selectStr preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- tableView method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath]; //如果不存在会自动创建cell（前提tableview要注册cell）
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataMutArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(CheckTableViewCell *cell) {
        cell.model = self.dataMutArr[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CheckModel *model = self.dataMutArr[indexPath.row];
    model.checkStatus = !model.checkStatus;
    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
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
