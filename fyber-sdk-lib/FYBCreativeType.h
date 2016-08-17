//
//
// Copyright (c) 2016 Fyber. All rights reserved.
//
//

/**
 *  The creative type of an ad
 */
typedef NS_ENUM(NSInteger, FYBCreativeType) {
    /**
     *  The creative type is invalid
     */
    FYBCreativeTypeUnknown = 0,

    /**
     *  The creative type can be both, video or static
     */
    FYBCreativeTypeMixed,

    /**
     *  The creative type is static only
     */
    FYBCreativeTypeStatic,

    /**
     *  The creative type is video only
     */
    FYBCreativeTypeVideo
};
