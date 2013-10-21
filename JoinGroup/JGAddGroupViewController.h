//
//  JGAddGroupViewController.h
//  JoinGroup
//
//  Created by user on 2/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JGPictureEditViewController.h"
#import <Parse/Parse.h>

@protocol JGTabBarControllerDelegate;

@interface JGAddGroupViewController : UITabBarController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>

- (IBAction)photoCaptureButtonAction:(id)sender;

- (BOOL)shouldPresentPhotoCaptureController;

@end

@protocol JGTabBarControllerDelegate <NSObject>

- (void)tabBarController:(UITabBarController *)tabBarController cameraButtonTouchUpInsideAction:(UIButton *)button;

@end