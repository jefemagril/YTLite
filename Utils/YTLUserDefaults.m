#import "YTLUserDefaults.h"

@implementation YTLUserDefaults

static NSString *const kDefaultsSuiteName = @"com.dvntm.ytlite";

+ (YTLUserDefaults *)standardUserDefaults {
    static dispatch_once_t onceToken;
    static YTLUserDefaults *defaults = nil;

    dispatch_once(&onceToken, ^{
        defaults = [[self alloc] initWithSuiteName:kDefaultsSuiteName];
        NSLog(@"[YTLite] Created defaults with suite %@ -> defaults object: %@", kDefaultsSuiteName, defaults);
        [defaults registerDefaults];
    });

    return defaults;
}

- (void)reset {
    NSLog(@"[YTLite] Resetting defaults for suite: %@", kDefaultsSuiteName);
    [self removePersistentDomainForName:kDefaultsSuiteName];
}

- (void)registerDefaults {
    NSLog(@"[YTLite] Registering defaults...");
    [self registerDefaults:@{
        @"noAds": @YES,
        @"backgroundPlayback": @YES,
        @"removeUploads": @YES,
        @"speedIndex": @1,
        @"autoSpeedIndex": @3,
        @"wiFiQualityIndex": @0,
        @"cellQualityIndex": @0,
        @"pivotIndex": @0
    }];
    NSLog(@"[YTLite] Defaults registered successfully.");
}

+ (void)resetUserDefaults {
    [[self standardUserDefaults] reset];
}

@end
