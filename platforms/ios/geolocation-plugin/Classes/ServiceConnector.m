//
//  ServiceConnector.m
//  geolocation-plugin
//
//  Created by Christopher Ketant on 11/28/13.
//
//

#import "ServiceConnector.h"


@interface ServiceConnector()

@property (nonatomic) NSData* receivedData;


/**
 * Convert the Location into a Dictonary
 * in order to be sent via JSON
 *
 * @param- Location
 * @return- Dictonary
 **/
-(NSDictionary*)getDict:(CLLocation*)loc;

/**
 * Get all the locations in proper format
 *
 * @param- Array of Locations from LocationDBOpenHelper
 * @return- Array of Dictionaries
 **/
-(NSArray *)getLocations:(NSArray*)dbLocs;

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

-(void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end


@implementation ServiceConnector

/*
 * URL to the SERVER
 *
 */
static NSString *SERVER_LOCATION_UPDATE_URL = @"http://devcycle.se.rit.edu/location_update/";


#pragma mark - Utility Functions

-(NSDictionary*)getDict:(CLLocation *)loc{
    
    NSNumber *latitude, *longitude, *speed, *accuracy;

    //the date and time string in proper
    //format
    NSString *dateStr = [NSDateFormatter
                         localizedStringFromDate:loc.timestamp
                         dateStyle:NSDateFormatterShortStyle
                         timeStyle:NSDateFormatterFullStyle];
    
    
    //battery format
    float batteryLevel = [[UIDevice currentDevice] batteryLevel];
    
    //To avoid run time error must check if any of the CLLocation attributes
    //is nil. If nil then set to Null.
    
    //latitude
    (loc.coordinate.latitude == 0.0 ? [NSNull null] : [[NSNumber alloc]initWithDouble:loc.coordinate.latitude]);
    
    //longitude
    (loc.coordinate.longitude == 0.0 ? [NSNull null] : [[NSNumber alloc]initWithDouble:loc.coordinate.longitude]);
    
    //speed
    (loc.speed == 0.0 ? [NSNull null] : [[NSNumber alloc]initWithDouble:loc.speed]);
    
    //accuracy
    (loc.horizontalAccuracy == 0.0 ? [NSNull null] : [[NSNumber alloc]initWithDouble:loc.horizontalAccuracy]);
    
    //dictionaryWithObjectsAndKeys takes the values first
    //then the keys
    NSDictionary *locDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                            dateStr, @"time",
                            batteryLevel,  @"battery",
                            latitude.doubleValue, @"latitude",
                            longitude.doubleValue, @"longitude",
                            speed.doubleValue, @"speed",
                            accuracy.doubleValue, @"accuracy",
                            [NSNull null], @"bearing", //will get this from the locaiton stored in db
                            [NSNull null], @"provider",
                            nil];
    
    return locDic;
    
    
    
}

-(NSArray*)getLocations:(NSArray *)dbLocs{
    
    //Array of the locations to send
    NSMutableArray *locations = [[NSMutableArray alloc]init];
    

    
    int size = [dbLocs count];
    
    if(size > 0){
    
        for (int index=0; index<size; index++) {
        
            //create the dictionary object that will be sent as json
            NSDictionary *dict = [self getDict: [dbLocs objectAtIndex:index] ];
        
            //add the location dictionary
            //to the locations array
            [locations addObject:dict];
        }
    }
    
    return locations;
}

#pragma mark - Post

-(void)postLocations:(NSArray *)dbLocations{
    //build up request url
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:
                                    [NSURL URLWithString:SERVER_LOCATION_UPDATE_URL]];
    //add Method
    [request setHTTPMethod:@"POST"];
    
    //get all the locations in the proper format
    //in dictionaries all within an array
    NSArray *locations = [self getLocations:dbLocations];
    
    NSMutableDictionary *json = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 @"1", @"rider_id", //rider's id
                                 locations, @"locations", //locations array full of locations
                                 [[UIDevice currentDevice] batteryLevel], @"battery", //current battery level
                                 nil];
    
    
    NSError *writeError = nil;
    //serialize the dictionary into json
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&writeError];
    
    //set data as the POST body
    [request setHTTPBody:data];
    
    //add Value to the header
    [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    
}

#pragma mark - ServiceConnectorDelegate -

-(void)requestReturnedData:(NSData *)data{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    NSLog(@"The Server Returned: %@", json);
}



#pragma mark - Data connection delegate -

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    _receivedData = data;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed with error: %@", error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"Request Complete, received %d bytes of data", _receivedData.length);
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_receivedData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    NSLog(@"The Server Returned: %@", json);

    
    //send the data to the delegate
    [self.delegate requestReturnedData:_receivedData];
}


@end
