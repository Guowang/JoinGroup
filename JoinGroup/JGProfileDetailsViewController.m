//
//  JGProfileDetailsViewController.m
//  JoinGroup
//
//  Created by Meng Qi on 4/15/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGProfileDetailsViewController.h"

@interface JGProfileDetailsViewController ()

@end

@implementation JGProfileDetailsViewController
@synthesize usernameLabel,usernameText,phoneText,phoneLabel,introductionText,genderLabel,ageLabel,ageText,tabBar;

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
    [self.usernameText setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
    [self.phoneText setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
    [self.introductionText setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
    [self.ageText setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
   
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    NSString *username = [NSString stringWithFormat:@"UserName: %@", [user objectForKey:@"username"]];
    NSString *phone = [NSString stringWithFormat:@"Phone: %@", [user objectForKey:@"additional"]];
    NSString *age = [NSString stringWithFormat:@"Age: %@", [user objectForKey:@"Age"]];
    NSString *gender = [NSString stringWithFormat:@"Gender: "];
    if([[user objectForKey:@"Gender"] boolValue]) gender = [NSString stringWithFormat:@"Gender: Female"];
    else  gender = [NSString stringWithFormat:@"Gender: male"];
    
    [self.usernameLabel setText: username];
    [self.phoneLabel setText:phone];
    [self.ageLabel setText:age];
    [self.genderLabel setText:gender];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"doneBackToProfile"]) {
        PFUser *user = [PFUser currentUser];
        if(usernameText.text.length)[user setValue: self.usernameText.text forKey:@"username"];
        if(phoneText.text.length)[user setValue: self.phoneText.text forKey:@"additional"];
        if(introductionText.text.length)[user setValue:self.introductionText.text forKey:@"Introduction"];
        if(ageText.text.length)[user setObject:[NSNumber numberWithInt:[self.ageText.text integerValue]] forKey:@"Age"];
        //NSLog(@"%@",[NSNumber numberWithInt:[self.ageText.text integerValue]]);
        [user saveInBackground];
    }
}

- (void)backgroundTouchedHideKeyboard:(id)sender
{
    [usernameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [introductionText resignFirstResponder];
    [ageText resignFirstResponder];
    [self viewWillAppear:YES];
}

-(IBAction)genderChoose:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Male", @"Female", nil];
    [actionSheet showFromTabBar:tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    PFUser *user =[PFUser currentUser];
    if (buttonIndex == 0) {
        [user setObject: [NSNumber numberWithBool:NO] forKey:@"Gender"];
    } else if (buttonIndex == 1) {
        [user setObject: [NSNumber numberWithBool:YES] forKey:@"Gender"];
    }
   [user save];
    if([[user objectForKey:@"Gender"] boolValue])[self.genderLabel setText:[NSString stringWithFormat:@"Gender: Female"]];
    else  [self.genderLabel setText:[NSString stringWithFormat:@"Gender: Male"]];
}

@end
