//
//  ViewController.m
//  HeadBecomesLarge
//
//  Created by Abel on 16/9/6.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "ViewController.h"


#define APP_HEIGHYREAL [ UIScreen mainScreen ].bounds.size.height
#define APP_WIDTHYREAL [ UIScreen mainScreen ].bounds.size.width

#define kHeadHeight  64.0f

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_stretchingView;
}
@property (nonatomic) UITableView *tableView;

@end

@implementation ViewController


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     *  关键处理：通过滚动视图获取到滚动偏移量从而去改变图片的变化
     */
    //获取滚动视图y值的偏移量
//    scrollView.backgroundColor = DefaultColor;
    CGFloat yOffset  = scrollView.contentOffset.y;
    //    DebugLog(@"%f",yOffset);
    CGFloat xOffset = (yOffset +kHeadHeight)/2;
    if(yOffset < -kHeadHeight) {
        CGRect f =_stretchingView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        f.origin.x= xOffset;
        //int abs(int i); // 处理int类型的取绝对值
        //double fabs(double i); //处理double类型的取绝对值
        //float fabsf(float i); //处理float类型的取绝对值
        f.size.width=APP_WIDTHYREAL + fabs(xOffset)*2;
        _stretchingView.frame= f;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];
}

#pragma mark createTableView
- (void)createTableView
{
    _stretchingView = [[UIView alloc] initWithFrame:CGRectMake(0, -kHeadHeight, self.view.frame.size.width, kHeadHeight)];
    _stretchingView.backgroundColor = [UIColor redColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
//    _tableView.tableHeaderView = _stretchingView;
    [_tableView addSubview:_stretchingView];
    _tableView.contentOffset = CGPointMake(0, -kHeadHeight);
     _tableView.contentInset=UIEdgeInsetsMake(kHeadHeight,0,0,0);
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableCell"];
    }
    for(UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    UIView *view = [self createCellView:nil and:indexPath];
    [cell.contentView addSubview:view];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIView *)createCellView:(NSDictionary *)dic and:(NSIndexPath *)index
{
    CGFloat height = 50;
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTHYREAL, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [cellView addSubview:line1];
    
    return cellView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
