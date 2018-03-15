//
//  CanadaMasterViewController.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

//This is the main view controller file where the service is called and data is displayed in the tableview

#import "CanadaMasterViewController.h"
#import "CanadaInfoTableViewCell.h"
#import "CanadaInfoRow.h"
#import "NetworkClient.h"
#import "Constants.h"
#import "Reachability.h"

@interface CanadaMasterViewController ()

@end

@implementation CanadaMasterViewController {
    UITableView *canadaMasterTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialViews];
    [self checkInternetConnectionAndFetchDataFromServer];
    
    //Pull to refresh
    refreshControl = [[UIRefreshControl alloc] init];
    [tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Setup UI

- (void)setupInitialViews {
    // Creating TableView
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

- (void)showProgressIndicator {
    
    UIView *overlyView = [[UIView alloc] initWithFrame:self.view.frame];
    overlyView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    progressView.center = overlyView.center;
    [progressView startAnimating];
    [overlyView addSubview:progressView];
    
    [self.view addSubview:overlyView];
    [self.view bringSubviewToFront:overlyView];
}

- (void)hideProgressIndicator {
    [[progressView superview] removeFromSuperview];
}

- (void)refreshTable {
    [refreshControl endRefreshing];
    [self checkInternetConnectionAndFetchDataFromServer];
}

#pragma mark Networking Code

//Check for the internet connection here
//If  net is available then call the service to fetch data else show alert message to the user
- (void)checkInternetConnectionAndFetchDataFromServer {
    Reachability *internetReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReachability currentReachabilityStatus];
    if (netStatus == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"No internet connection" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }
    else {
        [self fetchDataFromServer];
    }
}

//Fetch Data from Server
- (void)fetchDataFromServer {
    [self showProgressIndicator];
    [NetworkClient fetchDataFromNetwork:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"%@ %@", NetworkDataFetcherErrorMessage, error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressIndicator];
            });
        }
        else {
            factInfo = [[FactsInfo alloc] initWithDictionary:response];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Updating the UI through main thread
                self.title = factInfo.screenTitle;
                
                [tableView reloadData];
                [self hideProgressIndicator];
            });
        }
    }];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return factInfo.canadaInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CanadaInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CanadaInfoTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    }
    
    CanadaInfoRow *row = [factInfo.canadaInfoArray objectAtIndex:indexPath.row];
    [cell setValuesToCell:row];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
//This method is used to dynamically calculate the hight of a Row in TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static CanadaInfoTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [[CanadaInfoTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    });
    
    CanadaInfoRow *row = [factInfo.canadaInfoArray objectAtIndex:indexPath.row];
    [cell setValuesToCell:row];
    
    return [cell getHeightOfCell];
}

@end
