//
//  SHLocationViewController.m
//  Car
//
//  Created by WSheely on 14/10/23.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHLocationViewController.h"

@interface SHLocationViewController ()
{
    BMKPoiSearch * _searcher;
    NSArray *mList;
}
@end

@implementation SHLocationViewController


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
-(void)viewDidLoad
{
    //初始化检索对象
    self.title = @"地址检索";
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    //发起检索

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        mList = poiResultList.poiInfoList;
        [self.tableview reloadData];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        [self showAlertDialog:@"起始点有歧义."];
    } else {
        [self showAlertDialog:@"抱歉,未找到结果."];
    }
    [self dismissWaitDialog];
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo * poi = [mList objectAtIndex:indexPath.row];
    SHTableViewTitleContentCell * cell = [tableView dequeueReusableTitleContentCell];
    cell.labTitle.text = poi.name;
    cell.labContent.text = poi.address;
    return cell;
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    if(searchBar.text.length > 0){
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
        option.pageIndex = 0;
        option.pageCapacity = 50;
        option.location = [SHLocationManager instance].userlocation.location.coordinate;
        option.keyword = searchBar.text;
        [self showWaitDialogForNetWork];
        [_searcher poiSearchNearBy:option];
        [searchBar resignFirstResponder];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];

}
// called when cancel button pressed

@end
