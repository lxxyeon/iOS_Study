//
//  SceneDelegate.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2021/08/10.
//

#import "SceneDelegate.h"
#import "CustomViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
//스토리보드 삭제 후 class UI
//    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.windowScene = (UIWindowScene *)scene;
//    self.window.rootViewController = [CustomViewController new];
//    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {

}


- (void)sceneDidBecomeActive:(UIScene *)scene {

}


- (void)sceneWillResignActive:(UIScene *)scene {

}


- (void)sceneWillEnterForeground:(UIScene *)scene {

}


- (void)sceneDidEnterBackground:(UIScene *)scene {

}


@end
