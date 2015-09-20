//
//  LHSCategoriesFlowView.m
//  LHSCategoriesFlowView
//
//  Created by Daniel Loewenherz on 9/3/15.
//  Copyright (c) 2015 Lionheart Software LLC. All rights reserved.
//

#import "LHSCategoriesFlowView.h"

static const CGFloat kLHSCategoriesHorizontalMargin = 10;

@implementation LHSCategoriesFlowView

- (instancetype)initWithTitles:(NSArray *)titles
                    labelClass:(__unsafe_unretained Class)labelClass
                         width:(CGFloat)width
                verticalMargin:(CGFloat)margin {
    self = [super init];
    if (self) {
        UIView *containerView = [[UIView alloc] init];
        containerView.translatesAutoresizingMaskIntoConstraints = NO;

        [self addSubview:containerView];

        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:containerView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:0];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:containerView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                               toItem:containerView
                                                                            attribute:NSLayoutAttributeHeight
                                                                           multiplier:1
                                                                             constant:0];
        
        [self addConstraints:@[leftConstraint, rightConstraint, topConstraint, bottomConstraint]];

        CGFloat currentRowWidth = 0;

        UIFont *font = [UIFont systemFontOfSize:16];
        
        NSMutableArray *rows = [NSMutableArray array];
        NSMutableArray *labels = [NSMutableArray array];
        
        // For each row, set the width to the max width.
        for (NSString *tag in titles) {
            UILabel *label = [[labelClass alloc] init];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.text = tag;
            label.font = font;
            
#ifdef CATEGORIES_LIST_VIEW_DEBUG
            label.backgroundColor = [UIColor redColor];
#endif
            
            CGSize size = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            CGFloat labelWidth = size.width;
            
            if (labelWidth + currentRowWidth >= width) {
                UIView *row = [self rowWithLabels:labels];
                
                [rows addObject:row];
                
                [labels removeAllObjects];
                currentRowWidth = 0;
            }
            
            [labels addObject:label];
            currentRowWidth += labelWidth + kLHSCategoriesHorizontalMargin;
        }
        
        [rows addObject:[self rowWithLabels:labels]];
        
        for (NSInteger i=0; i<rows.count; i++) {
            UIView *row = rows[i];
            [containerView addSubview:row];
            
            NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"|[view(width)]"
                                                                               options:0
                                                                               metrics:@{@"width": @(width)}
                                                                                 views:@{@"view": row}];
            [containerView addConstraints:widthConstraint];
            
            if (i == 0) {
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:row
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:0];
                
                [containerView addConstraint:constraint];
            }
            else {
                UIView *previousRow = rows[i-1];
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:row
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:previousRow
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1
                                                                               constant:margin];
                
                [containerView addConstraint:constraint];
            }
            
            if (i == rows.count - 1) {
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:row
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1
                                                                               constant:0];
                
                [containerView addConstraint:constraint];
            }
        }
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles labelClass:(Class)labelClass width:(CGFloat)width {
    return [self initWithTitles:titles labelClass:labelClass width:200 verticalMargin:5];
}

- (instancetype)initWithTitles:(NSArray *)titles labelClass:(Class)labelClass {
    return [self initWithTitles:titles labelClass:labelClass width:200];
}

- (instancetype)initWithTitles:(NSArray *)titles {
    return [self initWithTitles:titles labelClass:[UILabel class]];
}

- (UIView *)rowWithLabels:(NSMutableArray *)labels {
    // Create a row and add all of the current labels to it.
    UIView *row = [[UIView alloc] init];
    row.translatesAutoresizingMaskIntoConstraints = NO;
    
#ifdef CATEGORIES_LIST_VIEW_DEBUG
    row.backgroundColor = [UIColor blueColor];
#endif

    // Represents the view that holds all of the labels and centers them
    UIView *container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
#ifdef CATEGORIES_LIST_VIEW_DEBUG
    container.backgroundColor = [UIColor greenColor];
#endif
    
    [row addSubview:container];
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    for (NSInteger i=0; i<labels.count; i++) {
        UILabel *label = labels[i];
        [container addSubview:label];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:container
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:0];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:container
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1
                                                                             constant:0];
        [constraints addObjectsFromArray:@[topConstraint, bottomConstraint]];
        
        if (i == 0) {
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:container
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1
                                                                               constant:0];
            [constraints addObject:leftConstraint];
        }
        else {
            UILabel *previousLabel = labels[i-1];
            
            NSLayoutConstraint *marginConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:previousLabel
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:kLHSCategoriesHorizontalMargin];
            [constraints addObject:marginConstraint];
        }
        
        if (i == labels.count - 1) {
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:0];
            [constraints addObject:rightConstraint];
        }
    }
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:row
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:container
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:row
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:container
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
    [constraints addObjectsFromArray:@[topConstraint, bottomConstraint]];
    
    NSLayoutConstraint *fullWidthConstraint = [NSLayoutConstraint constraintWithItem:container
                                                                           attribute:NSLayoutAttributeCenterX
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:row
                                                                           attribute:NSLayoutAttributeCenterX
                                                                          multiplier:1
                                                                            constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, bottomConstraint, fullWidthConstraint]];
    [row addConstraints:constraints];
    return row;
}

@end
