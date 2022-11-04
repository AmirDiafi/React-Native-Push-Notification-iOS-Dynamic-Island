//@interface PushNotificationsdynamicIslandManager : RCTViewManager
//@end

//@implementation PushNotificationsdynamicIslandManager

//RCT_EXPORT_MODULE(PushNotificationsdynamicIsland)

//- (UIView *)view {
//  PushNotificationsdynamicIslandProxy *proxy = [[PushNotificationsdynamicIslandProxy alloc] init];
//  return [proxy view];
//}

//@end



//
//  PushNotificationDynamicIslandManager.m
//  pushNotificationsDynamicIisland
//
//  Created by mac on 10/29/22.
//

#import "React/RCTViewManager.h"

// MARK: To export a module named: PushNotificationsDynamicIsland
@interface RCT_EXTERN_MODULE(PushNotificationsDynamicIslandManager, RCTViewManager)
// MARK: isDevEnabled property
RCT_EXPORT_VIEW_PROPERTY(isDevMoodEnabled, BOOL)

@end

@interface NotificationsMethods: PushNotificationsDynamicIslandManager
@end

@implementation RCT_EXTERN_MODULE(NotificationsMethods, PushNotificationsDynamicIslandManager)
RCT_EXTERN_METHOD(pushTestNotifications)
@end
