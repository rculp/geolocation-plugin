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


- (void) clearLocations{
    //Prepare our fetch request
    NSFetchRequest *allLocations = [[NSFetchRequest alloc] initWithEntityName:@"LocationUpdates"];

    NSError *error = nil;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:allLocations error:&error];
    
    //loop through and delete all the rows
    for(NSManagedObject *row in results){
        [self.managedObjectContext deleteObject:row];
    }
    
    [self.managedObjectContext save:&error];
    
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
    NSArray *results = [self.managedObjectContext executeFetchRequest:allLocations error:&error];
    
    //return array of all the rows returned
    return results;
    
}

/**
 * Get a certain number of rows
 * in ascending order based on time
 *
 * @return - results array
 **/
- (NSArray*)getLocations:(NSNumber *) size {
    
    //Set up our fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"LocationUpdates"];
    //Set up our Descriptor for sorting it
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    //sort it
    [request setSortDescriptors:@[sort]];
    //get the size of the fetch we want
    [request setFetchLimit:size];
    NSError *error = nil;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return results;
}

/**
 * 
 * Insert a Location Controller in the table
 *
 *
 * @return - id entry
 **/
-(void)insertLocation:(CLLocation *) location{
    
    NSString *dateStr = [NSDateFormatter
                         localizedStringFromDate:location.timestamp
                                                       dateStyle:NSDateFormatterShortStyle
                                                       timeStyle:NSDateFormatterFullStyle];
    
    NSManagedObject *row = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"locationUpdates"
                                 inManagedObjectContext:self.managedObjectContext];
    
    float batteryLevel = [[UIDevice currentDevice] batteryLevel];
    
    [row setValue:dateStr forKey:@"time"];
    
    [row setValue:[NSString stringWithFormat:@"%f",location.coordinate.latitude]
                forKey:@"latitude"];
    
    [row setValue:[NSString stringWithFormat:@"%f",location.coordinate.longitude]
                forKey:@"longitude"];
    
    [row setValue:[NSString stringWithFormat:@"%f",[location horizontalAccuracy]]
                forKey:@"accuracy"];
    
    [row setValue:[NSString stringWithFormat:@"%f",[location speed]]
                forKey:@"speed"];
    
    [row setValue:[NSString stringWithFormat:@"%f",[location course]]
                forKey:@"bearing"];
    
    [row setValue:@"TEST" forKey:@"provider"];
    
    [row setValue:[NSString stringWithFormat:@"%f",batteryLevel]
                forKey:@"battery"];
    
    NSError *error;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
   
}

#pragma mark - 
#pragma mark Core Data stack
/**
 *
 *
 *
 **/
- (NSManagedObjectContext *)managedObjectContext {
    if(managedObjectContext_ != nil){
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

/**
 *
 *
 *
 *
 **/
- (NSManagedObjectModel *)managedObjectModel{
    if(managedObjectModel_ != nil){
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CoreDataPlugin" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel_;
}

/**
 *
 *
 *
 **/
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if(persistentStoreCoordinator_ != nil){
        return persistentStoreCoordinator_;
    }
    
    NSURL *storageURL = [NSURL fileURLWithPath:[[self applicationDocDir]
                         stringByAppendingPathComponent: @"CoreDataPlugin.sqlite"]];
    NSError *error = nil;
    if(![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storageURL options:nil error:&error]){
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator_;
}
        
/**
 *
 *
 *
 **/
- (NSString *)applicationDocDir{
    return [NSSearchPathForDirectoriesInDomains
            (NSDocumentDirectory, NSUserDomainMask, YES)
            lastObject];
}
                         


@end
