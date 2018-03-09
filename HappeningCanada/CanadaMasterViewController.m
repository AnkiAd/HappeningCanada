//
//  CanadaMasterViewController.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "CanadaMasterViewController.h"
#import "CanadaInfoTableViewCell.h"

@interface CanadaMasterViewController ()

@end

@implementation CanadaMasterViewController {
    UITableView *canadaMasterTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.canadaData = @[@"Beavers", @"Flag", @"Transportation", @"Hockey Night in Canada"];
    
    // init table view
    canadaMasterTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    canadaMasterTableView.delegate = self;
    canadaMasterTableView.dataSource = self;
    [self.view addSubview:canadaMasterTableView];
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.canadaData.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CandaInfoCell";
    
    CanadaInfoTableViewCell *cell = (CanadaInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CanadaInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.titleLabel.text = self.canadaData[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected %ld row", (long)indexPath.row);
}

@end
