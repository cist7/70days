//
//  MemoPadAppDelegate.h
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 10..
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface MemoPadAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	NSString *DBName;
	NSString *DBPath;
	NSMutableArray *DBData;		//DB에서 읽은 메모리를 저장.
	BOOL isFirstTimeAccess;		//데이터베이스 첫 엑세스인지 여부.
	
	NSInteger currentMemoSQLIndex; // Index number in SQL
	NSInteger currentMemoRowIndex; // Index number in table view row
}




@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic,retain) NSString *DBName;
@property (nonatomic,retain) NSString *DBPath;
@property (nonatomic,retain) NSMutableArray *DBData;
@property (nonatomic,assign) BOOL isFirstTimeAccess;

@property (nonatomic, assign) NSInteger currentMemoSQLIndex;
@property (nonatomic, assign) NSInteger currentMemoRowIndex;

-(void) checkAndCreateDatabase;		//DB에서 파일이 있는지 체크하고 생성하는 메소드
-(void) readMemeoFromDatabase;		//DB에서 메모를 읽어오는 메소드

-(void) writeMemoDb:(id)objAddViewCtrl arrAguments:(NSArray*)arrData; //DB에 메모를 쓰는 메소드.
-(void) checkAndCreateDatabase;
//-(void) readMemoFromDatabase;
-(void) deleteMemoFromDatabase;
//-(void) writeMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent;
-(void) updateMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent;
@end

