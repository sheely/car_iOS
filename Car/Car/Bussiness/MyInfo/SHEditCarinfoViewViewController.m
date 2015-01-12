//
//  SHEditCarinfoViewViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/9/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHEditCarinfoViewViewController.h"

@interface SHEditCarinfoViewViewController ()

@end

@implementation SHEditCarinfoViewViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"view_editcar"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"view_editcar"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self.intent.args valueForKey:@"carinfo"] == nil){
        self.title = @"添加车辆";
        self.carinfo = [[NSMutableDictionary alloc]init];
        self.btnDelete.hidden = YES;
    }else {
        self.title = @"修改车辆";
        self.carinfo = [self.intent.args valueForKey:@"carinfo"];
        [self.btnCategary setTitle:[self.carinfo  valueForKey:@"carcategoryname"] forState:UIControlStateNormal];
        [self.btnLetters setTitle:[self.carinfo valueForKey:@"alphabetname"] forState:UIControlStateNormal];
        [self.btnProvince setTitle:[self.carinfo valueForKey:@"provincename"] forState:UIControlStateNormal];
        self.txtField.text =  [self.carinfo valueForKey:@"carcardno"];
        [self.btnSubCategary setTitle:[self.carinfo valueForKey:@"carseriesname"] forState:UIControlStateNormal];

    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnSubmit.layer.masksToBounds = YES;
    self.btnSubmit.layer.cornerRadius = 5;
    self.btnDelete.layer.masksToBounds = YES;
    self.btnDelete.layer.cornerRadius = 5;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCategaryOnTouch:(id)sender {
    
    SHIntent * i = [[SHIntent alloc]init:@"categarylist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:i];
}

- (IBAction)btnSubCategaryOnTouch:(id)sender {
    if([self.carinfo valueForKey:@"carcategoryid"] != nil){
        
        SHIntent * i = [[SHIntent alloc]init:@"subcategarylist" delegate:self containner:self.navigationController];
        [i.args setValue:[self.carinfo valueForKey:@"carcategoryid"] forKey:@"carcategoryid"];
        [[UIApplication sharedApplication]open:i];
    }
    else{
        [self showAlertDialog:@"请先选择车系"];
    }
    
    
}

- (void)categarySubmit:(NSDictionary*)dic
{
    [self.carinfo setValue:[dic valueForKey:@"carcategoryid"] forKey:@"carcategoryid"];
    [self.btnCategary setTitle:[dic valueForKey:@"carcategoryname"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)subCategarySubmit:(NSDictionary*)dic
{
    [self.carinfo setValue:[dic valueForKey:@"carseriesidid"] forKey:@"carseriesid"];
    [self.btnSubCategary setTitle:[dic valueForKey:@"carseriesidname"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)provinceSubmit:(NSDictionary*)dic
{
    [self.carinfo setValue:[dic valueForKey:@"provinceid"] forKey:@"provinceid"];
    [self.btnProvince setTitle:[dic valueForKey:@"provincename"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)letterSubmit:(NSString *)dic
{
    [self.carinfo setValue:dic forKey:@"alphabetname"];
    [self.btnLetters setTitle:dic forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnProvinceOnTouch:(id)sender {
    
    SHIntent * i = [[SHIntent alloc]init:@"provincelist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:i];
}
- (IBAction)btnLettersOnTouch:(id)sender {
    SHIntent * i = [[SHIntent alloc]init:@"letterslist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:i];

}

- (IBAction)btnSubmitOnTouch:(id)sender
{
    if([[self.carinfo valueForKey:@"carcategoryid"] length] == 0){
        
        [self showAlertDialog:@"请选择车型"];
        return;
    }else if([[self.carinfo valueForKey:@"carseriesid"] length] == 0){
        
        [self showAlertDialog:@"请选择车系"];
        return;
    }else if([[self.carinfo valueForKey:@"provinceid"] length] == 0){
        
        [self showAlertDialog:@"请选择省份"];
        return;
    }else if([[self.carinfo valueForKey:@"alphabetname"] length] == 0){
        
        [self showAlertDialog:@"请选择城市代码"];
        return;
    }else if([self.txtField.text length] == 0){
        
        [self showAlertDialog:@"请输入车牌号码"];
        return;
    }
    
    
    SHPostTaskM * p = [[SHPostTaskM alloc]init];
    [self showWaitDialogForNetWork];
    p.URL = URL_FOR(@"mycarmaintanance.action");
    [p.postArgs setValuesForKeysWithDictionary:self.carinfo];
    if([[self.carinfo valueForKey:@"carid"] length] > 0){
        [p.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"optype"];
        [p.postArgs setValue:[self.carinfo valueForKey:@"carid"] forKey:@"carid"];
    }else{
        [p.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"optype"];
        [p.postArgs setValue:@"" forKey:@"carid"];
    }
    [p.postArgs setValue:self.txtField.text forKey:@"carcardno"];

    [p start:^(SHTask *t) {
        [self dismissWaitDialog];
        if([self.delegate respondsToSelector:@selector(editcarinfosubmit:)]){
            [(id<SHEditCarinfoViewViewControllerDelegate> )self.delegate editcarinfosubmit:self ];
        }
        [t.respinfo show];

    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
        
        [t.respinfo show];
    }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder ];
    return YES;
}
// called when 'return' key pressed. return NO to ignore.


- (IBAction)btnDeleteOnTouch:(id)sender {
//    [self showAlertDialog: [NSString stringWithFormat:@"确认删除您的[%@]牌汽车？",[self.carinfo  valueForKey:@"carcategoryname"]]];
//    
    [self showAlertDialog:[NSString stringWithFormat:@"确认删除您的[%@]牌汽车？",[self.carinfo  valueForKey:@"carcategoryname"]] otherButton:@"取消"];
}

- (void)alertViewEnSureOnClick
{
    SHPostTaskM * p = [[SHPostTaskM alloc]init];
    [self showWaitDialogForNetWork];
    p.URL = URL_FOR(@"mycarmaintanance.action");
    [p.postArgs setValuesForKeysWithDictionary:self.carinfo];
    if([[self.carinfo valueForKey:@"carid"] length] > 0){
        [p.postArgs setValue:[NSNumber numberWithInt:2] forKey:@"optype"];
        [p.postArgs setValue:[self.carinfo valueForKey:@"carid"] forKey:@"carid"];
    }
    [p.postArgs setValue:self.txtField.text forKey:@"carcardno"];
    
    [p start:^(SHTask *t) {
        [self dismissWaitDialog];
        if([self.delegate respondsToSelector:@selector(editcarinfosubmit:)]){
            [(id<SHEditCarinfoViewViewControllerDelegate> )self.delegate editcarinfosubmit:self ];
        }
        [t.respinfo show];
        
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
        
        [t.respinfo show];
    }];
    

}

@end
