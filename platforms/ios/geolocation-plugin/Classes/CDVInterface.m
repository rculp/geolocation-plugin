//
//  CDVInterface.m
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/14/13.
//
//

#import "CDVInterface.h"


@interface CDVInterface ()

@property (strong, nonatomic) CDVInvokedUrlCommand *successCB;
@property (strong, nonatomic) CDVInvokedUrlCommand *errorCB;

@end


@implementation CDVInterface
@synthesize dbHelper, locTracking;
@synthesize successCB, errorCB;

#pragma-
#pragma mark - Interface functions
-(void) startUpdatingLocation:(CDVInvokedUrlCommand *)command{
    
    
    if(self.dbHelper == nil && self.locTracking == nil){
        [self initCDVInterface];
    }
    NSUInteger argumentsCount = command.arguments.count;
    self.successCB = argumentsCount ? command.arguments[0] : nil;
    self.errorCB = (argumentsCount > 1) ? command.arguments[1] : nil;
    
    
}


-(void) insertCurrLocation:(CLLocation *)location{
    [self.dbHelper insertLocation:(location)];
    
}

-(NSArray*) getAllLocations{
    return [self.dbHelper getAllLocations];
}

-(NSArray*) getLocations:(NSUInteger)size{
    return [self.dbHelper getLocations:(size)];
}

-(void) clearLocations{
    [self.dbHelper clearLocations];
}
#pragma-
#pragma mark - Initialize functions
-(void)initCDVInterface{
    //set up db here
    self.dbHelper = [[LocationDBOpenHelper alloc]init];
    
    //begins tracking on init
    self.locTracking = [[BGLocationTracking alloc]initWithCDVInterface: self];
    
}

@end
