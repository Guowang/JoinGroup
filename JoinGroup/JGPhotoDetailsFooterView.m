//
//  JGPhotoDetailsFooterView.m
//  JoinGroup
//
//  Created by Meng Qi on 3/15/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGPhotoDetailsFooterView.h"

@interface JGPhotoDetailsFooterView ()
@property (nonatomic, strong) UIView *mainView;
@end

@implementation JGPhotoDetailsFooterView

@synthesize commentField;
@synthesize mainView;
@synthesize hideDropShadow;


#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake( 20.0f, 0.0f, 280.0f, 51.0f)];
        mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundComments.png"]];
        [self addSubview:mainView];
        
        UIImageView *messageIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconAddComment.png"]];
        messageIcon.frame = CGRectMake( 9.0f, 17.0f, 19.0f, 17.0f);
        [mainView addSubview:messageIcon];
        
        UIImageView *commentBox = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"TextFieldComment.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0f, 10.0f, 5.0f, 10.0f)]];
        commentBox.frame = CGRectMake(35.0f, 8.0f, 237.0f, 35.0f);
        [mainView addSubview:commentBox];
        
        commentField = [[UITextField alloc] initWithFrame:CGRectMake( 40.0f, 10.0f, 227.0f, 31.0f)];
        commentField.font = [UIFont systemFontOfSize:14.0f];
        commentField.placeholder = @"Add a name";
        commentField.returnKeyType = UIReturnKeySend;
        commentField.textColor = [UIColor colorWithRed:73.0f/255.0f green:55.0f/255.0f blue:35.0f/255.0f alpha:1.0f];
        commentField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [commentField setValue:[UIColor colorWithRed:154.0f/255.0f green:146.0f/255.0f blue:138.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"]; // Are we allowed to modify private properties like this? -Héctor
        [mainView addSubview:commentField];
    }
    return self;
}


#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!hideDropShadow) {
        [self drawSideAndBottomDropShadowForRect:mainView.frame inContext:UIGraphicsGetCurrentContext()];
    }
}


#pragma mark Shadow Rendering

- (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height + 10.0f));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake(0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x,
                                          rect.origin.y - 5.0f,
                                          rect.size.width,
                                          rect.size.height + 5.0f));
    // Save context
    CGContextRestoreGState(context);
}


#pragma mark - PAPPhotoDetailsFooterView

+ (CGRect)rectForView {
    return CGRectMake( 0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 69.0f);
}

@end
