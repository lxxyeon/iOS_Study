//
//  NFCViewController.h
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/01/26.
//

#import <UIKit/UIKit.h>
#import "NFCManager.h"
NS_ASSUME_NONNULL_BEGIN
#define NFC_EXECUTE_ERROR_NOT_SUPPORT_DEVICE -1
#define NFC_EXECUTE_INVALID_PARAMETER -2
#define NFC_EXECUTE_NOT_SUPPORT_MULTI_TAGS -3

@protocol NfcReadVCDelegate <NSObject>
-(void)onSuccess: (NSDictionary * _Nonnull)nfcs;
-(void)onFail: (NSError * _Nonnull)error;
@end

@interface NFCViewController : UIViewController
@property (strong, nonatomic) id <NfcReadVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
