//
//  LHSCategoriesFlowView.h
//  LHSCategoriesFlowView
//
//  Created by Daniel Loewenherz on 9/3/15.
//  Copyright (c) 2015 Lionheart Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LHSCategoriesFlowView : UIView

- (instancetype)initWithTitles:(NSArray *)titles;
- (instancetype)initWithTitles:(NSArray *)titles labelClass:(Class)labelClass;
- (instancetype)initWithTitles:(NSArray *)titles labelClass:(Class)labelClass width:(CGFloat)width;
- (instancetype)initWithTitles:(NSArray *)titles labelClass:(Class)labelClass width:(CGFloat)width verticalMargin:(CGFloat)margin;

@end
