//
//  RootViewController.m
//  MemoPad
//
//  Created by ilyong choi on 11. 3. 10..
//  Copyright 2011 none. All rights reserved.
//

#import "RootViewController.h"
#import "MemoPadAppDelegate.h"
#import "MemoData.h"
#import "MemoAddViewController.h"

@implementation RootViewController
@synthesize objMemoData, arrMemoData;

#pragma mark -
#pragma mark View lifecycle


-(MemoPadAppDelegate *)appDelegate
{
	return [[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	arrMemoData = [self appDelegate].DBData;
	
	// Configure the navigation bar
    self.title = @"Title";
	
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(add:)];
	//UIBarButtonItem *addButtonItem2 = [[UIBarButtonItem alloc] initWithBarButton
    self.navigationItem.rightBarButtonItem = addButtonItem;
    [addButtonItem release];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)add:(id)sender {
	
	// To add a new recipe, create a MemoAddViewCOntroller.  Present it as a modal view so that the user's focus is on the task of adding the recipe; wrap the controller in a navigation controller to provide a navigation bar for the Done and Save buttons (added by the MemoAddViewCOntroller in its viewDidLoad method).
    MemoAddViewController *addController = [[MemoAddViewController alloc] initWithNibName:@"MemoAddViewController" bundle:nil];
    addController.delegate = self;
	
	//Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:self.managedObjectContext];
	//addController.objMemoData = newRecipe;
	
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    [self.navigationController presentModalViewController:addController animated:YES];
    
    [addController release];
}

-(void)delAddViewCtlrMethod
{
	[self.tableView reloadData];
	[self.tableView setNeedsDisplay];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMemoData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
    objMemoData = [arrMemoData objectAtIndex:indexPath.row];
	
	cell.textLabel.text = objMemoData.mTitle;
	cell.detailTextLabel.text = objMemoData.mDate;
	
	// Configure the cell.

    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;

}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		//MemoPadAppDelegate *appDelegate = (MemoPadAppDelegate *)[[UIApplication sharedApplication] delegate];
		objMemoData = [arrMemoData objectAtIndex:indexPath.row];
		//objMemoData = (MemoData*)[NSArray arrayWithObject:indexPath];
		[self appDelegate].currentMemoSQLIndex = objMemoData.mIndex;
		
		[[self appDelegate] deleteMemoFromDatabase];
		//[self.navigationController popViewControllerAnimated:YES];
		
        // Delete the row from the data source.
		//[tableView reloadSections:0 withRowAnimation:UITableViewRowAnimationFade];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[tableView reloadData];
		
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	 MemoAddViewController *detailViewController = [[MemoAddViewController alloc] initWithNibName:@"MemoAddViewController" bundle:nil];
	
	detailViewController.objMemoData = [arrMemoData objectAtIndex:indexPath.row];
	detailViewController.bolIsUpdate = YES;
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

