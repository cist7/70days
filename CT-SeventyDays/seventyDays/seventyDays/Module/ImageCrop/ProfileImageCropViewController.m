//
//  ProfileImageCropViewController.m
//  Pholar
//
//  Created by suejinv on 2015. 2. 9..
//  Copyright (c) 2015년 NAVERCORP. All rights reserved.
//

#import "ProfileImageCropViewController.h"

@interface ProfileImageCropViewController() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UIImageView *test;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@end

@implementation ProfileImageCropViewController

//static NSInteger diameter = 274;
//#define diameter (SCREEN_WIDTH - 14)
#define diameter SCREEN_WIDTH
#define SCREEN_SIZE                     [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH                    SCREEN_SIZE.width
#define SCREEN_HEIGHT                   SCREEN_SIZE.height

#pragma mark - init & dealloc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat scrollHeight = SCREEN_WIDTH;
    CGFloat scrollWidth = SCREEN_WIDTH;
    
    self.titleLabel.text = NSLocalizedString(@"profile_edit_photo_title", nil);
    [self.completeButton setTitle:NSLocalizedString(@"done", nil) forState:UIControlStateNormal];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    
    self.imageView.image = [self getImageOrientationResolvedImage:self.image];
    self.image = nil;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 10.0;
    self.scrollView.multipleTouchEnabled = YES;
    [self.scrollView setZoomScale:1];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentInset = UIEdgeInsetsMake((scrollHeight-diameter)/2, (scrollWidth-diameter)/2, (scrollHeight-diameter)/2, (scrollWidth-diameter)/2);
    
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    self.maskView.userInteractionEnabled = NO;
    [self.view addSubview:self.maskView];
    
    // circle mask
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *circularPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake((scrollWidth-diameter)/2, (scrollHeight-diameter)/2, diameter, diameter) cornerRadius:MAX(diameter, diameter)];
    circle.path = circularPath.CGPath;
    CGMutablePathRef maskPath = CGPathCreateMutable();
    CGPathAddRect(maskPath, NULL, self.maskView.bounds);
    CGPathAddPath(maskPath, nil, circularPath.CGPath);
    [circle setPath:maskPath];
    circle.fillRule = kCAFillRuleEvenOdd;
    CGPathRelease(maskPath);
    self.maskView.layer.mask = circle;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self resizeImageView];
}

#pragma mark - Override
- (BOOL)isFullModeViewController
{
    return YES;
}

#pragma mark - private
- (void)resizeImageView {
    if (CGSizeEqualToSize(self.imageView.image.size, CGSizeZero)) {
        return;
    }
    
    CGFloat height = self.imageView.image.size.height;
    CGFloat width = self.imageView.image.size.width;

    CGFloat factoredWidth = 0.0f;
    CGFloat factoredHeight = 0.0f;
    factoredHeight = diameter;
    factoredWidth = width * diameter / height;

    if (diameter > factoredWidth) {
        factoredWidth = diameter;
        factoredHeight = height / width * diameter;
    }

    self.imageView.frame = CGRectMake(0, 0, factoredWidth, factoredHeight);
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.size.width = factoredWidth;
    imageViewFrame.size.height = factoredHeight;
    self.imageView.frame = imageViewFrame;
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width - self.scrollView.frame.size.width)/2, (self.scrollView.contentSize.height - self.scrollView.frame.size.height)/2);
    //레이아웃 설정 후 마스크뷰 좌표값 재조정
    self.maskView.frame = CGRectMake(0, _scrollView.frame.origin.y, SCREEN_WIDTH, SCREEN_WIDTH);
}

-(CGRect)calculateVisibleRectForCropArea{
    // 크롭사이즈의 대한 실제 이미지 사이즈의 비율
    CGFloat scaleWidth = self.imageView.image.size.width / diameter;
    CGFloat scaleHeight = self.imageView.image.size.height / diameter;
    CGFloat scale = 0.0f;
    
    scale = MIN(scaleWidth, scaleHeight);
    
    //extract visible rect from scrollview and scale it
    CGRect bounds = CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y + self.scrollView.contentInset.top, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height - self.scrollView.contentInset.bottom*2);
    
    CGRect visibleRect = [self.scrollView convertRect:bounds toView:self.imageView];
    CGRect scaleRect = CGRectMake(visibleRect.origin.x * scale, visibleRect.origin.y * scale, visibleRect.size.width * scale, visibleRect.size.height * scale);
    
    return scaleRect;
}

- (UIImage *)croppedImage{
    
    CGRect visibleRect = [self calculateVisibleRectForCropArea];
    
    // crop image
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.imageView.image CGImage], visibleRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.imageView.image.scale orientation:self.imageView.image.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

#pragma mark - ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


#pragma mark - Button Selector
- (IBAction)actionClose:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)actionComplete:(id)sender
{
    UIImage *croppedImage = [self croppedImage];
    
    [self.delegate didCropProfileImageWithImage:croppedImage];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (UIImage *)getImageOrientationResolvedImage:(UIImage *)orgImage {
    // No-op if the orientation is already correct
    if (orgImage.imageOrientation == UIImageOrientationUp) {
        return orgImage;
    }
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (orgImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, orgImage.size.width, orgImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, orgImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, orgImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (orgImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, orgImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, orgImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, orgImage.size.width, orgImage.size.height,
                                             CGImageGetBitsPerComponent(orgImage.CGImage), 0,
                                             CGImageGetColorSpace(orgImage.CGImage),
                                             CGImageGetBitmapInfo(orgImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (orgImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,orgImage.size.height,orgImage.size.width), orgImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,orgImage.size.width,orgImage.size.height), orgImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
