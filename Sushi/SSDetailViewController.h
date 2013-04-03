//
//  SSDetailViewController.h
//  Sushi
//
//  Created by Tianyu Liu on 3/31/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sushi.h"
#import "MBProgressHUD.h"

@interface SSDetailViewController : UIViewController <MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *sushiImage;
@property (weak, nonatomic) IBOutlet UILabel *enameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jnameLabel;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIButton *star;

@property (nonatomic, strong) Sushi *sushi;

- (IBAction)starTapped:(id)sender;

@end
