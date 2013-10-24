//
//  TrackingLocation.h
//  TrackingPlugin
//
//  Created by Rob on 10/23/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Cordova/CDV.h>

@protocol LocationControllerDelegate
@required
- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
- (void)locationError:(NSError *)error; // Any errors are sent here
@end

@interface TrackingLocation : CDVPlugin {

CLLocationManager *locMgr;
id delegate;
    
}

@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, assign) id delegate;


@end
