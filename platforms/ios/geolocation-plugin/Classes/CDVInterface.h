//
//  CDVInterface.h
//  geolocation-plugin
//
// The main class used to interface
// with the plugin from the Javascript
//
//  Created by Christopher Ketant on 11/14/13.
//
// TO-DO: Implement a [static .plist vs CoreData] TourConfigData files
// TO-DO: implement the new interface functions
// TO-DO: Find out when interface functions are called during app life-time
// TO-DO: Do we need to create another plugin now?
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "LocationDBOpenHelper.h"
#import "BGLocationTracking.h"

@interface CDVInterface : CDVPlugin

@property (retain, nonatomic) LocationDBOpenHelper *dbHelper;
@property (retain, nonatomic) BGLocationTracking *locTracking;


#pragma-
#pragma mark - DCS Interface functions, called by Sencha

/**
 * Start Getting the current
 * Location, called from JavaScript
 *
 *@param - Cordova Function to Call
 **/
- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command;

/**
 * Get the configuration for the Tour Config Data
 * this is also used to update the Tour Config Data
 * if changes are made on the admin side
 **/
- (void)getConfig: (CDVInvokedUrlCommand *)command;

/**
 * Register the Rider with the DCS Server
 * The response to this Get Request is the
 * ID of the rider
 **/
- (void)registerRider: (CDVInvokedUrlCommand *)command;

/**
 * Register the Push Id
 * <Formerly for GCM must implement the
 * equivalent for APNS>
 **/
- (void)registerPushId: (CDVInvokedUrlCommand *)command;



#pragma-
#pragma mark - CoreData interface functions


/**
 * Insert Location into the
 * CoreData database
 *
 *@param - current location
 **/
- (void)insertCurrLocation: (CLLocation *)location;
/**
 *
 * Get all the locations
 * stored in core data
 *
 *@return - Array of locations
 * stored in coredata
 **/
-(NSArray*)getAllLocations;
/**
 * Get locations
 * in the amount of
 * size specified
 *
 * @param - size
 *
 **/
- (NSArray*)getLocations: (NSUInteger)size;
/**
 * Clear all the locations
 * that are in the coredata
 * emtpy them
 *
 * @param - size
 * @return - Array of locationsw
 *
 **/
- (void) clearLocations;


@end
