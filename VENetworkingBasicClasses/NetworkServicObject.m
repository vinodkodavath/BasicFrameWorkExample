//
//  NetworkServicObject.m
//  ItsTomato
//
//  Created by Tvisha Technologies on 1/13/17.
//  Copyright © 2017 Tvisha Technologies. All rights reserved.
//

#import "NetworkServicObject.h"
#import "URL.h"

@interface NetworkServicObject (){
    NSURLSessionDataTask *loginDataTask1;
}
@property (nonatomic) UIViewController *presentController;
@property (nonatomic, strong)NetworkCompletioHandlerAction NetworkServiceBlock;
@end

@implementation NetworkServicObject

-(void)NetworkCallingOnUrl:(NSString *)_URL withKeys:(NSArray *)_keys andWithValues:(NSArray *)_val OperatingWithin:(UIViewController *)_Controller{
    
    self.presentController = _Controller;
    
    if (_keys.count != _val.count) {
        return;
    }
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] initWithURL:
                                   [NSURL URLWithString:_URL]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", [[[UIDevice currentDevice] identifierForVendor]UUIDString]];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    
    //JSON Data
    //data
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", [[[UIDevice currentDevice] identifierForVendor]UUIDString]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (int i=0; i<_keys.count; i++) {
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[_keys objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",[_val objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", [[[UIDevice currentDevice] identifierForVendor]UUIDString]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    
//    NSLog(@"data Length : %@",postLength);
//    NSString *charlieSendString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
//    NSLog(@"data sending - > %@",charlieSendString);
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:_URL]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [NSThread sleepForTimeInterval:.2];
    // post the request and handle response
    NSURLSessionDataTask *loginDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
//                                               NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                               NSLog(@"data sending - > %@",charlieSendString);                                      NSLog(@"erro%@",[error description]);
                                               
                                               if ([error code] == -1005) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},Diconnect);
                                                   return;
                                               }
                                               else if ([error code] == -999) {
                                                   // @"Please Try   again"
                                                   return;
                                               }
                                               else if ([error code] == -1004) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1009) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},noInternet);
                                                   return;
                                               }
                                               else if ([error code] == -1001) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},TimeUp);
                                                   return;
                                               }
                                               else
                                               {
                                                   if (data != nil) {
                                                       [self recivingJSONData:data withError:error];
                                                   }
                                               }
                                           }];
    [loginDataTask resume];
}

-(void)NetworkCallingOnUrl:(NSString *)_URL withKeys:(NSArray *)_keys andWithValues:(NSArray *)_val ImgData:(NSData *)_data OperatingWithin:(UIViewController *)_Controller
{
    self.presentController = _Controller;
    
    if (_keys.count != _val.count) {
        return;
    }
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] initWithURL:
                                   [NSURL URLWithString:_URL]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", [[[UIDevice currentDevice] identifierForVendor]UUIDString]];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    
    //JSON Data
    //data
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", [[[UIDevice currentDevice] identifierForVendor]UUIDString]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (int i=0; i<_keys.count-1; i++) {
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[_keys objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",[_val objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", [[[UIDevice currentDevice] identifierForVendor]UUIDString]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n", [_keys objectAtIndex:_keys.count-1],[_val objectAtIndex:_val.count-1]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:_data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", [[[UIDevice currentDevice] identifierForVendor]UUIDString]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    
    //    NSLog(@"data Length : %@",postLength);
    //    NSString *charlieSendString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    //    NSLog(@"data sending - > %@",charlieSendString);
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:_URL]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [NSThread sleepForTimeInterval:.2];
    // post the request and handle response
    NSURLSessionDataTask *loginDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
//                                               NSLog(@"erro%@",[error description]);
                                               if ([error code] == -1005) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},Diconnect);
                                                   return;
                                               }
                                               else if ([error code] == -999) {
                                                   // @"Please Try   again"
                                                   return;
                                               }
                                               else if ([error code] == -1004) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1009) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},noInternet);
                                                   return;
                                               }
                                               else if ([error code] == -1001) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else
                                               {
                                                   if (data != nil) {
                                                       [self recivingJSONData:data withError:error];
                                                   }
                                               }
                                           }];
    [loginDataTask resume];
}


