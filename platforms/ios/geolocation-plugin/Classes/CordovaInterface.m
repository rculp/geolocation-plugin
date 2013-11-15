//
//  CordovaInterface.m
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/14/13.
//
//

#import "CordovaInterface.h"


@interface CordovaInterface ()

@property (strong, nonatomic) CDVInvokedUrlCommand *successCB;
@property (strong, nonatomic) CDVInvokedUrlCommand *errorCB;

-(void)initCordovaInterface;


@end


@implementation CordovaInterface
@synthesize dbHelper, locTracking;
@synthesize successCB, errorCB;

-(void) startUpdatingLocation:(CDVInvokedUrlCommand *)command{
    
    //TODO: Check if nil or not
    [self initCordovaInterface];
    NSUInteger argumentsCount = command.arguments.count;
    self.successCB = argumentsCount ? command.arguments[0] : nil;
    self.errorCB = (argumentsCount > 1) ? command.arguments[1] : nil;
    
    
}


-(void) insertCurrLocation:(CLLocation *)location{
    [self.dbHelper insertLocation:(location)];
    
}

-(void)initCordovaInterface{
    //set up db here
    self.dbHelper = [[LocationDBOpenHelper alloc]init];
    
    //begins tracking on init
    self.locTracking = [[BGLocationTracking alloc]initWithCordovaInterface: self];
    
}

@end
