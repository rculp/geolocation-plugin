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
    @property (nonatomic, retain) NSManagedObjectModel *managedObjectModel_;
    @property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    
    
- (NSArray*) getAllLocations;
- (NSArray*) getLocations : (NSNumber *) size;
- (void) clearLocations;
- (void) insertLocation : (CLLocation *) location;
- (NSString *)applicationDocDir;
    
    
    @end
