//
//
// Copyright (c) 2016 Fyber. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "FYBCreativeType.h"

@interface FYBInterstitialOffer : NSObject

@property (nonatomic, copy, readonly) NSString *networkName;
@property (nonatomic, copy, readonly) NSString *adId;
@property (nonatomic, copy, readonly) NSString *orientation;
@property (nonatomic, copy, readonly) NSString *tpnPlacementId;
@property (nonatomic, assign, readonly) FYBCreativeType creativeType;
@property (nonatomic, strong, readonly) NSDictionary *arbitraryData;
@property (nonatomic, strong, readonly) NSDictionary *trackingParams;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;

#pragma mark - Helpers

- (BOOL)isLandscape;
- (BOOL)isPortrait;
- (BOOL)isOrientationSupported;

@end
