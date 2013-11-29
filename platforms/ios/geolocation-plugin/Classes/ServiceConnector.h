//
//  ServiceConnector.h
//  geolocation-plugin
//
// Sends the Location Data to the Server
//
// TODO- 1. Get Request: getConfig() REQUEST[] RESPONSE[TourConfigData]
// TODO- 2. Post Request: register() REQUEST[OS, Device, tourId] RESPONSE[rider_id]
//
//  Created by Christopher Ketant on 11/28/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CDVInterface.h"

/**
 * The Delegate for the POST request
 *
 **/
@protocol ServiceConnectorDelegate <NSObject>

-(void)requestReturnedData:(NSData *)data;

@end



@interface ServiceConnector : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ServiceConnectorDelegate> delegate;
@property (nonatomic) CDVInterface *cordInterface;


/**
 * Post the Location to the Server
 *
 * CDVInterface calls getAllLocations or getLocations(size) 
 * and the return object is passed to this method
 *
 * The 'location_update' path is expecting and 
 * returning the following
 *
 * REQUEST
 * {
 *   "rider_id": "%uuid%",
 *   "locations": [
 *       {
 *           "latitude": 43.083958,
 *           "longitude": -77.679734,
 *           "accuracy": 1,
 *           "speed": 0,
 *           "bearing": 37.444657,
 *           "time": 1359488523,
 *           "provider": "GPS"
 *       },
 *       }
 *           .
 *           .
 *           .
 *       }
 * ],
 * "battery": 0.5
 * }
 *
 *
 * RESPONSE
 * {
 * "rider_count": int
 * }
 * @param- the Location or Rider
 **/
-(void)postLocations: (CLLocation *)location;

@end
