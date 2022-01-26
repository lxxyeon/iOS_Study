//
//  NFCViewController.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/01/26.
//

#import "NFCViewController.h"

@interface NFCViewController ()<NFCTagReaderSessionDelegate, NFCNDEFReaderSessionDelegate>

@property (nonatomic, strong) NFCTagReaderSession *tagSession NS_AVAILABLE_IOS(13.0);
@property (strong, nonatomic) NFCNDEFReaderSession *ndefSession NS_AVAILABLE_IOS(11.0);

@end

@implementation NFCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
