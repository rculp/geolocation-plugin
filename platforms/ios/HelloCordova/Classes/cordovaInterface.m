//
//  cordovaInterface.m
//  HelloCordova
//
//  Created by Christopher Ketant on 11/12/13.
//
//

#import "cordovaInterface.h"

@implementation cordovaInterface
    

    - (void) cordovaGetAllLocations:(CDVInvokedUrlCommand *)command{
        
        //Retrieve the all the rows in the table using the utility functions
        NSArray *rows = [self.db getAllLocations];
        
        //Create an object that will be serialized into JSON
        NSDictionary *json = [ [NSDictionary alloc]
                              initWithObjectsAndKeys :
                              rows, @"rows",
                              @"true", @"success",
                              nil];
        
        //Create an instance of CDVPluginResult
        CDVPluginResult *pluginResult = [ CDVPluginResult
                                         resultWithStatus : CDVCommandStatus_OK
                                         messageAsDictionary : json];
        
        //Execute sendPlugin
        [self.commandDelegate sendPluginResult : pluginResult callbackId : command.callbackId];
        
    }
    
    - (void) cordovaGetLocations:(CDVInvokedUrlCommand *)command{
        
        NSNumber *size = [command.arguments objectAtIndex:0];
        
        [self.db getLocations:size];
        
        NSDictionary *json = [ [NSDictionary alloc]
                              initWithObjectsAndKeys:
                              @"true", @"success",
                              nil
                              ];
        
    }
    
    
    - (void) cordovaClearLocations:(CDVInvokedUrlCommand *)command{
        
        
        //Create an object that will be serialized into JSON
        NSDictionary *json = [ [NSDictionary alloc]
                              initWithObjectsAndKeys :
                              @"true", @"success",
                              nil];
        
        
        CDVPluginResult *pluginResult = [CDVPluginResult
                                         resultWithStatus : CDVCommandStatus_OK
                                         messageAsDictionary:json];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }


    


@end
