//
//  ViewController.m
//  AutoLayout
//
//  Created by mfw on 14-10-10.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import "ViewController.h"

static int tmp = 1;
static NSString *str;
static NSString *str2;

@interface ViewController ()

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;

@end

@implementation ViewController

@synthesize topLabel;
@synthesize secondLabel;
@synthesize thirdLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    str = @"64位处理器有两大优点，可以进行更大范围的整数运算，可支持更大的内存。但是现在呢，首先iPhone 6是配的1GB内存，而国产采用骁龙410的智能手机，居然也只配了1GB内存，说好的4GB内存去哪了呢。听说索尼下一代旗舰会采用骁龙810处理器，搭配4GB内存，我觉得这还是可以理解的，并且会发挥64位的效能，否则的话，64位处理器我们就当32位处理器看待就好了。当然，如果是原价不变的升级，还是很可以接受的，同时，如果是一个负责任的厂商，未来还会推送Android L操作系统，那就更好了。但现在看，64位处理器除非在旗舰机上，否则可以忽略。";
    str2 = @"小米昨日低调发布四款智能家居新品，小米智能家居系统又添新。有人认为，小米智能家居生态正在日益完善，但也有诸多质疑，数据和生态智慧的不完善，小米硬件销量下滑，让看上去很美的智能家居梦短期难圆。";
    
    topLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    topLabel.backgroundColor = [UIColor lightGrayColor];
    topLabel.numberOfLines = 0;
    topLabel.text = str;
    [self.view addSubview:topLabel];
    
    secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    secondLabel.backgroundColor = [UIColor cyanColor];
    secondLabel.text = @"按我";
    secondLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeThirdLabel:)];
    [secondLabel addGestureRecognizer:tap];
    [self.view addSubview:secondLabel];
    
    thirdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    thirdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    thirdLabel.backgroundColor = [UIColor purpleColor];
    thirdLabel.numberOfLines = 0;
    thirdLabel.text = str;
    [self.view addSubview:thirdLabel];
    
#pragma mark - setRelationPositon
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:topLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:topLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
    
    [self.view addConstraint:widthConstraint];
    [self.view addConstraint:heightConstraint];

    //TODO:autolayout
    //设置view之间长度相等，并且在试图在边缘内(超过边缘自动往下)
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topLabel][secondLabel(==topLabel)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLabel, secondLabel)]];
    
    //设置高度，距顶部20，之间间隔10，secondLabel高度为30，只是上面对齐下面不对齐
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[topLabel(>=20@400)]-10-[secondLabel(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLabel, secondLabel)]];
    
#pragma mark - thirdLabel
    //水平居中，始终距离父View底部20单位的距离。然后高度是父View高度的5分之一
    //居中
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
     //距离底部50,注意NSLayoutConstraint创建的constant是加在toItem参数的，所以需要-20。
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50]];
    //定义高度是父View的5分之一
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:thirdLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    constraint.priority = UILayoutPriorityDefaultHigh;
    [self.view addConstraint:constraint];
    //最小高度为150
    [thirdLabel addConstraint:[NSLayoutConstraint constraintWithItem:thirdLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:150]];
    
    //注册KVO方法
    [thirdLabel addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
    
#pragma mark - animate
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//KVO回掉
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == thirdLabel && [keyPath isEqualToString:@"bounds"]) {
//        thirdLabel.text = str;
//        thirdLabel.text = @"ha";
//        thirdLabel.text = NSStringFromCGSize(thirdLabel.bounds.size);
    }
}

- (void)changeThirdLabel:(UITapGestureRecognizer *)tap
{
    if (tmp %2 == 1) {
        thirdLabel.text = str2;
    } else {
        thirdLabel.text = str;
    }
    tmp += 1;
    
}

@end
