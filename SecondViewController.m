//
//  SecondViewController.m
//  AutoLayout
//
//  Created by mfw on 14-10-11.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import "SecondViewController.h"
#import "MyView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //view1
    MyView *view1 = [[MyView alloc] init];
    view1.backgroundColor = [UIColor yellowColor];
    //不允许AutoresizingMask转换成Autolayout
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view1];
    //设置左，上，右边距为20.
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeLeft constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeTop constant:80];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeRight constant:-20];
    
    
    //view2
    MyView *view2 = [MyView new];
    view2.backgroundColor = [UIColor greenColor];
    //不允许AutoresizingMask转换成Autolayout
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view2];
    //设置左，下，右边距为20.
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeLeft constant:20];
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeBottom constant:-80];
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeRight constant:-20];
    
    //设置两个View上下间距为20
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];

    [view2 setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    
}

//设置Autolayout中的边距辅助方法
- (void)setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superview attribute:attr multiplier:1.0 constant:constant]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
