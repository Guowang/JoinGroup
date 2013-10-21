//
//  JGProfileViewController.h
//  JoinGroup
//
//  Created by user on 2/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProfilePictureEditViewController.h"
#import <Parse/Parse.h>

@protocol JGTabBarControllerDelegate;

@interface JGProfileViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *userTitle;
@property (weak, nonatomic) IBOutlet UILabel *userGroupCount;
@property (weak, nonatomic) IBOutlet UILabel *userEventCount;
@property (weak, nonatomic) IBOutlet UILabel *userPhotoCount;
@property (weak, nonatomic) IBOutlet UILabel *userAttentanceCount;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)logOut:(id)sender;
- (IBAction)upload:(id)sender;
- (IBAction)goToGroup:(id)sender;
- (IBAction)editProfileDetails:(id)sender;
- (IBAction)profileDone:(UIStoryboardSegue *)segue;
- (IBAction)profileCancel:(UIStoryboardSegue *)segue;
- (BOOL)shouldPresentPhotoCaptureController;

@end

@protocol JGTabBarControllerDelegate <NSObject>

- (void)tabBarController:(UITabBarController *)tabBarController cameraButtonTouchUpInsideAction:(UIButton *)button;

@end
