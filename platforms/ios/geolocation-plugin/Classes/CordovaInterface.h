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
/**
 * Start Getting the current
 * Location
 *
 *@param - Cordova Function to Call
 **/
- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command;
/**
 * Insert Location into the
 * CoreData database
 *
 *@param - current location
 **/
- (void)insertCurrLocation: (CLLocation *)location;
    


@end
