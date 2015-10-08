//
//  DetailViewController.m
//  FM
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 YT. All rights reserved.
//

#import "DetailViewController.h"
#import "Networking.h"
#import "DetailModel.h"
#import "DetailCell.h"
#define URL @"http://mobile.ximalaya.com/m/explore_album_list?category_name=radio&condition=hot&device=iPhone&page=1&per_page=20&status=0&tag_name=%@"
#define Recent_URL @"http://mobile.ximalaya.com/m/explore_album_list?category_name=radio&condition=recent&device=iPhone&page=1&per_page=20&status=0&tag_name=%@"
#define Classic_URL @"http://mobile.ximalaya.com/m/explore_album_list?category_name=radio&condition=classic&device=iPhone&page=1&per_page=20&status=0&tag_name=%@"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UISegmentedControl *Segment;


@property(nonatomic , strong) NSMutableArray *Array;

@property(nonatomic , strong) NSMutableDictionary *DIC;

@property(nonatomic , strong) UITableView *tab;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _name;
    //导航栏size
    CGRect rectNav = self.navigationController.navigationBar.frame;
    self.view.backgroundColor = [ UIColor grayColor];
    _Segment = [[UISegmentedControl alloc]initWithItems:@[@"最火",@"最近更新",@"经典"]];
    _Segment.selectedSegmentIndex = 0;
    _Segment.frame = CGRectMake(0, rectNav.size.height + 20, self.view.frame.size.width, 30);
    _Segment.backgroundColor = [UIColor whiteColor];
    _Segment.tintColor = [UIColor orangeColor];
    [_Segment addTarget:self action:@selector(Action:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_Segment];
   
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, _Segment.frame.origin.y + _Segment.frame.size.height,self.view.frame.size.width,self.view.frame.size.height - _Segment.frame.size.height - 49-rectNav.size.height - 20) style:UITableViewStyleGrouped];
    _tab.backgroundColor = [UIColor whiteColor];
    _tab.dataSource = self;
    _tab.delegate = self;
    [_tab registerClass:[DetailCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tab];

    
    [self networking];
    
}

-(void)Action:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        [_Array removeAllObjects];
        [_DIC removeAllObjects];
        NSString *str = [_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [Networking recivedDataWithURLString:[NSString stringWithFormat:URL,str] method:@"GET" body:nil block:^(id object) {
            NSDictionary *DataDic = (NSDictionary *)object;
            for (NSDictionary *dd in DataDic[@"list"]) {
                DetailModel *model = [DetailModel new];
                model.title = dd[@"title"];
                model.picUrl = dd[@"albumCoverUrl290"];
                model.number = dd[@"playsCounts"];
                [_Array addObject:model];
                [_DIC setObject:_Array forKey:DataDic[@"list"]];
            }
            [_tab reloadData];
        }];
    }else if (sender.selectedSegmentIndex == 1){
        [_Array removeAllObjects];
        [_DIC removeAllObjects];
        NSString *str = [_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [Networking recivedDataWithURLString:[NSString stringWithFormat:Recent_URL,str] method:@"GET" body:nil block:^(id object) {
            NSDictionary *DataDic = (NSDictionary *)object;
            for (NSDictionary *dd in DataDic[@"list"]) {
                DetailModel *model = [DetailModel new];
                model.title = dd[@"title"];
                model.picUrl = dd[@"albumCoverUrl290"];
                model.number = dd[@"playsCounts"];
                [_Array addObject:model];
                [_DIC setObject:_Array forKey:DataDic[@"list"]];
            }
            [_tab reloadData];
        }];
    } else{
        [_Array removeAllObjects];
        [_DIC removeAllObjects];
        NSString *str = [_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Networking recivedDataWithURLString:[NSString stringWithFormat:Classic_URL,str] method:@"GET" body:nil block:^(id object) {
        NSDictionary *DataDic = (NSDictionary *)object;
        for (NSDictionary *dd in DataDic[@"list"]) {
            DetailModel *model = [DetailModel new];
            model.title = dd[@"title"];
            model.picUrl = dd[@"albumCoverUrl290"];
            model.number = dd[@"playsCounts"];
            [_Array addObject:model];
            [_DIC setObject:_Array forKey:DataDic[@"list"]];
            
        }
        
        [_tab reloadData];
    }];
}
}

-(void)networking{
    _DIC = [NSMutableDictionary new];
    _Array = [NSMutableArray new];
    NSString *str = [_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Networking recivedDataWithURLString:[NSString stringWithFormat:URL,str] method:@"GET" body:nil block:^(id object) {
        NSDictionary *DataDic = (NSDictionary *)object;
        for (NSDictionary *dd in DataDic[@"list"]) {
            DetailModel *model = [DetailModel new];
            model.title = dd[@"title"];
            model.picUrl = dd[@"albumCoverUrl290"];
            model.number = dd[@"playsCounts"];
            [_Array addObject:model];
           // [_DIC setObject:model forKey:dd[@"id"]];
            [_DIC setObject:_Array forKey:DataDic[@"list"]];
           
        }
        
         [_tab reloadData];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _DIC.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *key = self.DIC.allKeys[indexPath.section];
   NSArray *arr =self.DIC[key];
   DetailModel *model = arr[indexPath.row];
    //DetailModel *model = self.DIC[key];
    cell.Detail = model;
    return cell;
}

@end
