#import "NSBundle+YTLite.h"
#import <dlfcn.h>

@implementation NSBundle (YTLite)

+ (NSBundle *)ytl_defaultBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YTLite" ofType:@"bundle"];
        NSLog(@"[YTLite] mainBundle pathForResource YTLite.bundle: %@", tweakBundlePath);
        if (!tweakBundlePath) {
            Dl_info info;
            if (dladdr((const void *)&bundle, &info) != 0) {
                NSString *dylibPath = [NSString stringWithUTF8String:info.dli_fname];
                NSString *frameworksPath = [dylibPath stringByDeletingLastPathComponent];
                NSString *appPath = [frameworksPath stringByDeletingLastPathComponent];
                tweakBundlePath = [appPath stringByAppendingPathComponent:@"YTLite.bundle"];
                NSLog(@"[YTLite] dladdr fallback YTLite.bundle path: %@", tweakBundlePath);
            }
        }
        NSString *kBundlePath = jbroot(@"/Library/Application Support/YTLite.bundle");
        NSLog(@"[YTLite] jbroot path: %@", kBundlePath);

        NSString *finalPath = tweakBundlePath ?: kBundlePath;
        bundle = [NSBundle bundleWithPath:finalPath];
        NSLog(@"[YTLite] bundleWithPath final: %@ -> Loaded Bundle: %@", finalPath, bundle);
    });

    return bundle;
}

@end
