//
//  LocationDBOpenHelper.h
//  CoreDataPlugin
//
//  Created by Christopher Ketant on 11/4/13.
//
//

#import <CoreLocation/CoreLocation.h>

@interface LocationDBOpenHelper{
    @private
        NSManagedObjectContext *managedObjectContext_;
        NSManagedObjectModel *managedObjectModel_;
        NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel_;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator_;


- (NSArray*) getAllLocations;
- (NSArray*) getLocations : (NSNumber *) size;
- (void) clearLocations;
- (void) insertLocation : (CLLocation *) location;
- (NSString *)applicationDocDir;
    

@end
