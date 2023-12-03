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
    
    //all default presets.
    NSString *defaultApiEndpoint = @"https://api.openai.com/v1/chat/completions";
    NSString *defaultAIModel = @"gpt-3.5-turbo";
    NSString *defaultNickname = @"ChatGPT";
    NSString *defaultUserNickname = @"Me";
    NSString *appVersion = @"v1.0";
    NSString *aiPrompt = @" ";
    NSString *requestAmount = @"0";
    NSString *responseAmount = @"0";
    NSString *newsletterEndpoint = @"https://help.mali357.gay/ios/embedded/CaExperiments/";
    NSString *sourcecodepageendpoint = @"https://github.com/bag-xml/iOS-5-ChatGPT-Client";
    
    //sets nsuserdefault to default objects, if none are specified, aka. default keys before user modifies them.
    if (![defaults objectForKey:@"sourcecodepageendpoint"]) {
        [defaults setObject:sourcecodepageendpoint forKey:@"sourcecodepageendpoint"];
    }
    if (![defaults objectForKey:@"mali357gptendpoint"]) {
        [defaults setObject:newsletterEndpoint forKey:@"mali357gptendpoint"];
    }
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
    if (![defaults objectForKey:@"responseAmount"]) {
        [defaults setObject:responseAmount forKey:@"responseAmount"];
    }
    [defaults synchronize];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"conversationHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"conversationHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"App terminating");
}


@end
