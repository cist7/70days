//
//  RootViewController.h
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 10..
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemoData;
@class MemoPadAppDelegate;

//@class MemoAddViewController;
//프로토콜 사용을 위한 헤더추가.
#import "MemoAddViewController.h"

@interface RootViewController : UITableViewController <delAddViewCtlr>
{
	NSArray *arrMemoData;
	MemoData *objMemoData;
}

@property (nonatomic,retain) NSArray *arrMemoData;
@property (nonatomic,retain) MemoData *objMemoData;

-(MemoPadAppDelegate*)appDelegate;

@end
