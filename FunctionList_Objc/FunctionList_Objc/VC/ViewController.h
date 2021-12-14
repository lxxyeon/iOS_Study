//
//  ViewController.h
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2021/08/10.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (NSString*) deviceModelName;

//block sample
//typedef 선언

// block1. typedef 정의
//typedef int (^square)(int);
typedef void (^CompleteHandler1)(void);
// typedef block
-(void)performActionWithCompletion:(CompleteHandler1)completeHandler;


typedef void (^CompleteHandler2)(NSString *result, NSError *error);

//전역변수로 사용하고 싶을 때
@property (strong, nonatomic) CompleteHandler1 completeHandler;




//이름이나 타입의 선언 없이 사용하고 싶을 때
-(void)BlockExam:(void(^)(void))completeHandler;

//typedef 사용
-(void)BlockExam:(NSString *)str completeHandler:(CompleteHandler1)completeHandler;

//블록함수는 맨 마지막에 선언 (가독성을 위해)
//- (void)beginTaskWithName:(NSString *)name completion:(void(^)(void))callback;
@end

