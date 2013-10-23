//
//  LocationUpdates.h
//  CoreDataPlugin
//
//  Created by Christopher Ketant on 10/23/13.
//  Copyright (c) 2013 devcycle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LocationUpdates : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * speed;
@property (nonatomic, retain) NSString * accuracy;
@property (nonatomic, retain) NSString * provider;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * battery;

@end
