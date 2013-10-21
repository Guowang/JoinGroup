//
//  JGGroupViewController.m
//  JoinGroup
//
//  Created by user on 2/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGGroupViewController.h"

@interface JGGroupViewController ()

@end

@implementation JGGroupViewController

@synthesize groupTableViewController;
@synthesize viewButton;
@synthesize imageData;
@synthesize navController;

- (IBAction)done:(UIStoryboardSegue *)segue
{
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
}

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
    
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"user"];
    [query whereKey:@"objectId" equalTo:user.objectId];
    // Create request for user's Facebook data
    FBRequest *request = [FBRequest requestForMe];
    
    // Send request to Facebook
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *gender = userData[@"gender"];
            
            if (name != nil) {
                [user setObject:name forKey:@"username"];
            }
            
            if (gender != nil) {
                if ([gender isEqualToString:@"male"]) {
                    [user setObject:[[NSNumber alloc] initWithInt:0] forKey:@"Gender"];
                }
                else {
                    [user setObject:[[NSNumber alloc] initWithInt:1] forKey:@"Gender"];
                }
            }
            
            PFRelation *profilePhotoRelation = [user relationforKey:@"ProfilePhoto"];
            PFQuery *queryPhoto = [profilePhotoRelation query];
            [queryPhoto findObjectsInBackgroundWithBlock:^(NSArray *photoResults, NSError *error) {
                // results contains photo for the group
                // NSLog(@"there are %d photos for the group", [results count]);
                if (!error && [photoResults count] == 0) {
                    // Download the user's facebook profile picture
                    self.imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
                    
                    // URL should point to https://graph.facebook.com/{facebookId}/picture?type=large&return_ssl_resources=1
                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                    
                    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                          timeoutInterval:10.0f];
                    // Run network request asynchronously
                    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
                }
            }];
        }
    }];

    [[JGLocationController sharedItem] currentLocation];
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    UIImage* groupImage = [UIImage imageNamed:@"group2.png"];
    UITabBarItem *groupItem = [tabBar.items objectAtIndex:0];
    [groupItem setFinishedSelectedImage:groupImage withFinishedUnselectedImage:groupImage];
    [groupItem setTitle:@"Groups"];
    
    UIImage* forumImage = [UIImage imageNamed:@"event.png"];
    UITabBarItem *forumItem = [tabBar.items objectAtIndex:1];
    [forumItem setFinishedSelectedImage:forumImage withFinishedUnselectedImage:forumImage];
    [forumItem setTitle:@"Events"];
    
    UIImage* profileImage = [UIImage imageNamed:@"me.png"];
    UITabBarItem *profileItem = [tabBar.items objectAtIndex:2];
    [profileItem setFinishedSelectedImage:profileImage withFinishedUnselectedImage:profileImage];
    [profileItem setTitle:@"Me"];
    
    self.groupTableViewController = [[JGGroupTableViewController alloc] init];
    [groupTableViewController.tableView setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 500.0f)];
    [self.view addSubview:groupTableViewController.tableView];
    self.groupTableViewController.stb = self.storyboard;
    self.groupTableViewController.groupViewController = self;
}

// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    UIImage *anImage = [UIImage imageWithData:self.imageData];
    if (anImage != nil) {        
        JGProfilePictureEditViewController *viewController = [[JGProfilePictureEditViewController alloc] initWithImage:anImage];
        [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        [self.navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self.navController pushViewController:viewController animated:NO];
        
        [self presentModalViewController:self.navController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
