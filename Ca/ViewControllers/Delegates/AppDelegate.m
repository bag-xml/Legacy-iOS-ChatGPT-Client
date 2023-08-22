//
//  AppDelegate.m
//  Ca
//
//  Created by Mali 357 on 14/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultApiEndpoint = @"https://api.openai.com/v1/chat/completions";
    NSString *defaultAIModel = @"gpt-3.5-turbo";
    NSString *defaultNickname = @"ChatGPT";
    NSString *defaultUserNickname = @"Me";
    NSString *appVersion = @"1.0a5";
    NSString *aiPrompt = @" ";
    NSString *requestAmount = @"0";
    
    
    if (![defaults objectForKey:@"apiEndpoint"]) {
        [defaults setObject:defaultApiEndpoint forKey:@"apiEndpoint"];
    }
    if (![defaults objectForKey:@"AIModel"]) {
        [defaults setObject:defaultAIModel forKey:@"AIModel"];
    }
    if (![defaults objectForKey:@"assistantNick"]) {
        [defaults setObject:defaultNickname forKey:@"assistantNick"];
    }
    if (![defaults objectForKey:@"userNick"]) {
        [defaults setObject:defaultUserNickname forKey:@"userNick"];
    }
    if (![defaults objectForKey:@"version"]) {
        [defaults setObject:appVersion forKey:@"version"];
    }
    if (![defaults objectForKey:@"gptPrompt"]) {
        [defaults setObject:aiPrompt forKey:@"gptPrompt"];
    }
    if (![defaults objectForKey:@"requestAmount"]) {
        [defaults setObject:requestAmount forKey:@"requestAmount"];
    }
    [defaults synchronize];
    return YES;
}

/*- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultApiEndpoint = @"https:/api.openai.com/v1/chat/completion";
    
    if (![defaults objectForKey:@"apiEndpoint"]) {
        [defaults setObject:defaultApiEndpoint forKey:@"apiEndpoint"];
        [defaults synchronize];
    }
    return YES;
}*/
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