-(void)recivingJSONData:(NSData *)data withError:(NSError *)error
{
    NSMutableDictionary *jsonResponse = [[NSMutableDictionary alloc] init];
    jsonResponse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

//    NSLog(@"json responce : %@",jsonResponse);
//    NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"data sending - > %@",charlieSendString);                                      NSLog(@"erro%@",[error description]);
//
    
    if (jsonResponse == nil){
//        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"" message:@"Please Enter a Valid Mobile Number" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//        {
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:ok];
//        [self.presentController presentViewController:alert animated:YES completion:nil];
        
        
        [self CustomToastMethod:@"Please try again after sometime"];
    }
    if([[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"success"]] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"success"]] isEqualToString:@"true"]|| [[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"e"]] isEqualToString:@"0"])
    {//when success
        self.NetworkServiceBlock(jsonResponse,NetworkSuccess);
    }
    else
    {//when success is failure
        self.NetworkServiceBlock(jsonResponse,NoSuccess);
        return;
    }
}

-(void)CallingNetworkCallingOnUrl:(NSString *)_URL withKeys:(NSArray *)_keys andWithValues:(NSArray *)_val OperatingWithin:(UIViewController *)_Controller{
    
    self.presentController = _Controller;
    
    if (_keys.count != _val.count) {
        return;
    }
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] initWithURL:
                                   [NSURL URLWithString:_URL]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSMutableData *body = [NSMutableData data];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    NSMutableString *bodyStr = [[NSMutableString alloc] init];
    NSMutableString *dataStr = [[NSMutableString alloc] init];
    
    for (int i=0; i<_keys.count; i++) {
        [dataStr appendString:[NSString stringWithFormat:@"%@=%@",[_keys objectAtIndex:i],[_val objectAtIndex:i]]];
        if (_keys.count-1 != i) {
            [dataStr appendString:@"&"];
        }
    }
//    NSLog(@"the data string is %@",dataStr);
//    NSLog(@"url -> %@",_URL);
    [request setURL:[NSURL URLWithString:_URL]];
    [body appendData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
//    NSLog(@"Request body %@ ***", [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
   
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
//     NSLog(@"Request length   %@ ***",postLength);
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *loginDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
//
//                                               NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                                                                                      NSLog(@"data reciveing - > %@",charlieSendString);
////                                               NSLog(@"%@",[error description]);
                                               if ([error code] == -1005) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},Diconnect);
                                                   return;
                                               }
                                               else if ([error code] == -999) {
                                                   // @"Please Try   again"
                                                   return;
                                               }
                                               else if ([error code] == -1009) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},noInternet);
                                                   return;
                                               }
                                               else if ([error code] == -1004) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1001) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"message"                                       : @"Something went wrong try again"},TimeUp);
                                                   return;
                                               }
                                               else
                                               {
                                                   if (data != nil) {
                                                       
//                                                            NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                                                                                              NSLog(@"data reciveing - > %@",charlieSendString);

                                                       [self recivingJSONData:data withError:error];
                                                   }
                                               }
                                           }];
    [loginDataTask resume];
}
-(void)StopTask
{
    [loginDataTask1 cancel];
}
-(void)CustomizedNetworkCallingOnUrl:(NSString *)_URL withKeys:(NSArray *)_keys andWithValues:(NSArray *)_val WithType:(NSString *)_type OperatingWithin:(UIViewController *)_Controller
{
    self.presentController = _Controller;
    
    if (_keys.count != _val.count) {
        return;
    }
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] initWithURL:
                                   [NSURL URLWithString:_URL]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSMutableData *body = [NSMutableData data];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPMethod:_type];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    //    NSMutableString *bodyStr = [[NSMutableString alloc] init];
    NSMutableString *dataStr = [[NSMutableString alloc] init];
    
    for (int i=0; i<_keys.count; i++) {
        if ([[_keys objectAtIndex:i] isEqualToString:@"uid"])
        {
            [dataStr appendString:[NSString stringWithFormat:@"%@=%d",[_keys objectAtIndex:i],[[_val objectAtIndex:i]intValue]]];
        }
        else
        {
             [dataStr appendString:[NSString stringWithFormat:@"%@=%@",[_keys objectAtIndex:i],[_val objectAtIndex:i]]];
        }
        if (_keys.count-1 != i) {
            [dataStr appendString:@"&"];
        }
    }
//    NSLog(@"the data string is %@",dataStr);

    [request setURL:[NSURL URLWithString:_URL]];
    [body appendData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
//    NSLog(@"Request body %@ ***", [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
//    NSLog(@"Request length   %@ ***",postLength);
    
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    loginDataTask1 = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
//                                               NSLog(@"%@",[error description]);
                                               if ([error code] == -1005) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},Diconnect);
                                                   return;
                                               }
                                               else  if ([error code] == -1002) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -999) {
                                                   // @"Please Try   again"
                                                   return;
                                               }
                                               else if ([error code] == -1009) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},noInternet);
                                                   return;
                                               }
                                               else if ([error code] == -2102) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1001) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1004) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else
                                               {
                                                   if (data != nil) {
                                                       
                                                       //NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                                       NSLog(@"data reciveing - > %@",charlieSendString);
                                                       
                                                       [self recivingJSONData:data withError:error];
                                                   }
                                               }
                                           }];
    [loginDataTask1 resume];
}
-(void)NetworkServiceCompleted:(nullable NetworkCompletioHandlerAction)completionHandler
{
    self.NetworkServiceBlock = completionHandler;
}

