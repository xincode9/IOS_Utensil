//
//  SearchListController.m
//  SearchBarDemo
//
//  Created by Joey on 2014/6/8.
//  Copyright (c) 2014年 Joey. All rights reserved.
//

#import "SearchListController.h"

@interface SearchListController ()
@property (strong, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (strong, nonatomic) IBOutlet UITableView *ListTableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *SearchDisplayVC;

@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation SearchListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      self.array = [[NSArray alloc] initWithObjects:@"Apple", @"Samsung", @"HTC", @"LG", @"Moto", nil];
    
    self.searchResults = [[NSArray alloc] init];
    
    
    
    
    
    //SearchBar Placeholder
    self.SearchBar.placeholder = @"請輸入關鍵字";
    //SearchBar顏色
    self.SearchBar.barTintColor = [UIColor redColor];
 }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.array count];
    }
    //    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
    } else {
        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    }
    //   cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}


#pragma Search Methods

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    //    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"contains[c] %@", searchText];
    self.searchResults = [self.array filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



@end
