//
//  CanadaMasterViewController.h
//  HappeningCanada
//
//  Created by Ani Adhikary on 10/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactsInfo.h"

@interface CanadaMasterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *tableView;
    UIActivityIndicatorView *progressView;
    UIRefreshControl *refreshControl;
    
    FactsInfo *factInfo;
}

@end
