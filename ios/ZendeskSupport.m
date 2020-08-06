#import "ZendeskSupport.h"
#import <SupportSDK/SupportSDK.h>
#import <ZendeskCoreSDK/ZendeskCoreSDK.h>
#import <SupportProvidersSDK/SupportProvidersSDK.h>

@implementation ZendeskSupport

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(initialization, initializeWithAppId:(nonnull NSString*)appId andClientId:(nonnull NSString*)clientId andZendeskUrl:(nonnull NSString*)zendeskUrl andLocale:(NSString*)locale withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject) {
    ZDKCoreLogger.enabled = true;
    [ZDKZendesk initializeWithAppId: appId
                           clientId: clientId
                         zendeskUrl: zendeskUrl];
    [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:nil email:nil];
    [[ZDKZendesk instance] setIdentity:userIdentity];
    
    if(locale != NULL){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@[locale] forKey:@"AppleLanguages"];
        [defaults synchronize];
    }
    
    resolve([NSNumber numberWithBool:YES]);
}

RCT_REMAP_METHOD(openTickets, openTicketsWithSubject:(nonnull NSString*)subject withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject){
    ZDKRequestUiConfiguration *configuration = [ZDKRequestUiConfiguration new];
    configuration.subject = subject;
    
    UIViewController *ticketsVC = [ZDKRequestUi buildRequestListWith:@[configuration]];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:ticketsVC];
    UIViewController *visibleVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    do {
        if ([visibleVC isKindOfClass:[UINavigationController class]]) {
            visibleVC = [(UINavigationController *)visibleVC visibleViewController];
        } else if (visibleVC.presentedViewController) {
            visibleVC = visibleVC.presentedViewController;
        }
    } while (visibleVC.presentedViewController);
    dispatch_async(dispatch_get_main_queue(), ^{
        [visibleVC presentViewController:navigationVC animated:YES completion: ^{
            resolve([NSNumber numberWithBool:YES]);
        }];
    });
}

- (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

- (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}

@end
