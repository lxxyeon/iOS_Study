//
//  BViewController.h
//  DelegatePattern_Objc
//
//  Created by leeyeon2 on 2021/07/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//1. 델리게이트 프로토콜, 프로퍼티 생성
@protocol BViewControllerDelegate <NSObject>
@optional
-(void)sendMessage:(NSString*)message;
@end

@interface BViewController : UIViewController
@property (weak,nonatomic) id <BViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
