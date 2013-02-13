//
//  PARTabBar.m
//  PARTabBar
//
//  Created by Anuj Seth on 2/13/13.
//  Copyright (c) 2013 Parabolic River. All rights reserved.
//

#import "PARTabBar.h"

#define kDefaultInvalidSelectedIndex    -1
#define kDefaultValidSelectedIndex       0

#define kDefaultTag                      0

@interface PARTaggedTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic, assign) NSUInteger tag;

@end

@implementation PARTaggedTapGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if (self)
    {
        _tag = kDefaultTag;
    }
    
    return self;
}

@end

@implementation PARTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
