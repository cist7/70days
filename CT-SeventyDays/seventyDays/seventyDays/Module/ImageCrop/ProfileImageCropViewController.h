//
//  ProfileImageCropViewController.h
//  Pholar
//
//  Created by suejinv on 2015. 2. 9..
//  Copyright (c) 2015년 NAVERCORP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileImageCropViewControllerDelegate;
@interface ProfileImageCropViewController : UIViewController
{
    
}
@property (nonatomic, weak) id<ProfileImageCropViewControllerDelegate> delegate;
@property (nonatomic, copy) UIImage *image;
@end

@protocol ProfileImageCropViewControllerDelegate
- (void)didCropProfileImageWithImage:(UIImage *)image;
@end
