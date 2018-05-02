//
//  CycleViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CycleViewController.h"

#import <SDCycleScrollView.h>
#import <UIImageView+WebCache.h>
#import "CustomCycleCollectionCell.h"

@interface CycleViewController ()<SDCycleScrollViewDelegate>{
    NSArray *_imagesLocalStrings,*_imagesURLStrings;
    NSArray *_txtStrings;
}

@property (weak, nonatomic) IBOutlet SDCycleScrollView *urlImgBanner; //默认图片轮播
@property (weak, nonatomic) IBOutlet SDCycleScrollView *customImgBanner; //自定义cell图片轮播
@property (weak, nonatomic) IBOutlet SDCycleScrollView *txtBanner; //默认文字轮播
@property (weak, nonatomic) IBOutlet SDCycleScrollView *customTxtBanner; //自定义cell文字轮播

@end

@implementation CycleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //采用本地图片实现
    NSArray *imageNames = @[
                            @"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            @"h5" // 本地图片请填写全名
                            ];
    _imagesLocalStrings = imageNames;
    
    //采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    _imagesURLStrings = imagesURLStrings;
    
    _txtStrings = @[@"自定义文字轮播更灵活\n这是第二行",
                    @"这是第一条广告\n广告详情",
                    @"这是第二条广告\n广告详情"];
    
    [self banner1Set];
    [self banner2Set];
    [self banner3Set];
    [self banner4Set];
    // Do any additional setup after loading the view.
}

- (void)banner1Set {
    _urlImgBanner.autoScroll = NO;
    _urlImgBanner.localizationImageNamesGroup = _imagesLocalStrings;
//    _urlImgBanner.imageURLStringsGroup = _imagesURLStrings;
    _urlImgBanner.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _urlImgBanner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}

- (void)banner2Set {
    _customImgBanner.delegate = self;
    _customImgBanner.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
    _customImgBanner.scrollDirection = UICollectionViewScrollDirectionVertical;
    _customImgBanner.imageURLStringsGroup = @[@"1", @"2", @"3"];
//    _customImgBanner.showPageControl = NO;
    _customImgBanner.pageDotImage = [UIImage imageNamed:@"time_normal"];
    _customImgBanner.currentPageDotImage = [UIImage imageNamed:@"time_seleted"];
    _customImgBanner.pageControlBottomOffset = -30;
}

- (void)banner3Set {
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    _txtBanner.scrollDirection = UICollectionViewScrollDirectionVertical;
    _txtBanner.onlyDisplayText = YES;
    _txtBanner.titleLabelBackgroundColor = [UIColor whiteColor];
    _txtBanner.titleLabelTextFont = [UIFont boldSystemFontOfSize:13.5f];
    _txtBanner.titleLabelTextColor = [UIColor redColor];
    NSArray *title = @[@"纯文字上下滚动轮播", @"第一条广告", @"第二条广告", @"第三条广告"];
    _txtBanner.titlesGroup = [title copy];
    [_txtBanner disableScrollGesture];
    
    WeakSelf(self);
    _txtBanner.clickItemOperationBlock = ^(NSInteger currentIndex) {
        StrongSelf(self);
        NSString *titleStr = [title[currentIndex] copy];
        NSLog(@" --- %@ --- ",titleStr);
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = titleStr;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (void)banner4Set {
    _customTxtBanner.delegate = self;
    _customTxtBanner.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.6f];
    _customTxtBanner.scrollDirection = UICollectionViewScrollDirectionVertical;
    _customTxtBanner.onlyDisplayText = YES;
    _customTxtBanner.titlesGroup = @[@"1", @"2", @"3"];
    [_customTxtBanner disableScrollGesture];
}

#pragma mark <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    if (view == _customImgBanner) {
        return [CustomCycleCollectionCell class];
    }
    
    if (view == _customTxtBanner) {
        return [CustomTextCollectionCell class];
    }
    return nil;
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    if (view == _customImgBanner) {
        CustomCycleCollectionCell *customCell = (CustomCycleCollectionCell *)cell;
        [customCell.imgView sd_setImageWithURL:[NSURL URLWithString:_imagesURLStrings[index]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        NSString *txtStr = [NSString stringWithFormat:@"第%ld行",(long)index + 1];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[txtStr stringByAppendingFormat:@"\n第%ld条数据",(long)index + 1]];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.alignment = NSTextAlignmentLeft;
        [paragraphStyle setLineSpacing:2.5f];//调整行间距
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr.string length])];
        
        //设置字体大小
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(0, txtStr.length)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(txtStr.length, attrStr.string.length - txtStr.length)];
        //设置字体颜色
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, txtStr.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(txtStr.length, attrStr.string.length - txtStr.length)];
        
        customCell.titleLabel.attributedText = attrStr;
    }else if (view == _customTxtBanner) {
        CustomTextCollectionCell *customCell = (CustomTextCollectionCell *)cell;
        customCell.textLabel.text = _txtStrings[index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc");
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
