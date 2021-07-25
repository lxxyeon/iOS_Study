//
//  BViewController.m
//  DelegatePattern_Objc
//
//  Created by leeyeon2 on 2021/07/25.
//

#import "BViewController.h"

@interface BViewController ()
@property (weak, nonatomic) IBOutlet UILabel *messageField;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)dismissBVC:(id)sender {
    //3. 델리게이트 메소드 호출
    [self.delegate sendMessage: _messageField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
