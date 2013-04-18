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
    
    //Grab favourite sushi array from standardUserDefaults
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *tempFav = [standardUserDefaults arrayForKey:@"favourite"];
    
    //Initialize information about sushi into the user interface
    self.title = self.sushi.name;
    self.sushiImage.image = [UIImage imageNamed:self.sushi.imageName];
    self.enameLabel.text = self.sushi.name;
    self.description.text = self.sushi.description;
    
    //mark the star based on the user's favourite sushi array
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
    
    //pass down sushi name and push WebViewController 
    if ([segue.identifier isEqualToString:@"googleSushi"]) {
        SSWebViewController *destViewController = segue.destinationViewController;
        destViewController.sushiName = self.sushi.name;
    }
}

- (IBAction)starTapped:(id)sender {
    
    //grab the standardUserDefault to change sushi array
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tempFav = [[NSMutableArray alloc]initWithArray:[standardUserDefaults arrayForKey:@"favourite"]];
    
    if ([tempFav containsObject: self.sushi.name]) {
        
        //if sushi is stared, remove it from the array, change the star to empty and pop notification
        [tempFav removeObject:self.sushi.name];
        [standardUserDefaults setObject:tempFav forKey:@"favourite"];
        UIImage *starImage = [UIImage imageNamed:@"empty-star-icon"];
        [self.star setImage:starImage forState:UIControlStateNormal];
        [self showWithCustomView:@"Unliked"];
        
    } else {
        
        //if sushi is unstared, do the reverse
        [tempFav addObject:self.sushi.name];
        [standardUserDefaults setObject:tempFav forKey:@"favourite"];
        UIImage *starImage = [UIImage imageNamed:@"filled-star-icon"];
        [self.star setImage:starImage forState:UIControlStateNormal];
        [self showWithCustomView:@"Liked"];
    }
    
    //post a notification to FavController and CollectionViewController to update collection view
    [[NSNotificationCenter defaultCenter] postNotificationName:@"favSushiChanged" object:nil];
}

//pop up a notification of star/unstar
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
