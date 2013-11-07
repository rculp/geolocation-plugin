//
//  LocationDBOpenHelper.h
//  CoreDataPlugin
//
//  Created by Christopher Ketant on 11/4/13.
//
//

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDBOpenHelper : CDVPlugin {
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Cordova JavaScript bridge functions
//EXPOSED Functions
- (void) cordovaGetAllLocations : (CDVInvokedUrlCommand *) command;
- (void) cordovaGetLocations : (CDVInvokedUrlCommand *) command;
- (void) cordovaClearLocations : (CDVInvokedUrlCommand *) command;
- (void) cordovaInsertLocation : (CDVInvokedUrlCommand *) command;
- (void) cordovaOnUpgrade : (CDVInvokedUrlCommand *) command;

// iOS underlying functions to the Cordova JS bridge functions, utility functions
- (NSArray*) getAllLocations;
- (NSArray*) getLocations : (NSNumber *) size;
- (void) clearLocations;
- (void) insertLocation : (CLLocation *) location; //for now take no paramter

    

@end
