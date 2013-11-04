//
//  LocationDBOpenHelper.m
//  CoreDataPlugin
//
//  Created by Christopher Ketant on 11/4/13.
//
//

#import "LocationDBOpenHelper.h"
#import "LocationUpdates.h"
#import "LocationController.h"

@implementation LocationDBOpenHelper
@synthesize managedObjectContext;

//TO-DO: Implement InsertLocation and onUpgrade

- (void) cordovaGetAllLocations:(CDVInvokedUrlCommand *)command{
    
    //Retrieve the all the rows in the table using the utility functions
    NSArray *rows = [self getAllLocations];
    
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
    
    [self getLocations:size];
    
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

//--------------------------Corresponding Utility Functions-----------------------------//

/**
 * Wipe all the rows in the
 * table
 *
 *
 **/
- (NSArray*) clearLocations{
    //Prepare our fetch request
    NSFetchRequest *allLocations = [[NSFetchRequest alloc] initWithEntityName:@"LocationUpdates"];

    NSError *error = nil;
    
    NSArray *results = [managedObjectContext executeFetchRequest:allLocations error:&error];
    
    //loop through and delete all the rows
    for(NSManagedObject *row in results){
        [managedObjectContext deleteObject:row];
    }
    
    [managedObjectContext save:&error];
    
}



/**
 * Get all the rows in the table
 *
 * @return - results array
 **/
- (NSArray*)getAllLocations{
    
    //Setup our Fetch Request
    NSFetchRequest *allLocations = [[NSFetchRequest alloc]initWithEntityName:@"LocationUpdates"];
    
    //set up error variable
    NSError *error = nil;
    
    //results
    NSArray *results = [managedObjectContext executeFetchRequest:allLocations error:&error];
    
    //return array of all the rows returned
    return results;
    
}

/**
 * Get a certain number of rows
 * in ascending order based on time
 *
 * @return - results array
 **/
- (NSArray*)getLocations:(NSInteger *) size {
    
    //Set up our fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"LocationUpdates"];
    //Set up our Descriptor for sorting it
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    //sort it
    [request setSortDescriptors:@[sort]];
    //get the size of the fetch we want
    [request setFetchLimit:size];
    NSError *error = nil;
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    return results;
}

/**
 * 
 * Insert a Location Controller in the table
 *
 *
 * @return - id entry
 **/
-(NSNumber *)insertLocation:(CLLocation *) location{
    loc.delegate = self;<#(NSDateFormatterStyle)#>
    NSString *dateStr = [NSDateFormatter
                         localizedStringFromDate:location.time
                                                       dateStyle:NSDateFormatterShortStyle
                                                       timeStyle:NSDateFormatterFullStyle];
    
    NSManagedObject *row = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"locationUpdates"
                                 inManagedObjectContext:managedObjectContext];
    
    float batteryLevel = [[UIDevice currentDevice] batteryLevel]
    
    [location setValue:dateStr forKey@:"time"];
    
    [location setValue:[NSString stringWithFormat:@"%f",location.coordinate.latitude]
     forKey@:"latitude"];
    
    [location setValue:[NSString stringWithFormat:@"%f",location.coordinate.longitude]
     forKey@:"longitude"];
    
    [location setValue:[NSString stringWithFormat:@"%f",[location horizontalAccuracy]]
     forKey@:"accuracy"];
    
    [location setValue:[NSString stringWithFormat:@"%f",[location speed]]
     forKey@:"speed"];
    
    [location setValue:[NSString stringWithFormat:@"%f",[location course]]
     forKey@:"bearing"];
    
    [location setValue:@"TEST" forKey@:"provider"];
    
    [location setValue:[NSString stringWithFormat:@"%f",batteryLevel]
     forKey@:"battery"];
    
    NSError *error;
    if(![managedObjectContext save:&error]){
        NSLog(@"Failed to save - error: %@", [error localizedDescription)]);
    }
    
    
}






@end
