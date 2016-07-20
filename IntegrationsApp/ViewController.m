//
//  ViewController.m
//  IntegrationsApp
//
//  Created by James Gill on 7/19/16.
//  Copyright © 2016 James Gill. All rights reserved.
//

#import "ViewController.h"
#import <Tapjoy/TJPlacement.h>


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
        _buttonPress = @"empty";
    }
    if([_buttonPress  isEqual: @"Offer"]){
        [_offerPlacement showContentWithViewController: self];
        _buttonPress = @"empty";
    }
    
}

// Called when the content is showed.
- (void)contentDidAppear:(TJPlacement*)placement{}

// Called when the content is dismissed.
- (void)contentDidDisappear:(TJPlacement*)placement{
    if([_buttonPress  isEqual: @"Video"]){
        [_videoPlacement requestContent];
        _buttonPress = @"empty";
    }
    if([_buttonPress  isEqual: @"Offer"]){
        [_offerPlacement requestContent];
        _buttonPress = @"empty";
    }
}

- (IBAction)ShowOffer:(id)sender {
}

- (IBAction)ShowVideo:(id)sender {
}


@end
