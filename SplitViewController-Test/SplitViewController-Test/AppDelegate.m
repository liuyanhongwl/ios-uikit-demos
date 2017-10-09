//
//  AppDelegate.m
//  SplitViewController-Test
//
//  Created by hong-drmk on 2017/10/9.
//  Copyright © 2017年 hong-drmk. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@interface AppDelegate ()<UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UISplitViewController *split = [[UISplitViewController alloc] init];
    
    
    MasterViewController *master = [[MasterViewController alloc] init];
    master.title = @"Master";
    UINavigationController *masterNavi = [[UINavigationController alloc] initWithRootViewController:master];
    masterNavi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};

    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.title = @"Detail";
    //设置detail.leftBarButtonItem为控制“展开”或者“合并”的master的按钮
    detail.navigationItem.leftBarButtonItem = split.displayModeButtonItem;
    //未设置left items时显示back button
    detail.navigationItem.leftItemsSupplementBackButton = YES;
    UINavigationController *detailNavi = [[UINavigationController alloc] initWithRootViewController:detail];
    detailNavi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
    
    
    split.viewControllers = @[masterNavi, detailNavi];
    split.delegate = self;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = split;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController{
    // split controllers 合并时会调用该方法
    // 返回 NO 使用默认的合并行为
    // 返回 YES 使用自定义的合并行为
    // 启动时是Compact状态时会调用一次
    static NSUInteger count = 0;
    if (count++ == 1) {
        //自定义合并行为， 如果没有实现自定义行为， 则什么也不做
        NSLog(@"collapse separate secondary with do nothing");
        return YES;
    }
    //默认合并行为。
    //如果primary是UINavigationController， 则将secondary push上去， 因为UINavigationController实现了 collapseSecondaryViewController: forSplitViewController: 方法
    //如果不是UINavigationController， 则调用secondary的 collapseSecondaryViewController: forSplitViewController: 方法。
    return NO;
}

- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    // split controllers 展开时会调用该方法
    // 返回 nil 使用默认的展开行为
    // 启动时是非Compact状态时也“不”会调用一次
    static NSUInteger count = 0;
    if (count++ == 5) {
        NSLog(@"split separate secondary with UIViewController");
        return [[UIViewController alloc] init];
    }
    //默认展开行为。
    //将原来合并到primary上的secondary拆分出来。
    return nil;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(id)sender{
    //返回 YES 表示调用 showViewController:方法后有自定义的显示master行为
//    return YES;
    //返回 NO 执行默认行为
    return NO;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender{
    //返回 YES 表示调用 showDetailViewController: 方法后有自定义的显示detail行为
//    return YES;
    //返回 NO 执行默认行为
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
