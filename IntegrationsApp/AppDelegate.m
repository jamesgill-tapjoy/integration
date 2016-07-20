//
//  AppDelegate.m
//  IntegrationsApp
//
//  Created by James Gill on 7/19/16.
//  Copyright © 2016 James Gill. All rights reserved.
//

#import "AppDelegate.h"
#import <Tapjoy/Tapjoy.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //Set up success and failure notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tjcConnectSuccess:)
                                                 name:TJC_CONNECT_SUCCESS
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tjcConnectFail:)
                                                 name:TJC_CONNECT_FAILED
                                               object:nil];
    
    //Turn on Tapjoy debug mode
    [Tapjoy setDebugEnabled:YES]; //Do not set this for any version of the game released to an app store
    
    //Tapjoy connect call
    [Tapjoy connect:@"WIU0kX3YR-KwYzexxewG5wEBJT6xaPFTNNyVNOzECzKFlzHNEuzr9jgXLxRw"];

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
    
    // Set the notification observer for earned-currency-notification. It's recommended that this be placed within the applicationDidBecomeActive method.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEarnedCurrencyAlert:) name:TJC_CURRENCY_EARNED_NOTIFICATION object:nil];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)tjcConnectSuccess:(NSNotification*)notifyObj
{
    NSLog(@"Tapjoy connect Succeeded");
    // This method requests the tapjoy server for current virtual currency of the user.
    //Get currency
    [Tapjoy getCurrencyBalanceWithCompletion:^(NSDictionary *parameters, NSError *error) {
        if (error) {
            //Show error message
            NSLog(@"getCurrencyBalance error: %@", [error localizedDescription]);
        } else {
            //Update currency value of your app
            NSLog(@"getCurrencyBalance returned %@: %d", parameters[@"currencyName"], [parameters[@"amount"] intValue]);
        }
    }];
}
-(void)tjcConnectFail:(NSNotification*)notifyObj
{
    NSLog(@"Tapjoy connect Failed");
}
// In the following method, you can set a custom message or use the default UIAlert to inform the user that they just earned some currency.
- (void)showEarnedCurrencyAlert:(NSNotification*)notifyObj
{
    NSNumber *currencyEarned = notifyObj.object;
    int earnedNum = [currencyEarned intValue];
    
    NSLog(@"Currency earned: %d", earnedNum);
    
    // Pops up a UIAlert notifying the user that they have successfully earned some currency.
    // This is the default alert, so you may place a custom alert here if you choose to do so.
    [Tapjoy showDefaultEarnedCurrencyAlert];
    
    // This is a good place to remove this notification since it is undesirable to have a pop-up alert more than once per app run.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TJC_CURRENCY_EARNED_NOTIFICATION object:nil];
}

@end
