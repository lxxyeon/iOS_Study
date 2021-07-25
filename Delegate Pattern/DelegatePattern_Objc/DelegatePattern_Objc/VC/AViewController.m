//
//  ViewController.m
//  DelegatePattern_Objc
//
//  Created by leeyeon2 on 2021/07/25.
//

#import "AViewController.h"
#import "BViewController.h"
//2. 델리게이트 채택
@interface AViewController () <BViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *messageFromBVCLabel;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showBVC:(id)sender {
    BViewController *bVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BViewController"];
    //3. 위임자 설정!!
    //object.delegate = self
    bVC.delegate = self;
    bVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:bVC animated:YES completion:nil];
}

// 델리게이트 메소드 
-(void)sendMessage:(NSString*)message{
    _messageFromBVCLabel.text = message;
}


@end
