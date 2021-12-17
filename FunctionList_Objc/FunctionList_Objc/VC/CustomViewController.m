//
//  CustomViewController.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2021/12/17.
//

#import "CustomViewController.h"

@interface CustomViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customView];

    // Do any additional setup after loading the view from its nib.
}

- (void)customView{
    //Contraints값이 유지되도록 각 뷰 설정
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    //label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2), (self.view.frame.size.width/2),100,10)];
    [label setText:@"hi there"];
    label.textAlignment = NSTextAlignmentCenter;
    
    //label layout
    label.userInteractionEnabled = NO;
    [self.view addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [label.widthAnchor constraintEqualToAnchor: self.view.widthAnchor multiplier:0.25].active = YES;
    [label.heightAnchor constraintEqualToAnchor: self.view.heightAnchor multiplier:0.25].active = YES;
    [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    

}

@end
