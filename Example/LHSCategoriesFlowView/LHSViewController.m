//
//  LHSViewController.m
//  LHSCategoriesFlowView
//
//  Created by Dan Loewenherz on 09/03/2015.
//  Copyright (c) 2015 Dan Loewenherz. All rights reserved.
//

#import "LHSViewController.h"
#import <LHSCategoriesFlowView/LHSCategoriesFlowView.h>
#import <LHSCategoryCollection/UIView+LHSAdditions.h>

#import "SampleLabel.h"

@interface LHSViewController ()

@end

@implementation LHSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHSCategoriesFlowView *flowView = [[LHSCategoriesFlowView alloc] initWithTitles:@[@"Facebook", @"Twitter", @"Google", @"LinkedIn", @"Microsoft", @"Zynga", @"Groupon"]
                                                                         labelClass:[SampleLabel class]
                                                                              width:150
                                                                     verticalMargin:5];
    flowView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:flowView];
    [self.view lhs_addConstraints:@"V:|-30-[view]-20-|" views:@{@"view": flowView}];
    [self.view lhs_addConstraints:@"H:|-20-[view]-20-|" views:@{@"view": flowView}];
}

@end
