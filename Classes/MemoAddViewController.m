//
//  MemoAddViewController.m
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 11..
//  Copyright 2011 none. All rights reserved.
//

#import "MemoAddViewController.h"
#import "MemoPadAppDelegate.h"
#import "MemoData.h"

@implementation MemoAddViewController

@synthesize txtTitle , txvContent,delegate,navBar,navItem,objMemoData,bolIsUpdate,lblDate,sliFontSize;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(MemoPadAppDelegate*)appDelegate
{
	return [[UIApplication sharedApplication] delegate];
}

-(IBAction)ChangeContentSize:(id)sender
{
	 //sliFontSize.value
	
	int fontSizeValue = self.sliFontSize.value;
	
	self.txvContent.font = [UIFont fontWithName:@"Helvetica" size:fontSizeValue];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.txvContent.font = [UIFont fontWithName:@"Helvetica" size:12.0];
	
	// Configure the navigation bar
    //self.navItem.title = @"Add Memo";
    
	
	if (bolIsUpdate) 
	{
		self.navBar.hidden = TRUE;
		//self.navItem.
		
		self.txtTitle.text = objMemoData.mTitle;
		self.txvContent.text = objMemoData.mContent;
		self.navigationItem.title = @"Update Memo";
		lblDate.text = objMemoData.mDate;
		
		
		
		//UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
//		self.navigationItem.leftBarButtonItem = cancelButtonItem;
//		[cancelButtonItem release];
		
		UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
		self.navigationItem.rightBarButtonItem = saveButtonItem;
		[saveButtonItem release];
		
	}
	else {
		
		self.navItem.title = @"Add Memo";
		UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
		self.navItem.leftBarButtonItem = cancelButtonItem;
		[cancelButtonItem release];
		
		UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
		self.navItem.rightBarButtonItem = saveButtonItem;
		[saveButtonItem release];
		
		[txtTitle becomeFirstResponder];
	}

										 
    
	
	
	
}

- (void)save
{
	
	if (bolIsUpdate) 
	{
		
		[self appDelegate].currentMemoSQLIndex = objMemoData.mIndex;
		[[self appDelegate] updateMemoToDatabaseWithTitle:txtTitle.text Content:txvContent.text ];
		
		
		[self.navigationController popViewControllerAnimated:YES];
	}
	else 
	{
		NSMutableArray *arrData = [[NSMutableArray alloc] init];
		
		[arrData addObject:txtTitle.text];
		[arrData addObject:txvContent.text];
		
		//NSLog(@" %@,%@",[arrData objectAtIndex:0] , [arrData objectAtIndex:1]);
		
		//[arrData addObject:txt
		
		
		[[self appDelegate] writeMemoDb:nil arrAguments:arrData];
		[arrData release];
		
		[self dismissModalViewControllerAnimated:YES];
	}
	
	
	[self.delegate delAddViewCtlrMethod];
}


- (void)cancel {
	
	[self dismissModalViewControllerAnimated:YES];
    [self.delegate delAddViewCtlrMethod];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
