//
//  LHSCategoriesFlowView.m
//  LHSCategoriesFlowView
//
//  Created by Daniel Loewenherz on 9/3/15.
//  Copyright (c) 2015 Lionheart Software LLC. All rights reserved.
//

#import "LHSCategoriesFlowView.h"

@implementation LHSCategoriesFlowView

- (instancetype)initWithTitles:(NSArray *)titles labelClass:(__unsafe_unretained Class)labelClass {
    self = [super init];
    if (self) {
        CGFloat width = 200;
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
            currentRowWidth += labelWidth;
        }
        
        [rows addObject:[self rowWithLabels:labels]];
        
        for (NSInteger i=0; i<rows.count; i++) {
            UIView *row = rows[i];
            [self addSubview:row];
            
            NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"|[view(width)]" options:0 metrics:@{@"width": @(300)} views:@{@"view": row}];
            [self addConstraints:widthConstraint];
            
            if (i == 0) {
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:row
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:15];
                
                [self addConstraint:constraint];
            }
            else {
                UIView *previousRow = rows[i-1];
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:row
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:previousRow
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1
                                                                               constant:5];
                
                [self addConstraint:constraint];
            }
        }
    }
    return self;
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
    
    CGFloat marginBetweenLabels = 10;
    
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
                                                                                 constant:marginBetweenLabels];
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
