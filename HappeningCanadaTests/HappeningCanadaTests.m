//
//  HappeningCanadaTests.m
//  HappeningCanadaTests
//
//  Created by Ani Adhikary on 15/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CanadaMasterViewController.h"

@interface HappeningCanadaTests : XCTestCase

@property (nonatomic) CanadaMasterViewController *vcToTest;

@end

@interface CanadaMasterViewController (Test)

- (void)fetchDataFromServer;

@end

@implementation HappeningCanadaTests

- (void)setUp {
    [super setUp];
    self.vcToTest = [[CanadaMasterViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testDoSomethingThatTakesSomeTime {
    //XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    [self.vcToTest fetchDataFromServer];
    //[self waitForExpectationsWithTimeout:5.0 handler:nil];
}


@end
