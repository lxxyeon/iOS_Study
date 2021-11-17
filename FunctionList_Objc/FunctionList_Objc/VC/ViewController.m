//
//  ViewController.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2021/08/10.
//

#import "ViewController.h"
#import "BViewController.h"

@interface ViewController () <BViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageFromBVCLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    _modelLabel.text = self.deviceModelName;
    //
    //    //로그 출력
    //    NSLog(@"func : %s", __func__);
    //    NSLog(@"line : %d", __LINE__);
    //    NSLog(@"file : %s", __FILE__);
    //    NSLog(@"file name : %s", __FILE_NAME__);
    //
    //    NSArray<NSString *> *arr = @[@"Sam", @"John", @"Kevin", @"William"];
    //    NSString *arrValue = [arr valueForKey:@"description"];
    //
    //    NSLog(@"array 그냥 출력 : %@", arr);
    //    NSLog(@"array description 출력 : %@", arrValue);
    //
    
    
    
    
    
    //    square = ^(int x){
    //        return x*x;
    //    };
    
    //    [self BlockExam: @"string전송" completeHandler:(void (^)(NSDictionary *result, NSError *error)) {
    //      // JsonRequestHelper.m 의 메소드 처리 후 리턴 값을 받아 올 수 있다.
    //        NSLog(@"array 그냥 출력 : %@")
    //    }];
    
    // block1. 블럭타입의 함수 구현
    // addBlock은 함수 블럭 변수
    // 뒤에 ^(int a, int b)는 블럭 타입의 함수
    int (^addBlock) (int, int) = ^(int a, int b){
        return a + b;
    };
    
    // block2. 블럭 호출
    int add = addBlock(2, 5);
    NSLog(@"계산 합 : %d",add);
    
    [self performActionWithCompletion: ^{
        NSLog(@"Completion is called to intimate action is performed.");
    }];
    
    
    CompleteHandler2 blockTest2 = ^(NSString *result, NSError *error){
        if([error  isEqual: @"E1001"]){
            NSLog(@"문자에러");
        }else if([error  isEqual: @"E1002"]){
            NSLog(@"숫자에러");
        }else{
            NSLog(@"성공");
        }
    };
    
    
    
    
}

-(void)performActionWithCompletion:(CompleteHandler1)completeHandler{
    NSLog(@"Action Performed");
    completeHandler();
}


// 현재 디바이스 모델 세팅.
- (NSString*) deviceModelName {
    // For Simulator
    NSString *modelName = NSProcessInfo.processInfo.environment[@"SIMULATOR_DEVICE_NAME"];
    if (modelName.length > 0) {
        return modelName;
    }
    
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

- (IBAction)showBVC:(id)sender {
    [self doSomething];
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

- (void)doSomething {
    __block int num = 0;
    NSLog(@"num check #1 = %d", num);
    
    void (^testBlock)(void) = ^{
        NSLog(@"num check #3 = %d", num);
    };
    
    testBlock();
    num = 20;
    NSLog(@"num check #2 = %d", num);
    testBlock();
}

@end

