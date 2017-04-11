//
//  AchievementViewController.m
//  HLDriver
//
//  Created by Admin on 2017/4/10.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "AAChartView.h"
#import "AchievementViewController.h"

@interface AchievementViewController (){
    UIScrollView *scrollView;
}
@property (weak, nonatomic) IBOutlet UILabel *avgScore;
@property (weak, nonatomic) IBOutlet UILabel *zhunDianLv;
@property (weak, nonatomic) IBOutlet UILabel *juDanLv;
@property (weak, nonatomic) IBOutlet UILabel *xinYong;

@property(nonatomic,strong)AAChartModel *chartModel;
@property(nonatomic,strong)AAChartView *chartView;    
@property (strong, nonatomic)  UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *allIncome;
@property (weak, nonatomic) IBOutlet UILabel *cashIncome;
@property (weak, nonatomic) IBOutlet UILabel *orderIncome;

@end

@implementation AchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(kScreenWidth, 200+220+258);
    [self.view addSubview:scrollView];
    UIView *headerView = [[NSBundle mainBundle]loadNibNamed:@"AchievementHeadView" owner:self options:nil][0];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 258);
    [scrollView addSubview:headerView];
    [self configTheChartView:AAChartTypeLine];
}
-(void)configTheChartView:(NSString *)chartType{
    self.chartView = [[AAChartView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.chartView.frame = CGRectMake(0, 258, kScreenWidth, 220);
    self.chartView.contentHeight = 220;
    [scrollView addSubview:self.chartView];
    
    self.chartModel= AAObject(AAChartModel)
    .titleSet(@"")
    .subtitleSet(@"")
    .chartTypeSet(chartType)
    .categoriesSet(@[@"12月",@"1月",@"2月",@"3月", @"4月"])
    .yAxisLabelsEnabledSet(NO)
    .yAxisTitleSet(@" ")
//    .yAxisGridLineWidthSet([NSNumber numberWithFloat:kScreenWidth/7])
    .gradientColorEnableSet(YES)
    .yAxisTitleSet(@"")
    .colorsThemeSet(@[@"#FA9D1D"])
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 //                 .nameSet(@"2017")
                 .dataSet(@[@1,@56,@34,@43,@65]),
                 ]);
    self.chartModel.dataLabelEnabled=true;
    [self.chartView aa_drawChartWithChartModel:_chartModel];
    
    [scrollView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chartView.mas_bottom);
        make.width.mas_equalTo(scrollView);
        make.height.mas_equalTo(200);
        make.centerX.mas_equalTo(scrollView);
    }];
    
}
-(UIView*)bottomView{
    if(!_bottomView){
        _bottomView = [[NSBundle mainBundle]loadNibNamed:@"AchievementBottomView" owner:self options:nil][0];
    }
    return _bottomView;
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
















-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