-(void)RawDataAddressNetworkCallingOnUrl:(NSString *)_URL withString:(NSString *)_Data WithType:(NSString *)_type OperatingWithin:(UIViewController *)_Controller
{
//    NSLog(@"%@",_Data);
    self.presentController = _Controller;
    NSData *postData = [_Data dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    if(_type.length !=0)
    {
    [request setValue:_type forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    }
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error)
    {
        //error
    }
    else
    {
        //no error
        
        //NSString *charlieSendString = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
//            NSLog(@"data sending - > %@",charlieSendString);
        
        
        //jsonResponse = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *jsonResponse=[NSJSONSerialization JSONObjectWithData:retData options:NSJSONReadingAllowFragments error:&error];
//        NSLog(@"%@",jsonResponse);
        if (jsonResponse == nil)
        {
            [self CustomToastMethod:@"Please try again after sometime"];
        }
        if([[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"em"]] isEqualToString:@"success"] || [[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"success"]] isEqualToString:@"true"] || [[jsonResponse valueForKey:@"success"] isEqualToString:@"0"])
        {//when success
            self.NetworkServiceBlock(jsonResponse,NetworkSuccess);
        }
        else
        {//when success is failure
            self.NetworkServiceBlock(jsonResponse,NoSuccess);
            return;
        }
    }
}
-(void)CustomToastMethod:(NSString *)_msg{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    
//    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:_msg];
//    [hogan addAttribute:NSFontAttributeName
//                  value:[UIFont systemFontOfSize:25.0]
//                  range:NSMakeRange(_msg.length+1, 0)];
//    [alertController setValue:hogan forKey:@"attributedMessage"];
//    
//    [self.presentController presentViewController:alertController animated:YES completion:nil];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alertController dismissViewControllerAnimated:YES completion:^{
//        }];
//    });
    
//    NSLog(@"custome tost msg: %@",_msg);
    
    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        alert = [[SCLAlertView alloc] init];
//        alert.showAnimationType = SCLAlertViewHideAnimationSlideOutToCenter;
//        alert.hideAnimationType = SCLAlertViewHideAnimationSlideOutFromCenter;
//        UIColor *color = [CustomColors colorFromHexString:ButtonsColor1];
//        alert.TopCircleColor = [UIColor whiteColor];
//        [alert showCustom:self.presentController image:[UIImage imageNamed:@"logo_icon"] color:color title:nil subTitle:_msg closeButtonTitle:@"OK" duration:4.0f];
//    });
    
}
-(void)GETNetworkCallingOnUrl:(NSString *)_URL withKeys:(NSArray *)_keys andWithValues:(NSArray *)_val OperatingWithin:(UIViewController *)_Controller
{
    self.presentController = _Controller;
    if (_keys.count != _val.count) {
        return;
    }
    
//    NSLog(@"the url is %@",_URL);
//    NSLog(@"the url is %@",_val);
//    NSLog(@"the url is %@",_keys);
    
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPMethod:@"GET"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableString *dataStr = [[NSMutableString alloc] init];
    for (int i=0; i<_keys.count; i++) {
        [dataStr appendString:[NSString stringWithFormat:@"%@=%@",[_keys objectAtIndex:i],[_val objectAtIndex:i]]];
        if (_keys.count-1 != i) {
            [dataStr appendString:@"&"];
        }
    }
//    NSLog(@"the data string is %@%@",_URL,dataStr);
    
//    NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_URL,dataStr]]);
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_URL,dataStr]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *loginDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
//                                               NSLog(@"%@",[error description]);
                                               if ([error code] == -1005) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},Diconnect);
                                                   return;
                                               }
                                               else if ([error code] == -999) {
                                                   // @"Please Try   again"
                                                   return;
                                               }
                                               else if ([error code] == -1009) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},noInternet);
                                                   return;
                                               }
                                               else if ([error code] == -1001) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1004) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else
                                               {
                                                   if (data != nil) {
                                                       
                                                       //NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                                       NSLog(@"data reciveing - > %@",charlieSendString);
                                                       
                                                       [self recivingJSONData:data withError:error];
                                                   }
                                               }
                                           }];
    [loginDataTask resume];
}

