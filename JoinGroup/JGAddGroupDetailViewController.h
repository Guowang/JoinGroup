//
//  JGAddGroupDetailViewController.h
//  JoinGroup
//
//  Created by Meng Qi on 3/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "JGLocationController.h"

@interface JGAddGroupDetailViewController : UIViewController
<UITextFieldDelegate>
- (IBAction)creatGroup:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *detailsInput;
@property NSString *groupIdCreated;
@end

