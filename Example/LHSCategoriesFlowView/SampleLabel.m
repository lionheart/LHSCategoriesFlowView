//
//  SampleLabel.m
//  LHSCategoriesFlowView
//
//  Created by Daniel Loewenherz on 9/3/15.
//  Copyright © 2015 Dan Loewenherz. All rights reserved.
//

#import "SampleLabel.h"

@interface SampleLabel ()

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation SampleLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor grayColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.edgeInsets.left + self.edgeInsets.right;
    size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return size;
}

@end
