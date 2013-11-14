//
//  BGLocationTracking.h
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  MIT Licensed
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class CordovaInterface;
@interface BGLocationTracking : NSObject<CLLocationManagerDelegate>
    
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CordovaInterface *cordInterface;

-(id) initWithCordovaInterface: (CordovaInterface *)cordova;

@end
