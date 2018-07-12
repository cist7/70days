//
//  MemoData.m
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 10..
//  Copyright 2011 none. All rights reserved.
//

#import "MemoData.h"


@implementation MemoData
@synthesize mIndex,mTitle,mContent,mDate;

-(id)initWithData:(NSInteger)pIndex Title:(NSString *)pTitle Content:(NSString *)pContent Date:(NSString *)pDate
{
	self.mIndex = pIndex;
	self.mTitle = pTitle;
	self.mContent = pContent;
	self.mDate = pDate;
	
	return self;
}

-(void)dealloc
{
	[super dealloc];
}
@end
