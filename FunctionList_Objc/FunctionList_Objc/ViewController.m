//
//  ViewController.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2021/08/10.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _modelLabel.text = deviceModelName();
}

// 현재 디바이스 모델 세팅.
NSString *deviceModelName(void) {
    // For Simulator
    NSString *modelName = NSProcessInfo.processInfo.environment[@"SIMULATOR_DEVICE_NAME"];
    if (modelName.length > 0) {
        return modelName;
    }

    // For real devices and simulators, except simulators running on iOS 8.x
    UIDevice *device = [UIDevice currentDevice];
    NSString *selName = [NSString stringWithFormat:@"_%@ForKey:", @"deviceInfo"];
    SEL selector = NSSelectorFromString(selName);
    if ([device respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        modelName = [device performSelector:selector withObject:@"marketing-name"];
#pragma clang diagnostic pop
    }
    return modelName;
}

@end
