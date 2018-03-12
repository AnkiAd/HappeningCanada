//
//  CanadaMasterViewController.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaMasterViewController.h"
#import "CanadaInfoTableViewCell.h"
#import "CanadaInfo.h"
#import "NetworkClient.h"

@interface CanadaMasterViewController ()

@end

@implementation CanadaMasterViewController {
    UITableView *canadaMasterTableView;
}

static NSString *CellIdentifier = @"CanadaInfoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialViews];
    [self fetchDataFromServer];
    
    //Pull to refresh
    refreshControl = [[UIRefreshControl alloc] init];
    [tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Setup UI

- (void)setupInitialViews {
    // Initilizing TableView
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
    // Setting Autolayout Constraints for TableView
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Align tableView from the left/right
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    
    // Align tableView from the top/bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
}

- (void)showActivityOverly {
    
    UIView *overlyView = [[UIView alloc] initWithFrame:self.view.frame];
    overlyView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    progressView.center = overlyView.center;
    [progressView startAnimating];
    [overlyView addSubview:progressView];
    
    [self.view addSubview:overlyView];
    [self.view bringSubviewToFront:overlyView];
}

- (void)hideActivityOverly {
    [[progressView superview] removeFromSuperview];
}

- (void)refreshTable {
    [refreshControl endRefreshing];
    [self fetchDataFromServer];
}

#pragma mark fetching data

- (void)fetchDataFromServer {
    //[self showActivityOverly];
    [NetworkClient fetchDataRowFromServerWithCompletion:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"NetworkDataFetcher Error: %@", error);
        }
        else {
            factInfo = [[FactsInfo alloc] initWithDictionary:response];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // Updateing the UI through main thread
                self.title = factInfo.screenTitle;
                
                [tableView reloadData];
                //[self hideActivityOverly];
            });
        }
    }];
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return factInfo.canadaInfoArray.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CanadaInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CanadaInfoTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    }
    
    CanadaInfo *row = [factInfo.canadaInfoArray objectAtIndex:indexPath.row];
    [cell setValuesToCell:row];
    
    return cell;
}

#pragma mark - Table view delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static CanadaInfoTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [[CanadaInfoTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    });
    
    CanadaInfo *row = [factInfo.canadaInfoArray objectAtIndex:indexPath.row];
    [cell setValuesToCell:row];
    
    return [cell getHeightOfCell];
}

@end
