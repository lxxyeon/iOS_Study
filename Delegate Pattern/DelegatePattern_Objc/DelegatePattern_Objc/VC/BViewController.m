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
    
    //respondsToSelector 사용하여 crash 방지
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendMessage:)]) {
        [self.delegate sendMessage: _messageField.text];
    }
    
    
    NSString *tmp_str = @"test";
//    NSInteger tmp_int = 123
    if ([tmp_str isKindOfClass:[NSString class]]) {
//        NSLog(@"tmp type is %@ and value is %@", [tmp_str class], tmp_str);
//    } else if ([tmp_str isKindOfClass:[NSInteger class]])  {
//        NSLog(@"tmp type is %@ and value is %d", [tmp_str class], tmp_str);
    }

    NSLog(@"class type : %@", [tmp_str class]);
    NSLog(@"class type : %@", [_messageField.text class]);
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
