//
//  AppDelegate.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
#import "DiscoverController.h"
#import "RadioController.h"
#import "MineController.h"
#import "PlayerController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AVOSCloud setApplicationId:@"gygk6k80xeVgrlVM2PkeEzsW"
                      clientKey:@"PupC2Jsgb9wzzaDOuyW8hExC"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DiscoverController *discoverVC = [[DiscoverController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *discoverNC = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    

    UINavigationController *RadioNC = [[UINavigationController alloc]initWithRootViewController:[RadioController new]];
    RadioNC.tabBarItem.title = @"电台";
    RadioNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-svgmoban16"];
    
    
    MineController *mineVC = [MineController new];
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    
    
    PlayerController *playerVC = [[PlayerController alloc]init];
    UINavigationController *playerNC = [[UINavigationController alloc]initWithRootViewController:playerVC];
    playerVC.title = @"播放";
    
    //图片必须是镂空的
    UIImage *image4 = [UIImage imageNamed:@"bofangyemian"];
    //图片渲染(保持原有的特性)(如果图片不是镂空的,必须渲染)
    image4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//翻译;表现  //模式  //原始的;最初的
    playerVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"播放" image:image4 selectedImage:image4];
    
    
    
    
    NSArray *allNC = @[discoverNC,RadioNC,playerNC,mineNC];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    
    
    tabBarVC.viewControllers = allNC;
    
    self.window.rootViewController = tabBarVC;
    
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
