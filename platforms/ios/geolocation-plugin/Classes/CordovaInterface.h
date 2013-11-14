//
//  CordovaInterface.h
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/14/13.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "LocationDBOpenHelper.h"
#import "BGLocationTracking.h"

@interface CordovaInterface : CDVPlugin

@property (retain, nonatomic) LocationDBOpenHelper *dbHelper;
@property (retain, nonatomic) BGLocationTracking *locTracking;

- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command;
- (void)insertCurrLocation: (CLLocation *)location;
    


@end
