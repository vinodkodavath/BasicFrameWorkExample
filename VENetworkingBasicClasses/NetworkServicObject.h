//
//  NetworkServicObject.h
//  ItsTomato
//
//  Created by Tvisha Technologies on 1/13/17.
//  Copyright © 2017 Tvisha Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define noInternet @"No Internet"
#define TimeUp @"Time out"
#define Diconnect @"Connection Disconnected"
#define NoSuccess @"false"
#define NetworkSuccess @"true"

typedef void (^NetworkCompletioHandlerAction) (NSDictionary  * _Nullable json, NSString * _Nullable outCome);
@interface NetworkServicObject : NSObject
{
    NSDictionary *xmlDataDict;
    NSMutableArray *XmlDataArray;
    NSString *datastr;
}

-(void)NetworkCallingOnUrl:(NSString *_Nullable)_URL withKeys:(NSArray *_Nullable)_keys andWithValues:(NSArray *_Nullable)_val OperatingWithin:(UIViewController *_Nullable)_Controller;
-(void)NetworkCallingOnUrl:(NSString *_Nullable)_URL withKeys:(NSArray *_Nullable)_keys andWithValues:(NSArray *_Nullable)_val ImgData:(NSData *_Nullable)_data OperatingWithin:(UIViewController *_Nullable)_Controller;


-(void)NetworkServiceCompleted:(nullable NetworkCompletioHandlerAction)completionHandler;
-(void)CallingNetworkCallingOnUrl:(NSString *_Nullable)_URL withKeys:(NSArray *_Nullable)_keys andWithValues:(NSArray *_Nullable)_val OperatingWithin:(UIViewController *_Nullable)_Controller;
-(void)CustomToastMethod:(NSString *_Nullable)_msg;
-(void)CustomizedNetworkCallingOnUrl:(NSString *_Nullable)_URL withKeys:(NSArray *_Nullable)_keys andWithValues:(NSArray *_Nullable )_val WithType:(NSString *_Nullable)_type OperatingWithin:(UIViewController *_Nullable)_Controller;
-(void)GETNetworkCallingOnUrl:(NSString *_Nullable)_URL withKeys:(NSArray *_Nullable)_keys andWithValues:(NSArray *_Nullable)_val OperatingWithin:(UIViewController *_Nullable)_Controller;
-(void)RawDataAddressNetworkCallingOnUrl:(NSString *_Nullable)_URL withString:(NSString *_Nullable)_Data WithType:(NSString *_Nullable)_type OperatingWithin:(UIViewController *_Nullable)_Controller;
-(void)GETNetworkCallingOnUrl:(NSString *_Nullable)_URL withKeysHeader:(NSArray *_Nullable)_keys andWithValuesHeader:(NSArray *_Nullable)_val OperatingWithin:(UIViewController *_Nullable)_Controller;

-(void)StopTask;
@end

/*erro codes for nsurl connetion
 
 kCFURLErrorUnknown   = -998,
 kCFURLErrorCancelled = -999,
 kCFURLErrorBadURL    = -1000,
 kCFURLErrorTimedOut  = -1001,
 kCFURLErrorUnsupportedURL = -1002,
 kCFURLErrorCannotFindHost = -1003,
 kCFURLErrorCannotConnectToHost    = -1004,
 kCFURLErrorNetworkConnectionLost  = -1005,
 kCFURLErrorDNSLookupFailed        = -1006,
 kCFURLErrorHTTPTooManyRedirects   = -1007,
 kCFURLErrorResourceUnavailable    = -1008,
 kCFURLErrorNotConnectedToInternet = -1009,
 kCFURLErrorRedirectToNonExistentLocation = -1010,
 kCFURLErrorBadServerResponse             = -1011,
 kCFURLErrorUserCancelledAuthentication   = -1012,
 kCFURLErrorUserAuthenticationRequired    = -1013,
 kCFURLErrorZeroByteResource        = -1014,
 kCFURLErrorCannotDecodeRawData     = -1015,
 kCFURLErrorCannotDecodeContentData = -1016,
 kCFURLErrorCannotParseResponse     = -1017,
 kCFURLErrorInternationalRoamingOff = -1018,
 kCFURLErrorCallIsActive               = -1019,
 kCFURLErrorDataNotAllowed             = -1020,
 kCFURLErrorRequestBodyStreamExhausted = -1021,
 kCFURLErrorFileDoesNotExist           = -1100,
 kCFURLErrorFileIsDirectory            = -1101,
 kCFURLErrorNoPermissionsToReadFile    = -1102,
 kCFURLErrorDataLengthExceedsMaximum   = -1103,
 
 */
