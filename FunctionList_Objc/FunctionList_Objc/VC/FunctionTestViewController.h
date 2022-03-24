//
//  FunctionTestViewController.h
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/03/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionTestViewController : UIViewController
-(NSString*)sha256HashFor:(NSString*)input;
-(NSString*)sha256HashForText:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
