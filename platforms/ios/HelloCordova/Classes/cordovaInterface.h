//
//  cordovaInterface.h
//  HelloCordova
//
//  Created by Christopher Ketant on 11/12/13.
// The Header file containing all the declarations of the javascript
// interface functions used to access the native iOS calls.
//

#import <Cordova/CDV.h>
#import "LocationDBOpenHelper.h"

@interface cordovaInterface : CDVPlugin{
    LocationDBOpenHelper *db;
}
@property (atomic, retain) LocationDBOpenHelper *db;

    - (void) cordovaGetAllLocations : (CDVInvokedUrlCommand *) command;
    - (void) cordovaGetLocations : (CDVInvokedUrlCommand *) command;
    - (void) cordovaClearLocations : (CDVInvokedUrlCommand *) command;
    - (void) cordovaInsertLocation : (CDVInvokedUrlCommand *) command;


@end