-(void)GETNetworkCallingOnUrl:(NSString *)_URL withKeysHeader:(NSArray *)_keys andWithValuesHeader:(NSArray *)_val OperatingWithin:(UIViewController *)_Controller
{
    self.presentController = _Controller;
    if (_keys.count != _val.count) {
        return;
    }
    
//    NSLog(@"the url is %@",_URL);
//    NSLog(@"the url is %@",_val);
//    NSLog(@"the url is %@",_keys);
    
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPMethod:@"GET"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSMutableString *dataStr = [[NSMutableString alloc] init];
    for (int i=0; i<_keys.count; i++) {
        [request setValue:[_val objectAtIndex:i] forHTTPHeaderField:[_keys objectAtIndex:i]];
    }
//    NSLog(@"the data string is %@%@",_URL,dataStr);
    
//    NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_URL,dataStr]]);
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_URL,dataStr]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *loginDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
//                                               NSLog(@"%@",[error description]);
                                               if ([error code] == -1005) {
                                                   //network connection failure
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},Diconnect);
                                                   return;
                                               }
                                               else if ([error code] == -999) {
                                                   // @"Please Try   again"
                                                   return;
                                               }
                                               else if ([error code] == -1009) {
                                                   //@"internet connection not avilable"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},noInternet);
                                                   return;
                                               }
                                               else if ([error code] == -1001) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else if ([error code] == -1004) {
                                                   //@"connection timed out"
                                                   self.NetworkServiceBlock(@{
                                                                              @"Data"                                       : @"no"},TimeUp);
                                                   return;
                                               }
                                               else
                                               {
                                                   if (data != nil) {
                                                       
                                                       //NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                                       NSLog(@"data reciveing - > %@",charlieSendString);
                                                       
                                                       [self recivingJSONData:data withError:error];
                                                   }
                                               }
                                           }];
    [loginDataTask resume];
}


//-(void)RawDataAddressNetworkCallingOnUrl:(NSString *)_URL withString:(NSString *)_Data WithType:(NSString *)_type OperatingWithin:(UIViewController *)_Controller
//{
//    NSLog(@"%@",_Data);
//    
//    
//    
//    self.presentController = _Controller;
//    NSData *postData = [_Data dataUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:_URL];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:_type forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    NSError *error = nil;
//    NSHTTPURLResponse *response = nil;
//    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (error)
//    {
//        //error
//    }
//    else
//    {
//        //no error
//        //        NSString *charlieSendString = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
//            //            NSLog(@"data sending - > %@",charlieSendString);
//        NSMutableDictionary *jsonResponse = [[NSMutableDictionary alloc] init];
//        jsonResponse=[NSJSONSerialization JSONObjectWithData:retData options:NSJSONReadingAllowFragments error:&error];
//        
//    
//        NSString *charlieSendString = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
//        NSLog(@"data sending - > %@",charlieSendString);
//     
//        
//        NSLog(@"%@",jsonResponse);
//        
//        
//        
//        if (jsonResponse == nil)
//        {
//            [self CustomToastMethod:@"Please try agin after Sometime"];
//        }
////        if([[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"em"]] isEqualToString:@"success"] || [[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"success"]] isEqualToString:@"true"])
//        
//        if([[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"em"]] isEqualToString:@"success"])
//        {
//            //when success
//            
////            paymentGatewayViewController *ToVc = [[paymentGatewayViewController alloc] init];
////           
////            [self pushViewController:ToVc animated:NO];
////            return;
//            
//        [self buyBookrecivingJSONData:retData withError:error];
////           self.NetworkServiceBlock(jsonResponse,NetworkSuccess);
//        }
//        else
//        {//when success is failure
////            self.NetworkServiceBlock(jsonResponse,NoSuccess);
//            [self CustomToastMethod:@"Please after some time"];
//            return;
//        }
//    }
//}
//
//-(void)buyBookrecivingJSONData:(NSData *)data withError:(NSError *)error
//{
//    NSMutableDictionary *jsonResponse = [[NSMutableDictionary alloc] init];
//    jsonResponse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    //NSLog(@"%@",jsonResponse);
//    if (jsonResponse == nil)
//    {
//        [self CustomToastMethod:@"Please try agin after Sometime"];
//    }
//    if([[NSString stringWithFormat:@"%@",[jsonResponse valueForKey:@"em"]] isEqualToString:@"success"])
//    {//when success
//        self.NetworkServiceBlock(jsonResponse,NetworkSuccess);
//    }
//    else
//    {//when success is failure
//        self.NetworkServiceBlock(jsonResponse,NoSuccess);
//        return;
//    }
//}
@end
