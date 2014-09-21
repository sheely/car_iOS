//
//  NVTableHorizontalView.h
//  Sheely
//
//  Created by sheely on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "SHView.h"
//选中列位置
typedef enum {
    SHTableHorizontalViewScrollPositionNone,        
    SHTableHorizontalViewScrollPositionLeft,    
    SHTableHorizontalViewScrollPositionMiddle,   
    SHTableHorizontalViewScrollPositionRight
} SHTableHorizontalViewScrollPosition;    

@class SHTableHorizontalView;
//单元格
@interface SHTableHorizontalViewCell : SHView
{ 
   //nothing
}
//@property (retain,nonatomic)UIImage* image
@property (nonatomic,strong)NSIndexPath *index;
@property (nonatomic,copy)  NSString* identifier;
@property (nonatomic,assign) BOOL selected;
-(id)initWithReuseIdentifier:(NSString *)identifier;
@end


//数据集合
@protocol SHTableHorizontalViewDataSource<NSObject>
@required
//表单有几个Column
- (NSInteger)tableView:(SHTableHorizontalView *)tableView numberOfColumnInSection:(NSInteger)section;
//具体的列
- (SHTableHorizontalViewCell *)tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath;
@optional

//- (NSString *)tableView:(NVTableHorizontalView *)tableView titleForHeaderInSection:(NSInteger)section;   
//- (NSString *)tableView:(NVTableHorizontalView *)tableView titleForFooterInSection:(NSInteger)section;
@end



//委托
@protocol SHTableHorizontalViewDelegate<UIScrollViewDelegate>
//获取列宽度，适用于非恒定宽度列
@optional
- (CGFloat)tableView:(SHTableHorizontalView *)tableView widthForColumnAtIndexPath:(NSIndexPath *)indexPath;
//即将选中列
- (NSIndexPath *)tableView:(SHTableHorizontalView *)tableView willSelectColumnAtIndexPath:(NSIndexPath *)indexPath;
//选中列
- (void)tableView:(SHTableHorizontalView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath;
//取消列
- (void)tableView:(SHTableHorizontalView *)tableView didDeSelectColumnAtIndexPath:(NSIndexPath *)indexPath;
//列切换时发出的消息
//滚动到底部时发出的消息
- (void)scrollViewDidScrollToEnd:(SHTableHorizontalView *)scrollView; 
@end

//类
@interface SHTableHorizontalView : UIScrollView<UIScrollViewDelegate>
{
    //@private NSArray* _
@private 
    NSMutableArray* _showViewArray;
    NSMutableArray* _unShowViewArray;
    __unsafe_unretained id<SHTableHorizontalViewDelegate> _newdelegate;
//@private BOOL _autoColumnWidth;
}
@property (assign,nonatomic) CGFloat columnWidth;
@property (nonatomic, unsafe_unretained)id<SHTableHorizontalViewDataSource>datasource;
@property (nonatomic, unsafe_unretained)id<SHTableHorizontalViewDelegate>delegate;
@property (retain,nonatomic) NSIndexPath* selectedIndex;
//装载
-(void)reloadData; 

//清空
- (void)clear;

-(NSIndexPath*)indexPathForSelectedColumn;
//获取cell(bomb:cell仅仅能返回正在显示区域中的indexpath)
-(SHTableHorizontalViewCell *)cellForColumnAtIndexPath:(NSIndexPath *)indexPath;
//获得流转池里cell
-(SHTableHorizontalViewCell* )dequeueReusableCellWithIdentifier:(NSString *)identifier; 
//-(void)reloadRowsAtIndexPath:(NSIndexPath*) indexPath;
//选中某列，区别于selectedIndex在于本消息会跳转到移动到相关行
- (void)selectColumnAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(SHTableHorizontalViewScrollPosition)scrollPosition;
- (NSArray*)visibleCells;
@end
