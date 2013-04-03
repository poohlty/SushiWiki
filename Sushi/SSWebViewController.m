//
//  SSWebViewController.m
//  Sushi
//
//  Created by Tianyu Liu on 4/1/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import "SSWebViewController.h"

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
    
    NSString *gFormat = [self.sushiName stringByReplacingOccurrencesOfString:@" "
                                                             withString:@"+"];
    
    NSString *urlString = [NSString stringWithFormat: @"https://www.google.com/search?q=%@&ie=UTF-8&oe=UTF-8&hl=en&client=safari",gFormat];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
    [webView loadRequest:request];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
