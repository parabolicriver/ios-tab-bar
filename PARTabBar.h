//
//  PARTabBar.h
//  PARTabBar
//
//  Created by Anuj Seth on 2/13/13.
//  Copyright (c) 2013 Parabolic River. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PARTabBar;

@protocol PARTabBarDelegate <NSObject>

// required cause otherwise its kind of useless
@required

// The user changed to a tab with index. Only
// called if the new selection is different from
// the current one.
- (void)tabBar:(PARTabBar *)tabBar didSelectItemIndex:(NSUInteger)itemIndex;

@end

// A custom tab bar for ready made tabs. Useful
// when you want to directly use your exported
// tab images from Inkscape, Photoshop etc.
@interface PARTabBar : UIView

@property (nonatomic, assign) id<PARTabBarDelegate> delegate;
// the count should be the same, and the image
// frames should add up to the tab bar frame,
// else it explodes
@property (nonatomic, strong) NSArray *normalImages;
@property (nonatomic, strong) NSArray *activeImages;
@property (nonatomic, assign) NSUInteger initiallySelectedIndex;

@end
