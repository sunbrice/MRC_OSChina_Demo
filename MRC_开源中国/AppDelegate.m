//
//  AppDelegate.m
//  MRC_开源中国
//
//  Created by 峰哥哥 on 15/5/29.
//  Copyright (c) 2015年 峰哥哥-.-. All rights reserved.
//

#import "AppDelegate.h"
#import "InfoController.h"
#import "AnswerController.h"
#import "TweetController.h"
#import "MineController.h"
#import "MoreController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    MRC手动管理内存
//    内存管理黄金法则：
    /*
     1.由alloc copy new mutalbeCopy创建对象，自动引用计数器值为1；
     2.retain会让引用计数器加1，release(autorelease)会将计数器值减1；
     3.在什么地方增加了引用计数器，就要在什么地方让计数器值减1.
     */
    InfoController *info=[[InfoController alloc]init];
//    info.tabBarItem.title=@"综合";
    info.title=@"综合";
    info.tabBarItem.image=[UIImage imageNamed:@"info"];
    info.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *nv1=[[UINavigationController alloc]initWithRootViewController:info];
//    info对象不再需要 ，释放这个对象
    [info release];
    AnswerController *answer=[[AnswerController alloc]init];
    answer.title=@"问答";
    answer.tabBarItem.image=[UIImage imageNamed:@"answer"];
    answer.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *nv2=[[UINavigationController alloc]initWithRootViewController:answer];
//    释放answer对象
    [answer release];
    
    TweetController *tweet=[[TweetController alloc]init];
    tweet.title=@"动弹";
    tweet.tabBarItem.image=[UIImage imageNamed:@"tweet"];
    tweet.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *nv3=[[UINavigationController alloc]initWithRootViewController:tweet];
//    释放tweet对象
    [tweet release];
    
    MineController *mine=[[MineController alloc]init];
    mine.tabBarItem.image=[UIImage imageNamed:@"active"];
    mine.title=@"我的";
    mine.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *nv4=[[UINavigationController alloc]initWithRootViewController:mine];
//    释放mine对象
    [mine release];
    
    MoreController *more=[[MoreController alloc]init];
    more.title=@"更多";
    more.tabBarItem.image=[UIImage imageNamed:@"more"];
    more.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *nv5=[[UINavigationController alloc]initWithRootViewController:more];
//    释放more对象
    [more release];
//    创建tabBar
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=@[nv1,nv2,nv3,nv4,nv5];
//    释放导航视图控制器对象
    [nv1 release];
    [nv2 release];
    [nv3 release];
    [nv4 release];
    [nv5 release];
//    主窗口的根视图控制器设置为tabBar
    _window.rootViewController=tab;
//    释放tabBar对象
    [tab release];
    
    return YES;
    /*
     释放次数多了，程序会崩溃
     忘记释放，会导致内存泄漏(不影响程序使用，但内存会越用占的越多，最后导闪退)
     */
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
