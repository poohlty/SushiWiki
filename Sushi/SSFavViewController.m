//
//  SSFavViewController.m
//  Sushi
//
//  Created by Tianyu Liu on 4/1/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import "SSFavViewController.h"
#import "Sushi.h"
#import "SSDetailViewController.h"

@interface SSFavViewController ()

@end

@implementation SSFavViewController{
    UIImageView *placeholderImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //customize the background with pattern
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste"]];
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadSushi)
                                                 name:@"favSushiChanged"
                                               object:nil];
    
    placeholderImage = [[UIImageView alloc] init];
    placeholderImage.frame = CGRectMake(60, 153, 200, 150);
    placeholderImage.image = [UIImage imageNamed:@"placeholder"];
    
    [self.view addSubview:placeholderImage];
    
    [self loadSushi];
}

- (void)loadSushi{
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *tempFav = [standardUserDefaults arrayForKey:@"favourite"];
    
    //initialize temp array to store avaliable sushi
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sushi" ofType:@"plist"];
    NSArray *data =[[NSArray alloc] initWithContentsOfFile:path];
    
    //initilize sushi property
    NSMutableArray *tempSushi = [[NSMutableArray alloc]init];
    for (NSDictionary *sushi in data) {
        if ([tempFav containsObject:sushi[@"name"]]) {
            Sushi *newSushi = [[Sushi alloc]initWithName:sushi[@"name"]
                                             description:sushi[@"description"]
                                               imageName:sushi[@"imageName"]];
            [tempSushi addObject:newSushi];
        }
    }
    self.sushi = [[NSArray alloc]initWithArray:tempSushi];
    [self.collectionView reloadData];
    
    if (self.sushi.count == 0) {
        placeholderImage.hidden = NO;
    } else {
        placeholderImage.hidden = YES;
    }
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
    static NSString *identifier = @"FavCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:11];
    UILabel *sushiLabel = (UILabel *)[cell viewWithTag:13];
    
    recipeImageView.image = [UIImage imageNamed:[self.sushi[indexPath.row] imageName]];
    sushiLabel.text = [self.sushi[indexPath.row] name];
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushSushiDetail2"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        SSDetailViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destViewController.sushi = self.sushi[indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
