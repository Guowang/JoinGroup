//
//  JGForumAddPostViewController.m
//  JoinGroup
//
//  Created by user on 4/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGForumAddPostViewController.h"
#import <Parse/Parse.h>

@interface JGForumAddPostViewController ()

@end

@implementation JGForumAddPostViewController
@synthesize eventItems;

- (BOOL)textFieldShouldReturn:(UITextField *)postTextField {
    if (postTextField == self.postInput) {
        [postTextField resignFirstResponder];
    }
    return YES;
}

-(IBAction)addNewPost:(id)sender
{
    if ([self.postInput.text length] && self.eventItems) {
        NSDate *today = [NSDate date];
        PFUser *user = [PFUser currentUser];
        PFObject *postObject = [PFObject objectWithClassName:@"Post"];
        [postObject setObject:self.postInput.text forKey:@"content"];
        [postObject setObject:today forKey:@"postDate"];
        [postObject save];
        PFRelation *authorRelation = [postObject relationforKey:@"author"];
        [authorRelation addObject:user];
        PFRelation *eventRelation = [postObject relationforKey:@"inEvent"];
        [eventRelation addObject:self.eventItems];
        [postObject save];
        PFRelation *postRelation = [self.eventItems relationforKey:@"hasPosts"];
        [postRelation addObject:postObject];
        [self.eventItems save];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Posted!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
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
	// Do any additional setup after loading the view.
    [self.postInput setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
}

- (void)backgroundTouchedHideKeyboard:(id)sender
{
    [self.postInput resignFirstResponder];
    [self viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
