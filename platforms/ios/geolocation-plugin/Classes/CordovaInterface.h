//
//  CordovaInterface.h
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/14/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Cordova/CDVPlugin.h>
#import "LocationDBOpenHelper.h"
#import "BGLocationTracking.h"

@interface CordovaInterface : CDVPlugin <CLLocationManagerDelegate>

@property (strong, nonatomic) LocationDBOpenHelper *dbHelper;
@property (strong, nonatomic) BGLocationTracking *locTracking;
    
- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command;
    


@end
