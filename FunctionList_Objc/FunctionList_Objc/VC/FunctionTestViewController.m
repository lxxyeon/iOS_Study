//
//  FunctionTestViewController.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/03/24.
//

#import "FunctionTestViewController.h"
#import <CommonCrypto/CommonDigest.h>
@interface FunctionTestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *sha256Label;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation FunctionTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *test = @"<_NSCallStackArray 0x600003000ab0>( \
     0 CoreFoundation 0x00007fff203feba4 __exceptionPreprocess + 242,\
     1 libobjc.A.dylib 0x00007fff201a1be7 objc_exception_throw + 48,\
     2 CoreFoundation 0x00007fff202ed423 -[__NSArray0 objectEnumerator] + 0,\
     3 HoneSmartUtilSDK 0x00000001102049aa -[HMPWindowManager crashTest] + 58,\
     4 HspEmbed 0x000000010fc6c4d8 __36-[WrapperHelper showWrapperTestList]_block_invoke + 5288,\
     5 HspEmbed 0x000000010fc6dbcb __25-[PopupListView dismiss:]_block_invoke_2 + 171,\
     6 UIKitCore 0x00007fff25610d46 -[UIViewAnimationBlockDelegate\ _didEndBlockAnimation:finished:context:] + 779,\
     7 UIKitCore 0x00007fff255e1711 -[UIViewAnimationState sendDelegateAnimationDidStop:finished:] + 231,\
     8 UIKitCore 0x00007fff255e1cb6 -[UIViewAnimationState animationDidStop:finished:] + 263,\
     9 QuartzCore 0x00007fff289ef380 _ZN2CA5Layer23run_animation_callbacksEPv + 308,\
     10 libdispatch.dylib 0x000000011083ca2c _dispatch_client_callout + 8,\
     11 libdispatch.dylib 0x000000011084b1f1 _dispatch_main_queue_callback_4CF + 1197,\
     12 CoreFoundation 0x00007fff2036c84d __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9,\
     13 CoreFoundation 0x00007fff203670aa __CFRunLoopRun + 2772,\
     14 CoreFoundation 0x00007fff203660f3 CFRunLoopRunSpecific + 567,\
     15 GraphicsServices 0x00007fff2c995cd3 GSEventRunModal + 139,\
     16 UIKitCore 0x00007fff25059f42 -[UIApplication _run] + 928,\
     17 UIKitCore 0x00007fff2505eb5e UIApplicationMain + 101,\
     18 HspEmbed 0x000000010fc6dfc8 main + 104,\
     19 dyld 0x000000010feb1ee9 start_sim + 10,\
     20 ??? 0x000000011d54f4fe 0x0 + 4787074302\
     )";
    
    _inputDataLabel.text = test;
//    NSString *res =
    _sha256Label.text = [self sha256HashForText: test];
//    NSLog(@"input : %@", test);
    NSLog(@"output : %@", [self sha256HashForText: test]);
    NSLog(@"input : %@", _inputTextField.text);
}

- (IBAction)convertingAction:(id)sender {
    
    NSString *inputTextField = _inputTextField.text;
    
    NSLog(@"input : %@", inputTextField);
   
    NSLog(@"output : %@", [self sha256HashForText: inputTextField]);
}

-(NSString*)sha256HashFor:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


-(NSString*)sha256HashForText:(NSString*)text {
    const char* utf8chars = [text UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(utf8chars, (CC_LONG)strlen(utf8chars), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
@end
