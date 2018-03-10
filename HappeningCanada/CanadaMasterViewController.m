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

@interface CanadaMasterViewController ()

@end

@implementation CanadaMasterViewController {
    UITableView *canadaMasterTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    canadaInfoArray = [[NSMutableArray alloc] init];
    [self fetchDataFromServer];
            
    // init table view
    canadaMasterTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    canadaMasterTableView.delegate = self;
    canadaMasterTableView.dataSource = self;
    [self.view addSubview:canadaMasterTableView];
}


-(void)fetchDataFromServer {
    
    NSURL *URL = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      NSError* errorTemp = nil;
                                      NSString *strISOLatin = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                                      NSData *dataUTF8 = [strISOLatin dataUsingEncoding:NSUTF8StringEncoding];
                                      
                                      if (dataUTF8.length > 0 && error == nil) {
                                          
                                          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dataUTF8
                                                                                               options:0
                                                                                                 error:&errorTemp];
                                          NSString *title = dict[@"title"];
                                          
                                          NSDictionary *rowsDict = dict[@"rows"];
                                          
                                          for(NSDictionary *row in rowsDict) {
                                              NSString *titleString = [row objectForKey:@"title"];
                                              NSString *descriptionString = [row objectForKey:@"description"];
                                              NSString *imageHrefString = [row objectForKey:@"imageHref"];
                                              
                                              CanadaInfo *canadaInfoObject = [[CanadaInfo alloc] init];
                                              
                                              if([[self checkForNull:titleString] isEqualToString:@""]) {
                                                  canadaInfoObject.titleDetail = @"";
                                              } else {
                                                  canadaInfoObject.titleDetail = titleString;
                                              }
                                              
                                              if([[self checkForNull:descriptionString] isEqualToString:@""]) {
                                                  canadaInfoObject.descriptionDetail = @"";
                                              } else {
                                                  canadaInfoObject.descriptionDetail = descriptionString;
                                              }
                                              
                                              if([[self checkForNull:imageHrefString] isEqualToString:@""]) {
                                                  canadaInfoObject.imageHref = @"";
                                              } else {
                                                  canadaInfoObject.imageHref = imageHrefString;
                                              }
                                              
                                              [canadaInfoArray addObject: canadaInfoObject];
                                              
                                          } // for end
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              //UI update code goes here
                                              self.navigationItem.title = title;
                                              [canadaMasterTableView reloadData];
                                          });
                                      }
                                  }];
    
    [task resume];
}

-(id)checkForNull:(id)value {
    if ([value isEqual:[NSNull null]]) {
        return @"";
    } else if (value == nil) {
        return @"";
    }
    return value;
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return canadaInfoArray.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CandaInfoCell";
    
    CanadaInfoTableViewCell *cell = (CanadaInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CanadaInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CanadaInfo *canadaInfo = [canadaInfoArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = canadaInfo.titleDetail;
    
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected %ld row", (long)indexPath.row);
}

@end
