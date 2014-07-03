//
//  SecondViewController.m
//  TableSearch
//
//  Created by CocoaBob on 07/13/09.
//  Copyright 2009 CocoaBob. All rights reserved.
//

#import "CBSecondViewController.h"
#import "CBProduct.h"

@implementation CBSecondViewController

#pragma mark - Lifecycle methods

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
		self.title = @"Second";
		self.navigationController.navigationBarHidden = NO;
    }
    return self;
}


#pragma mark - UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.filteredListContent = [NSMutableArray array];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                           target:self
                                                                                           action:@selector(showSearchBar:)];
	
    // Set up the search bar programmatically
	_mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 0,220, 44)];
   // _mySearchBar.translatesAutoresizingMaskIntoConstraints = YES;
    
	//[mySearchBar setScopeButtonTitles:@[@"全部",@"",@"iPhone",@"iPod",@"Mac",@"Mac",@"Mac",@"Mac",@"Mac"]];
   // [mySearchBar showsScopeBar];
   // [mySearchBar setsc]
	[_mySearchBar setDelegate:self];
   // _mySearchBar.translucent = NO;

    _test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    UIView * blue = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    blue.backgroundColor = [UIColor blueColor];
    _test.backgroundColor= [UIColor orangeColor];
    [_test addSubview:blue];
    [_test addSubview:_mySearchBar];
    [self.view addSubview:_test];
	//self.tableView.tableHeaderView = _test;
    
    
    // Set up the searchDisplayController programmatically
	self.retainedSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
	[self.searchDisplayController setDelegate:self];
	[self.searchDisplayController setSearchResultsDataSource:self];
    	
	[self.tableView reloadData];

    
    // iOS 7 compatibility
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)])
//        self.extendedLayoutIncludesOpaqueBars = NO;
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
//        self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredListContent count];
    }
	else {
        return [self.listContent count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
	CBProduct *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        product = (self.filteredListContent)[indexPath.row];
    }
	else {
        product = (self.listContent)[indexPath.row];
    }
	
	cell.textLabel.text = product.name;
   // cell.detailTextLabel.text = product.type;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *detailsViewController = [[UIViewController alloc] init];
    
	CBProduct *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        product = (self.filteredListContent)[indexPath.row];
    }
	else {
        product = (self.listContent)[indexPath.row];
    }
	detailsViewController.title = product.name;
    
    [[self navigationController] pushViewController:detailsViewController animated:YES];
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
	[self.filteredListContent removeAllObjects];// First clear the filtered array.

	for (CBProduct *product in self.listContent) {
		if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope]) {
			NSComparisonResult result = [product.name compare:searchText
                                                      options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                        range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame) {
				[self.filteredListContent addObject:product];
            }
		}
	}
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:[self.searchDisplayController.searchBar scopeButtonTitles][[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[self.searchDisplayController.searchBar scopeButtonTitles][searchOption]];
    return YES;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    NSLog(@"hi");
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"yo");

    

}



//結束
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
    [UIView animateWithDuration:.4
                     animations:^{
                        [_mySearchBar setFrame:CGRectMake(100, 0,220, 44)];
                     }
                     completion:^(BOOL finished){
                         //whatever else you may need to do
                     }];
}
//- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
//{
//    
//}
//   



#pragma mark - Actions


- (IBAction)showSearchBar:(id)sender {
	[self.searchDisplayController setActive:YES animated:YES];
}

@end
