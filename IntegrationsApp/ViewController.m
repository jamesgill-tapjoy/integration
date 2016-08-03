//
//  ViewController.m
//  IntegrationsApp
//
//  Created by James Gill on 7/19/16.
//  Copyright © 2016 James Gill. All rights reserved.
//

#import "ViewController.h"
#import <Tapjoy/TJPlacement.h>
#import <Tapjoy/Tapjoy.h>


@interface ViewController ()
@property (strong, nonatomic) TJPlacement *offerPlacement;
@property (strong, nonatomic) TJPlacement *videoPlacement;
@property (nonatomic,copy) NSString *buttonPress;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Called when the SDK has made contact with Tapjoy's servers. It does not necessarily mean that any content is available.
- (void)requestDidSucceed:(TJPlacement*)placement{}

// Called when there was a problem during connecting Tapjoy servers.
- (void)requestDidFail:(TJPlacement*)placement error:(NSError*)error{}

// Called when the content is actually available to display.
- (void)contentIsReady:(TJPlacement*)placement{
    if([_buttonPress  isEqual: @"Video"]){
        [_videoPlacement showContentWithViewController: self];
    }
    if([_buttonPress  isEqual: @"Offer"]){
        [_offerPlacement showContentWithViewController: self];
    }
    
}

// Called when the content is showed.
- (void)contentDidAppear:(TJPlacement*)placement{}

// Called when the content is dismissed.
- (void)contentDidDisappear:(TJPlacement*)placement{
    NSLog(@"Content Dismissed");

    if([_buttonPress  isEqual: @"Video"]){
        [_videoPlacement requestContent];
        NSLog(@"Type is Video Call");
        _buttonPress = @"empty";
    }
    else if([_buttonPress  isEqual: @"Offer"]){
        NSLog(@"Type is Offer Wall Call");
        [_offerPlacement requestContent];
        _buttonPress = @"empty";
    }
    NSLog(@"Content Dismissed Call Complete");
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
    // Set the notification observer for earned-currency-notification. It's recommended that this be placed within the applicationDidBecomeActive method.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEarnedCurrencyAlert:) name:TJC_CURRENCY_EARNED_NOTIFICATION object:nil];
}

- (IBAction)ShowOffer:(id)sender {
    _buttonPress = @"Offer";
    if(_offerPlacement.contentReady) {
        [_offerPlacement showContentWithViewController: self];
    }
    else {
        _offerPlacement = [TJPlacement placementWithName:@"OfferWall" delegate:self ];
        [_offerPlacement requestContent];
    }
}

- (IBAction)ShowVideo:(id)sender {
    _buttonPress = @"Video";
    if(_videoPlacement.contentReady) {
        [_videoPlacement showContentWithViewController: self];
    }
    else {
        _videoPlacement = [TJPlacement placementWithName:@"ShowVideo" delegate:self ];
        [_videoPlacement requestContent];

    }

}
- (IBAction)award:(id)sender {
    
    // This method call will award 10 virtual currencies to the user's total.
    [Tapjoy awardCurrency:10 completion:^(NSDictionary *parameters, NSError *error) {
        if (error) {
            NSLog(@"awardCurrency error: %@", [error localizedDescription]);
        } else {
            NSLog(@"awardCurrency returned %@: %d", parameters[@"currencyName"], [parameters[@"amount"] intValue]);
        }
    }];

}

- (IBAction)spend:(id)sender {
    
    // This method call will deduct 10 virtual currencies from the user's total.
    [Tapjoy spendCurrency:10 completion:^(NSDictionary *parameters, NSError *error) {
        if (error) {
            NSLog(@"spendCurrency error: %@", [error localizedDescription]);
        } else {
            NSLog(@"spendCurrency returned %@: %d", parameters[@"currencyName"], [parameters[@"amount"] intValue]);
        }
    }];
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
