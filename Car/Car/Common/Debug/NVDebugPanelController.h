//
//  NVDebugPanelController.h
//  Aroundme
//
//  Created by W Sheely on 13-1-5.
//  Copyright (c) 2013年 dianping.com. All rights reserved.
//

@interface NVDebugPanelController : SHViewController<UITextFieldDelegate,UITextViewDelegate>
{
    @private
    BOOL mShow;
    __unsafe_unretained IBOutlet UITextField *mTextField;
    __unsafe_unretained IBOutlet UITextView *mTextConsole;
  
}

@property (nonatomic,assign) BOOL activation;

+ (NVDebugPanelController*)instance;

- (void)show;
//- (void)dismiss;
- (void)addLog:(NSString*) logStr;
//@property (nonatomic,assign) BOOL isShow;
//@property (nonatomic,assign) BOOL isPerspective;
@end
