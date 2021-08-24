//
//  BViewController.h
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2021/08/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BViewControllerDelegate <NSObject>
@optional
-(void)sendMessage:(NSString*)message;
@end

@interface BViewController : UIViewController
@property (weak,nonatomic) id <BViewControllerDelegate> delegate;
@end


NS_ASSUME_NONNULL_END
