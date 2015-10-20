//
//  MemoPadAppDelegate.m
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 10..
//  Copyright 2011 none. All rights reserved.
//

#import "MemoPadAppDelegate.h"
#import "RootViewController.h"
#import "MemoData.h"

@implementation MemoPadAppDelegate

@synthesize window;
@synthesize navigationController;

@synthesize DBName,DBData,DBPath,isFirstTimeAccess;
@synthesize currentMemoSQLIndex;
@synthesize currentMemoRowIndex;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	self.isFirstTimeAccess = TRUE;
	
	//앱의 파일 시스템 경로를 구한다.
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	//DB이름과 경로를 저장.
	self.DBName = @"MemoPad.sqlite";
	self.DBPath = [documentsDir stringByAppendingPathComponent:self.DBName];
	
	[self checkAndCreateDatabase];
    [self readMemeoFromDatabase];
	
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

-(void)checkAndCreateDatabase
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	//해당경로에 DB파일이 존재하는지 확인.
	if ([fileManager fileExistsAtPath:self.DBPath] ) {
		return;
	}
	else {
		NSString *databasePathFromApp = [[[NSBundle mainBundle]bundlePath] stringByAppendingPathComponent:self.DBName];
		
		[fileManager copyItemAtPath:databasePathFromApp toPath:self.DBPath error:nil];
		[fileManager release];
	}
}

-(void)readMemeoFromDatabase
{
	sqlite3 *database;
	
	//DBData 초기화
	//DB를 처음 엑세스하는것이라면 alloc으로 메모리 할당.
	if (self.isFirstTimeAccess == TRUE) {
		self.DBData = [[NSMutableArray alloc]init];
		self.isFirstTimeAccess = FALSE;
	}
	else {
		[self.DBData removeAllObjects];
	}
	
	//데이터베이스 파일을 연다.
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK)
	{
		
		//SQL명령어 실행.
		const char *sqlStatement = "SELECT * FROM tblMemoPad ORDER BY MP_Index ASC";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			//SQL명령어를 실행하여 얻은 결과를 하나씩 읽는다.
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				NSInteger	aIndex	= sqlite3_column_int(compiledStatement, 0);
				NSString	*aTitle	= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString	*aContent= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString	*aDate	= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				
				//읽어온 데이터를 사용하여 MemoData 오브젝트를 생성한다.
				MemoData *md = [[MemoData alloc] initWithData:aIndex Title:aTitle Content:aContent Date:aDate];
				
				//데이터 콘솔확인
				NSLog(@"%d / %@ / %@ /%@ ", aIndex,aTitle,aContent,aDate);
				
				//MemoData 오브젝트를 DBData 배열에 추가.
				[self.DBData addObject:md];
				
				[md autorelease];	//테스트시 autorelease 사용하여 메모리 테스트 필요.
			}
		}
		else {
			printf("could not prepare statement: %s \n",sqlite3_errmsg(database));
		}
		
		//SQL 명령을 종료
		sqlite3_finalize(compiledStatement);
	}
	
	//데이터베이스를 닫는다.
	sqlite3_close(database);
}

