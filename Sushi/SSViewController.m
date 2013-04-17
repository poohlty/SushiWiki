//
//  SSViewController.m
//  Sushi
//
//  Created by Tianyu Liu on 3/26/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import "SSViewController.h"
#import "SSDetailViewController.h"
#import "Sushi.h"

@interface SSViewController ()

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //customize the background and bars
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste"]];
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    //initialize temp array to store avaliable sushi
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sushi" ofType:@"plist"];
    NSArray *data =[[NSArray alloc] initWithContentsOfFile:path];
    
    //initilize sushi property
    NSMutableArray *tempSushi = [[NSMutableArray alloc]init];
    for (NSDictionary *sushi in data) {
        Sushi *newSushi = [[Sushi alloc]initWithName:sushi[@"name"]
                                         description:sushi[@"description"]
                                           imageName:sushi[@"imageName"]];
        [tempSushi addObject:newSushi];
    }
    self.sushi = [[NSArray alloc]initWithArray:tempSushi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sushi.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:7];
    UILabel *sushiLabel = (UILabel *)[cell viewWithTag:9];
    
    recipeImageView.image = [UIImage imageNamed:[self.sushi[indexPath.row] imageName]];
    sushiLabel.text = [self.sushi[indexPath.row] name];
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushSushiDetail"]) {
        //get indexPath from selected sushi
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        //initialize the detail view controller and push it
        SSDetailViewController *destViewController = segue.destinationViewController;
        destViewController.sushi = self.sushi[indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
