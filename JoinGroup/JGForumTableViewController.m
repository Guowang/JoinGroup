//
//  JGForumTableViewController.m
//  JoinGroup
//
//  Created by user on 4/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGForumTableViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface JGForumTableViewController ()

@end

@implementation JGForumTableViewController
@synthesize eventItems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Post";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 5;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    self.tableView.backgroundView.alpha = 0.3;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query;
    if (self.eventItems) {
        PFRelation *eventRelation = [self.eventItems relationforKey:@"hasPosts"];
        query = [eventRelation query];
    }
    else {
        query = [PFQuery queryWithClassName:@"NONEXIST"];
    }
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"postDate"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //load the author photo
    PFRelation *authorPhotoRelation = [object relationforKey:@"author"];
    PFQuery *query = [authorPhotoRelation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        // results contains photo for the group
        if (!error && [results count] != 0) {
            // At this point, object has been downloaded, but the PFFile was not included
            //Find the photo object and it's Thumbnail
            PFObject *user = [results objectAtIndex:0];
            PFRelation *profilePhotoRelation = [user relationforKey:@"ProfilePhoto"];
            PFQuery *queryPhoto = [profilePhotoRelation query];
            [queryPhoto findObjectsInBackgroundWithBlock:^(NSArray *photoResults, NSError *error) {
                // results contains photo for the group
                // NSLog(@"there are %d photos for the group", [results count]);
                if (!error && [photoResults count] != 0) {
                    // At this point, object has been downloaded, but the PFFile was not included
                    //Find the photo object and it's Thumbnail
                    PFObject *photoObject = [photoResults objectAtIndex: 0];
                    PFFile *imageFile = [photoObject objectForKey:@"ThumbnailFile"];
                    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            //reform the image by the image data in Parse
                            cell.imageView.image = [UIImage imageWithData:data];
                            [[cell.imageView layer] setBorderColor:[[UIColor colorWithRed:0.9 green:0.749    blue:0.553 alpha:1] CGColor]];
                            [[cell.imageView layer] setBorderWidth:2.0];
                            [[cell.imageView layer] setCornerRadius:10.0];
                            [cell.imageView setClipsToBounds:YES];
                            cell.textLabel.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"content"]];
                            cell.detailTextLabel.text = [NSString stringWithFormat:@"By %@", [user objectForKey:@"username"]];
                        }
                    }];
                }
            }];
        }
    }];
    cell.textLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16.0];
    cell.textLabel.textColor = [UIColor colorWithRed:0.427 green:0.38 blue:0.314 alpha:1.0];
    UIView *goldenColor = [[UIView alloc] init];
    goldenColor.backgroundColor = [UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:0.70];
    cell.selectedBackgroundView = goldenColor;
    return cell;
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return 50.0f;
}
@end
