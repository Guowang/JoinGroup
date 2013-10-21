//
//  JGEventsCollectionViewController.m
//  JoinGroup
//
//  Created by Meng Qi on 4/29/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGEventsCollectionViewController.h"
#import <Parse/Parse.h>
#import "JGEventCollectionViewCell.h"

@interface JGEventsCollectionViewController ()
@property (nonatomic,strong) UINavigationController *navController;

@end

@implementation JGEventsCollectionViewController

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
    self.navController = [[UINavigationController alloc] init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonAction:)];
	// Do any additional setup after loading the view.
}

- (void)cancelButtonAction:(id)sender {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForCollection
{
    return [PFQuery queryWithClassName:@"Event"];
}

# pragma mark - Collection View data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    JGEventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Foo" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:[object[@"color"][@"red"] floatValue]
                                           green:[object[@"color"][@"green"] floatValue]
                                            blue:[object[@"color"][@"blue"] floatValue]
                                           alpha:1];
    
    //    [(UILabel *)[cell viewWithTag:1] setText:object[@"title"]];
    [cell.cellLabel setText:object[@"title"]];
    NSLog(@"%@", object[@"title"]);
    return cell;
}


@end
