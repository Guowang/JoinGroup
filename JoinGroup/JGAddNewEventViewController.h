//
//  JGAddNewEventViewController.h
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JGAddNewEventViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) id groupItems;
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *eventDetails;
@property (nonatomic, strong) IBOutlet UIDatePicker *pickerView;
- (IBAction)creatEvent:(id)sender;
@end
