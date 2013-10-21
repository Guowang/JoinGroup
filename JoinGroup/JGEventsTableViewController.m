//
//  JGEventsTableViewController.m
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGEventsTableViewController.h"

@interface JGEventsTableViewController ()

@end

@implementation JGEventsTableViewController

@synthesize groupItems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Event";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
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
    PFRelation *groupPhotoRelation = [self.groupItems relationforKey:@"hasEvents"];
    PFQuery *query = [groupPhotoRelation query];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"eventDate"];
    
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
    
    // Configure the cell
    
    
    // load the author photo
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
                            [[cell.imageView layer] setFrame:CGRectMake(5,5,65,65)];
                            [[cell.imageView layer] setCornerRadius:10.0];
                            [cell.imageView setClipsToBounds:YES];                            cell.textLabel.text = [NSString stringWithFormat:@"%@ By %@",
                                                   [object objectForKey:@"title"], [user objectForKey:@"username"]];
                            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"details"]];
                        }
                    }];
                }
            }];
        }
    }];
    /*
    [cell setBackgroundColor:[UIColor clearColor]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor grayColor]CGColor], nil];
    [cell.layer addSublayer:gradient];
    [gradient setOpacity:0.04f];
     */
    cell.textLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16.0];
    cell.textLabel.textColor = [UIColor colorWithRed:0.427 green:0.38 blue:0.314 alpha:1.0];
    UIView *goldenColor = [[UIView alloc] init];
    goldenColor.backgroundColor = [UIColor colorWithRed:0.824 green:0.749    blue:0.553 alpha:0.70];
    cell.selectedBackgroundView = goldenColor;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return 75.0f;
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    UIStoryboard *myStb= self.stb;
    JGForumViewController *forumViewController = [myStb instantiateViewControllerWithIdentifier:@"DiscussionsID"];
    NSInteger index = [self.tableView.indexPathForSelectedRow row];
    forumViewController.groupItems = self.groupItems;
    forumViewController.eventItems = [self.objects objectAtIndex:index];
    [self.eventViewController presentModalViewController:forumViewController animated:YES];
}

@end
