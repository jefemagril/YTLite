#import "NSBundle+YTLite.h"
#import <dlfcn.h>

@implementation NSBundle (YTLite)

+ (NSBundle *)ytl_defaultBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YTLite" ofType:@"bundle"];
        if (!tweakBundlePath) {
            Dl_info info;
            if (dladdr((const void *)&bundle, &info) != 0) {
                NSString *dylibPath = [NSString stringWithUTF8String:info.dli_fname];
                NSString *frameworksPath = [dylibPath stringByDeletingLastPathComponent];
                NSString *appPath = [frameworksPath stringByDeletingLastPathComponent];
                tweakBundlePath = [appPath stringByAppendingPathComponent:@"YTLite.bundle"];
            }
        }
        NSString *kBundlePath = jbroot(@"/Library/Application Support/YTLite.bundle");

        bundle = [NSBundle bundleWithPath:tweakBundlePath ?: kBundlePath];
    });

    return bundle;
}

@end
