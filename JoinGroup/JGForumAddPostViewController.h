//
//  JGForumAddPostViewController.h
//  JoinGroup
//
//  Created by user on 4/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JGForumAddPostViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) id eventItems;
@property (weak, nonatomic) IBOutlet UITextField *postInput;
- (IBAction)addNewPost:(id)sender;
@end
