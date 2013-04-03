//
//  SSDetailViewController.m
//  Sushi
//
//  Created by Tianyu Liu on 3/31/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import "SSDetailViewController.h"
#import "SSWebViewController.h"

@interface SSDetailViewController ()

@end

@implementation SSDetailViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arches"]];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *tempFav = [standardUserDefaults arrayForKey:@"favourite"];
    
    self.title = self.sushi.name;
    self.sushiImage.image = [UIImage imageNamed:self.sushi.imageName];
    self.enameLabel.text = self.sushi.name;
    self.description.text = self.sushi.description;
    
    if ([tempFav containsObject: self.sushi.name]) {
        UIImage *starImage = [UIImage imageNamed:@"filled-star-icon"];
        [self.star setImage:starImage forState:UIControlStateNormal];
    } else {
        UIImage *starImage = [UIImage imageNamed:@"empty-star-icon"];
        [self.star setImage:starImage forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"googleSushi"]) {
        SSWebViewController *destViewController = segue.destinationViewController;
        destViewController.sushiName = self.sushi.name;
    }
}

- (IBAction)starTapped:(id)sender {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tempFav = [[NSMutableArray alloc]initWithArray:[standardUserDefaults arrayForKey:@"favourite"]];
    
    if ([tempFav containsObject: self.sushi.name]) {
        [tempFav removeObject:self.sushi.name];
        [standardUserDefaults setObject:tempFav forKey:@"favourite"];
        UIImage *starImage = [UIImage imageNamed:@"empty-star-icon"];
        [self.star setImage:starImage forState:UIControlStateNormal];
        [self showWithCustomView:@"Unliked"];
        
    } else {
        
        [tempFav addObject:self.sushi.name];
        [standardUserDefaults setObject:tempFav forKey:@"favourite"];
        UIImage *starImage = [UIImage imageNamed:@"filled-star-icon"];
        [self.star setImage:starImage forState:UIControlStateNormal];
        [self showWithCustomView:@"Liked"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"favSushiChanged" object:nil];
}

- (void)showWithCustomView:(NSString *)message {
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	HUD.delegate = self;
	HUD.labelText = message;
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:0.6];
}

//- (void)shareTapped{
//    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        
//        [controller setInitialText:@"Check out my recipes!"];
//            [controller addImage:[UIImage imageNamed:recipePhoto]];
//            
//        [self presentViewController:controller animated:YES completion:Nil];
//    }
//}


@end
