//
//  MemoData.h
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 10..
//  Copyright 2011 none. All rights reserved.
//

//#import <Cocoa/Cocoa.h>


@interface MemoData : NSObject {

	NSInteger mIndex;
	NSString *mTitle;
	NSString *mContext;
	NSString *mDate;
}

@property(nonatomic,assign) NSInteger mIndex;
@property(nonatomic,retain) NSString *mTitle;
@property(nonatomic,retain) NSString *mContent;
@property(nonatomic,retain) NSString *mDate;

-(id)initWithData:(NSInteger)pIndex Title:(NSString *)pTitle Content:(NSString*)pContent Date:(NSString*)pDate;

@end
