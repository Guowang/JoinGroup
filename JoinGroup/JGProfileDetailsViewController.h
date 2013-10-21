//
//  JGProfileDetailsViewController.h
//  JoinGroup
//
//  Created by Meng Qi on 4/15/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JGProfileDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *introductionText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

-(IBAction)backgroundTouchedHideKeyboard:(id)sender;

-(IBAction)genderChoose:(id)sender;

@end
