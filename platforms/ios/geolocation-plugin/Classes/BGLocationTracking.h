//
//  BGLocationTracking.h
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  MIT Licensed
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CordovaInterface.h"

@interface BGLocationTracking : CDVPlugin <CLLocationManagerDelegate>
    
    @property (strong, nonatomic) CLLocationManager *locationManager;
    
- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command;
    
    @end
