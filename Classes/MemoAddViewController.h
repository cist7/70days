//
//  MemoAddViewController.h
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 11..
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MemoData;
@class MemoPadAppDelegate;

@protocol delAddViewCtlr;

@interface MemoAddViewController : UIViewController {

	
	id<delAddViewCtlr> delegate;
	IBOutlet UITextField *txtTitle;
	IBOutlet UITextView *txvContent;
	IBOutlet UILabel	*lblDate;
	
	IBOutlet UINavigationBar *navBar;
	IBOutlet UINavigationItem *navItem;
	IBOutlet UISlider *sliFontSize;
	BOOL bolIsUpdate;
	
	MemoData *objMemoData;
	
}
@property(retain,nonatomic) UITextView *txvContent;
@property(retain,nonatomic) UITextField *txtTitle;
@property(retain,nonatomic) UINavigationBar *navBar;
@property(retain,nonatomic) UINavigationItem *navItem;
@property(retain,nonatomic) MemoData *objMemoData;
@property(assign,nonatomic) BOOL bolIsUpdate;
@property(retain,nonatomic) UILabel *lblDate;
@property(retain,nonatomic) UISlider *sliFontSize;

//delegate는 전달되므로 assign
@property(assign,nonatomic) id<delAddViewCtlr> delegate;

-(MemoPadAppDelegate*)appDelegate;
-(IBAction)ChangeContentSize:(id)sender;

@end

@protocol delAddViewCtlr
@required
-(void)delAddViewCtlrMethod;
@optional
@end