//
//  SSWebViewController.m
//  Sushi
//
//  Created by Tianyu Liu on 4/1/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import "SSWebViewController.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface SSWebViewController ()

@end

@implementation SSWebViewController;

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.sushiName;
    if ([self hasConnectivity]) {
        
        //if connection is avaliable, push the webviewcontroller with google
        NSString *searchString = [self.sushiName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *urlString = [NSString stringWithFormat: @"https://www.google.com/search?q=%@&ie=UTF-8&oe=UTF-8&hl=en&client=safari",searchString];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        
    } else{
        
        //No connection, pop a UIAlert with a go back button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection"
                                                        message:@"No internet connection, can't google your sushi now."
                                                       delegate:self
                                              cancelButtonTitle:@"Go back"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UIAlertDelegate Method 
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        [self.navigationController popViewControllerAnimated:YES];
}

//Check connectivity, return YES if connection is avaliable, No otherwise. Code copied from http://stackoverflow.com/questions/1083701/how-to-check-for-an-active-internet-connection-on-iphone-sdk/3597085#3597085

- (BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

@end
