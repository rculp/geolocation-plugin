//
//  ServiceConnector.h
//  geolocation-plugin
//
// Sends the Location Data to the Server
//
//  Created by Christopher Ketant on 11/28/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 * The Delegate for the POST request
 *
 **/
@protocol ServiceConnectorDelegate <NSObject>

-(void)requestReturnedData:(NSData *)data;

@end



@interface ServiceConnector : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ServiceConnectorDelegate> delegate;


/**
 * Post the Location to the Server
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
-(void)postLocation: (CLLocation *)location;

@end
