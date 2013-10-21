//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import "MyLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [PFFacebookUtils initializeFacebook];
    [self.logInView setBackgroundColor:[UIColor colorWithRed:1.0 green: 1.0 blue:205.0/255.0 alpha:1.0]];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]]];
    
    // Set buttons appearance
    //[self.logInView.facebookButton setHidden:YES];
    [self.logInView.twitterButton setHidden:YES];
    [self.logInView.externalLogInLabel setHidden:YES];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUp.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpDown.png"] forState:UIControlStateHighlighted];
    
    // Add login field background
    fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginFieldBG.png"]];
    [self.logInView addSubview:self.fieldsBackground];
    [self.logInView sendSubviewToBack:self.fieldsBackground];
    
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0f;
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
}

- (void)viewDidLayoutSubviews {
    
    // Set frame for elements
    float yOffset = 0.0f;
    CGRect fieldFrame = self.logInView.usernameField.frame;
    CGRect passwordFieldFrame = self.logInView.passwordField.frame;
    [self.logInView.usernameField setFrame:CGRectMake(fieldFrame.origin.x,
                                               fieldFrame.origin.y - yOffset,
                                               fieldFrame.size.width,
                                               fieldFrame.size.height)];
    
    [self.logInView.passwordField setFrame:CGRectMake(passwordFieldFrame.origin.x,
                                                      passwordFieldFrame.origin.y - yOffset,
                                                      passwordFieldFrame.size.width,
                                                      passwordFieldFrame.size.height)];

    [self.logInView.logo setFrame:CGRectMake(fieldFrame.origin.x+25.0f,
                                             fieldFrame.origin.y-120.0f,
                                             200.0,
                                             70)];
    
    [self.fieldsBackground setFrame:CGRectMake(fieldFrame.origin.x+5.0f,
                                               fieldFrame.origin.y,
                                               fieldFrame.size.width-10.0f,
                                               fieldFrame.size.height*2)];
    
    [self.logInView.facebookButton setFrame:CGRectMake(100.0f, 390.0f, 120.0f, 40.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
