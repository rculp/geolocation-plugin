//
//  CordovaInterface.m
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/14/13.
//
//

#import "CordovaInterface.h"


@interface CordovaInterface ()

    -(void)initCordovaInterface;
    @property (strong, nonatomic) CDVInvokedUrlCommand *successCB;
    @property (strong, nonatomic) CDVInvokedUrlCommand *errorCB;

@end

    
@implementation CordovaInterface
    @synthesize dbHelper, locTracking;
    @synthesize successCB, errorCB;
    
    -(void) startUpdatingLocation:(CDVInvokedUrlCommand *)command{
        
        [self initCordovaInterface];
        
        
        
    }
    
    -(void)initCordovaInterface{
        
        self.dbHelper = [[LocationDBOpenHelper alloc]init];
        self.locTracking = [[BGLocationTracking alloc]init];
    }
@end
