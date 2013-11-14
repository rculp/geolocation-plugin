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
@synthesize dbHelper;
@synthesize successCB, errorCB;

-(void) startUpdatingLocation:(CDVInvokedUrlCommand *)command{
    
    [self initCordovaInterface];
    NSUInteger argumentsCount = command.arguments.count;
    self.successCB = argumentsCount ? command.arguments[0] : nil;
    self.errorCB = (argumentsCount > 1) ? command.arguments[1] : nil;
    
    
}

-(void)initCordovaInterface{
    //set up db here
    self.dbHelper = [[LocationDBOpenHelper alloc]init];
    
    //begins tracking on init
    //self.locTracking = [[BGLocationTracking alloc]initWithCordovaInterface: self];
    
}

- (void)callSuccessJSCalback:(CLLocation *)location {
    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"%@({ coords: { latitude: %f, longitude: %f}});", self.successCB, location.coordinate.latitude, location.coordinate.longitude ]];
}

- (void)callErrorJSCalback:(NSError *)error {
    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"%@({ message: '%@' });", self.errorCB, error.localizedDescription ]];
}
@end
