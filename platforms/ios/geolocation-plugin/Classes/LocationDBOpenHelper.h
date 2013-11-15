//
//  LocationDBOpenHelper.h
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/14/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDBOpenHelper : NSObject {
    @private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}
    
    @property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
    @property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
    @property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    
- (NSArray*) getAllLocations;
- (NSArray*) getLocations: (NSNumber *) size;
- (NSString *)applicationDocDir;
- (void) clearLocations;
- (void) insertLocation: (CLLocation *) location;

    
    
    @end
