//
//  SSWebViewController.h
//  Sushi
//
//  Created by Tianyu Liu on 4/1/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) NSString *sushiName;

@end