-(void) writeMemoDb:(id)objAddViewCtrl arrAguments:(NSArray*)arrData
{
	//---------------------------------------------------------------------------------------------------
	// Sqlite 사용순서.
	//---------------------------------------------------------------------------------------------------
	//1.sqlite3 객체생성.							(sqlite3 *database;)
	//2.sqlite_open메소드로 접근확인.				(sqlite3_open(DBPath,&database) == SQLITE_OK)
	//3.sql구문정의								(const char *sqlStatement = "SELECT * FROM TableName";)
	//4.sqlite3_stmt 객체생성.					(sqlite3_stmt *compiledStatement;)
	//5.sqlite3_prepare_v2 메소드로 sql구문확인.	(sqlite3_prepare_v2(database,sqlStatement,-1,&compiledStatement,NULL) == SQLITE_OK)
	//6.sqlite3_step 메소드로 구문최종실행.			(sqlite3_step(compiledStatement) == SQLITE_DONE)
	//7.sqlite3_finalize 메소드로 명령종료.			(sqlite3_finalize(compiledStatement))
	//8.sqlite3_close 메소드로 DB종료.				(sqlite3_close(database)
	
	sqlite3 *database;
	
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) 
	{
		//INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES('Sample data 1','Hello! This is a sample content 1','2010-01-01 00:00:00');
		
		const char *sqlStatement = "INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES(?,?,?)";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			
			//문자형식 데이트타임 만들기
			// For Datetime
			NSDate *date = [NSDate date];
			NSCalendar *calendar = [NSCalendar currentCalendar];
			
			NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;		
			NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
			
			NSString *yearOfCommonEra = [NSString stringWithFormat:@"%02d", [comp year]];
			NSString *monthOfYear = [NSString stringWithFormat:@"%02d", [comp month]];
			NSString *dayOfMonth = [NSString stringWithFormat:@"%02d", [comp day]];
			NSString *hourOfDay = [NSString stringWithFormat:@"%02d", [comp hour]];
			NSString *minuteOfHour = [NSString stringWithFormat:@"%02d", [comp minute]];
			NSString *secondOfMinute = [NSString stringWithFormat:@"%02d", [comp second]];
			
			NSString *dateStringConcat = [NSString stringWithFormat:@"%@-%@-%@",yearOfCommonEra, monthOfYear, dayOfMonth];
			NSString *timeStringConcat = [NSString stringWithFormat:@"%@:%@:%@",hourOfDay, minuteOfHour, secondOfMinute];
			NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", dateStringConcat, timeStringConcat]; //2010-01-02 12:24:23 형태로 최종출력
			
			
			sqlite3_bind_text(compiledStatement, 1, [[arrData objectAtIndex:0] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [[arrData objectAtIndex:1] UTF8String] , -1, SQLITE_TRANSIENT);	
			sqlite3_bind_text(compiledStatement, 3, [dateTimeString UTF8String], -1, SQLITE_TRANSIENT);
			
			
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting into tblLocationHistory. '%s'", sqlite3_errmsg(database));
			
			sqlite3_reset(compiledStatement);
			sqlite3_close(database);
			
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
			
		}
	}
	else
	{
		sqlite3_close(database);
		
		NSAssert1(0, @"Error opening database in tblLocationHistory. '%s'", sqlite3_errmsg(database));
	}
	
	[self readMemeoFromDatabase];
	
}

-(void) deleteMemoFromDatabase
{
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) 
	{
		// Setup the SQL Statement and compile it for faster access
		NSString* sqlStatementNS = [[NSString alloc] initWithString:[NSString stringWithFormat:@"DELETE FROM tblMemoPad WHERE MP_Index = '%d'", self.currentMemoSQLIndex]];
		const char *sqlStatement = [sqlStatementNS UTF8String];
		sqlite3_stmt *compiledStatement;		
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting into tblLocationHistory. '%s'", sqlite3_errmsg(database));
			
			sqlite3_reset(compiledStatement);
			
			
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
		[sqlStatementNS release];
		
	}
	sqlite3_close(database);
	
	[self readMemeoFromDatabase];
}

-(void) updateMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent
{
	
	sqlite3 *database;
	
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		
		NSString* sqlStatementNS = [[NSString alloc] initWithString:[NSString stringWithFormat:@"UPDATE tblMemoPad SET MP_Title=?, MP_Content=?, MP_Date=? WHERE MP_Index = '%d'", self.currentMemoSQLIndex]];
		NSLog(@"SQL = %@", sqlStatementNS);
		const char *sqlStatement = [sqlStatementNS UTF8String];
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			
			// For Datetime
			NSDate *date = [NSDate date];
			NSCalendar *calendar = [NSCalendar currentCalendar];
			
			NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;		
			NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
			
			NSString *yearOfCommonEra = [NSString stringWithFormat:@"%02d", [comp year]];
			NSString *monthOfYear = [NSString stringWithFormat:@"%02d", [comp month]];
			NSString *dayOfMonth = [NSString stringWithFormat:@"%02d", [comp day]];
			NSString *hourOfDay = [NSString stringWithFormat:@"%02d", [comp hour]];
			NSString *minuteOfHour = [NSString stringWithFormat:@"%02d", [comp minute]];
			NSString *secondOfMinute = [NSString stringWithFormat:@"%02d", [comp second]];
			
			NSString *dateStringConcat = [NSString stringWithFormat:@"%@-%@-%@",yearOfCommonEra, monthOfYear, dayOfMonth];
			NSString *timeStringConcat = [NSString stringWithFormat:@"%@:%@:%@",hourOfDay, minuteOfHour, secondOfMinute];
			NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", dateStringConcat, timeStringConcat];
			
			
			sqlite3_bind_text(compiledStatement, 1, [inputTitle UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputContent UTF8String] , -1, SQLITE_TRANSIENT);	
			sqlite3_bind_text(compiledStatement, 3, [dateTimeString UTF8String], -1, SQLITE_TRANSIENT);
			
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting into tblLocationHistory. '%s'", sqlite3_errmsg(database));
			
			sqlite3_reset(compiledStatement);
			sqlite3_close(database);
			
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
			
		}
	}
	else
	{
		sqlite3_close(database);
		
		NSAssert1(0, @"Error opening database in tblLocationHistory. '%s'", sqlite3_errmsg(database));
	}
	
	
	[self readMemeoFromDatabase];
	
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

