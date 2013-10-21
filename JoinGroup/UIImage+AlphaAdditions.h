//
//  UIImage+AlphaAdditions.h
//  JoinGroup
//
//  Created by Meng Qi on 3/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage_AlphaAdditions : NSObject

@end// UIImage+AlphaAdditions.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image

// http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/

@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
@end
