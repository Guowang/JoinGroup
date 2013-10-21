//
//  MySignUpViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import "MySignUpViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MySignUpViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MySignUpViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.signUpView setBackgroundColor:[UIColor colorWithRed:1.0 green: 1.0 blue:205.0/255.0 alpha:1.0]];
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]]];
    
    // Change button apperance
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"Exit.png"] forState:UIControlStateNormal];
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"ExitDown.png"] forState:UIControlStateHighlighted];
    
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUp.png"] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpDown.png"] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton setTitle:@"" forState:UIControlStateNormal];
    [self.signUpView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // Add background for fields
    [self setFieldsBackground:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SignUpFieldBG.png"]]];
    [self.signUpView insertSubview:fieldsBackground atIndex:1];
    
    // Remove text shadow
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.signUpView.emailField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.signUpView.additionalField.layer;
    layer.shadowOpacity = 0.0f;
    
    // Set text color
    [self.signUpView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.signUpView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.signUpView.emailField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.signUpView.additionalField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    
    // Change "Additional" to match our use
    [self.signUpView.additionalField setPlaceholder:@"Phone number"];
    
}

- (void)viewDidLayoutSubviews {
    // Set frame for elements
    float yOffset = 54.0f;
    CGRect fieldFrame = self.signUpView.usernameField.frame;
    
    [self.fieldsBackground setFrame:CGRectMake(fieldFrame.origin.x,
                                               fieldFrame.origin.y,
                                               250.0f,
                                               174.0f)];
    
    [self.signUpView.logo setFrame:CGRectMake(fieldFrame.origin.x+44.0f,
                                               fieldFrame.origin.y - yOffset,
                                               175.0f,
                                               60.0f)];
    
    
    [self.signUpView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
