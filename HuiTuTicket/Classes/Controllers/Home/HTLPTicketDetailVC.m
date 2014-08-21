//
//  HTLPTicketDetailVC.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLPTicketDetailVC.h"
#import "HTLPTicketDetailCell.h"
#import "TicketDetailHttp.h"
#import "TicketScenicSpotListHttp.h"
#import "TicketScenicSpot.h"
#import "HTLPSceneTableViewCell.h"

#define ARRAY1  @[@"产品名称",@"注册截止",@"有效期",@"使用截止",@"景区数量",@"合作单位"]

@interface HTLPTicketDetailVC ()

@property (weak, nonatomic) IBOutlet UIView *switchView;

@property (strong, nonatomic) IBOutlet UIView *filterTableHead;

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *sceneBtn;
@property (strong, nonatomic) TicketDetailHttp *detailHttp;
@property (strong, nonatomic) UIImageView *iv;
@property (strong, nonatomic) TicketScenicSpotListHttp *ticketScenicSpotListHttp;


- (IBAction)switchDetailAction:(id)sender;
- (IBAction)switchsceneAction:(id)sender;

@end

@implementation HTLPTicketDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _detailHttp = [[TicketDetailHttp alloc] init];
        _ticketScenicSpotListHttp = [[TicketScenicSpotListHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.switchView.layer.cornerRadius = 5;
    self.switchView.clipsToBounds = YES;
    self.switchView.layer.borderColor = [kSwitchBorderColor CGColor];
    self.switchView.layer.borderWidth = 1;
    self.filterTableHead.layer.borderWidth = 1;
    self.filterTableHead.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.detailBtn.selected = YES;
    [self.detailBtn setBackgroundColor:kSwitchBorderColor];
    
    self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y+50, 320, self.tableView.frame.size.height-50);
    self.iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 124)];
    self.tableView.tableHeaderView = _iv;
    [self requestDetailData];
    [self requestSceneListData];
}

- (void)requestDetailData
{
    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTLPTicketDetailVC *weak_self = self;
    self.detailHttp.parameter.typeid = self.ticket.typeId;
    [self.detailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.detailHttp.isValid) {

            [weak_self.tableView reloadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.detailHttp.erorMessage];
        };
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect]) {
            [weak_self showErrorWithText:kNETWORK_ERROR];
        }
        else {
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
    
}

- (void)requestSceneListData
{
    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTLPTicketDetailVC *weak_self = self;
    
    self.ticketScenicSpotListHttp.parameter.typeid = self.ticket.typeId;
    
    [self.ticketScenicSpotListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.ticketScenicSpotListHttp.isValid) {
            [weak_self showWithText:@"详情景区list请求成功"];
            [weak_self.tableView reloadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.ticketScenicSpotListHttp.erorMessage];
        };
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect]) {
            [weak_self showErrorWithText:kNETWORK_ERROR];
        }
        else {
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.detailBtn.selected)
        return [ARRAY1 count];
    else
        return [self.ticketScenicSpotListHttp.resultModel.info count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.detailBtn.selected)
    {
        return 44;
    }
    else
    {
        return 71;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    if (self.detailBtn.selected)
    {
        HTLPTicketDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HTLPTicketDetailCell" owner:self options:nil] lastObject];
        }
        cell.label.text = [ARRAY1 objectAtIndex:indexPath.row];
        [self.iv setImageWithURL:[NSURL URLWithString:self.detailHttp.resultModel.picurl]];

        switch (indexPath.row)
        {
            case 0:
                cell.label2.text = self.detailHttp.resultModel.lpName;
                break;
            case 1:
                cell.label2.text = self.detailHttp.resultModel.reg_endtime;
                break;
            case 2:
                cell.label2.text = [NSString stringWithFormat:@"%@个月",self.detailHttp.resultModel.validitytime];
                break;
            case 3:
                cell.label2.text = self.detailHttp.resultModel.use_endtime;
                break;
            case 4:
                cell.label2.text =  [NSString stringWithFormat:@"%@家",self.detailHttp.resultModel.scenic_num];
                cell.arrowIV.hidden = NO;
                break;
            case 5:
                cell.label2.text = self.detailHttp.resultModel.lpName;
                break;
            case 6:
                cell.label2.text = self.detailHttp.resultModel.company;
                break;
                
            default:
                break;
        }
        return cell;
    }
    else
    {
        HTLPSceneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTLPSceneTableViewCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[HTLPSceneTableViewCell class]])
                {
                    cell = (HTLPSceneTableViewCell *)oneObject;
                }
            }
        }
        TicketScenicSpot *model = [self.ticketScenicSpotListHttp.resultModel.info objectAtIndex:indexPath.row];
        [cell.iv setImageWithURL:[NSURL URLWithString:model.picture]];
        cell.nameLabel.text = model.scenicName;
        cell.timeLimit.text = [model.timelimit intValue]?@"不限时":@"限时浏览";
        cell.addressLB.text = model.address;
        NSArray *array = [NSArray arrayWithObjects:@"A",@"AA",@"AAA",@"AAAA",@"AAAAA",nil];
        cell.levelLB.text = [model.rank isEqualToString:@"0"]?@"":[array objectAtIndex:[model.rank intValue]-1];
        cell.priceLB.text = model.price;
        cell.flagLB.text = [model.ptype intValue]?@"免票":@"优惠";
        return cell;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.detailBtn.selected)
    {
        if (indexPath.row==4)
        {
            
        }
    }
    else
    {
        
    }
}

- (IBAction)switchDetailAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    [btn setBackgroundColor:kSwitchBorderColor];
    [self.sceneBtn setBackgroundColor:kColorWhite];
    self.sceneBtn.selected = NO;
    self.tableView.tableHeaderView = _iv;
    [self.tableView reloadData];
}

- (IBAction)switchsceneAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    [btn setBackgroundColor:kSwitchBorderColor];
    [self.detailBtn setBackgroundColor:kColorWhite];
    self.detailBtn.selected = NO;
    self.tableView.tableHeaderView = self.filterTableHead;
    [self.tableView reloadData];
}
@end
