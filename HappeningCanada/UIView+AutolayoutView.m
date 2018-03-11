//
//  UIView+AutolayoutView.m
//  HappeningCanada
//
//  Created by Ani Adhikary on 12/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

#import "UIView+AutolayoutView.h"

@implementation UIView (AutolayoutView)

+(id)autolayoutView
{
    //creating UIView Object
    UIView *view = [self new];
    //setting constraint-based layout=NO
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

@end
