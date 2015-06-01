//
//  SDSearchSuggestionsViewController.h
//  SetDirection
//
//  Created by Joel Bernstein on 12/8/13.
//  Copyright (c) 2013 SetDirection. All rights reserved.
//

#import "SDSearchSuggestionsViewController.h"

#import "SDMacros.h"

@interface SDSearchSuggestionsViewController ()

@property (nonatomic, copy) NSArray* searchSuggestions;

@end

@implementation SDSearchSuggestionsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    @SDStrongify(self.delegate, delegate);
    [delegate configureSearchSuggestionsViewController:self];
}

-(void)setSearchString:(NSString *)searchString
{
    _searchString = [searchString copy];
    
    if(self.searchString.length > 0)
    {
        @SDStrongify(self.suggestionDataSource, dataSource);
        
        [dataSource searchSuggestionsForString:searchString completion:^(NSArray* searchSuggestions)
        {
            self.searchSuggestions = searchSuggestions;
            
            [self.tableView reloadData];
        }];

        self.titleLabel.text = NSLocalizedString(@"Suggested Searches", @"Search Panel Search Suggestions Title");
        self.clearButton.hidden = YES;
    }
    else
    {
        self.titleLabel.text = NSLocalizedString(@"Recent Searches", @"Search Panel Recent Searches Title");
        self.clearButton.hidden = NO;
    }

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @SDStrongify(self.suggestionDataSource, dataSource);

    return self.searchString.length > 0 ? (NSInteger)self.searchSuggestions.count : (NSInteger)[[dataSource recentSearchStrings] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(self.searchString.length > 0)
    {
        cell.textLabel.text = self.searchSuggestions[(NSUInteger)indexPath.row];
    }
    else
    {
        @SDStrongify(self.suggestionDataSource, dataSource);

        cell.textLabel.text = [dataSource recentSearchStrings][(NSUInteger)indexPath.row];
    }
    
    @SDStrongify(self.delegate, delegate);
    [delegate configureSuggestionTableCell:cell];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @SDStrongify(self.delegate, delegate);
    @SDStrongify(self.usageDelegate, usageDelegate);
    
    if(self.searchString.length > 0)
    {
        NSString *searchText = self.searchSuggestions[(NSUInteger)indexPath.row];
        [usageDelegate searchSuggestionWithTerm:searchText];
        [delegate searchViewController:self didSearchForKeyword: searchText];
    }
    else
    {
        @SDStrongify(self.suggestionDataSource, dataSource);

        NSString *searchText = [dataSource recentSearchStrings][(NSUInteger)indexPath.row];
        [usageDelegate searchRecentWithTerm:searchText];
        [delegate searchViewController:self didSearchForKeyword: searchText];
    }
}

-(IBAction)clearButtonTapped:(UIButton*)clearButton
{
    @SDStrongify(self.suggestionDataSource, dataSource);

    [dataSource clearRecentSearches];
    
    [self.tableView reloadData];
}

@end
