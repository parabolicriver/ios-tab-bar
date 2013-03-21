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

@optional

// The user changed to a tab with index. Only
// called if the new selection is different from
// the current one. It is also called the first
// time the tab bar comes up on screen.
- (void)tabBar:(PARTabBar *)tabBar didSelectItemIndex:(NSUInteger)itemIndex;

// If implemented will pause switching tabs
// if you return NO and then you can change
// tabs manually after an alert view returns
// for example. Return YES to change tabs
// immediately.
- (BOOL)tabBar:(PARTabBar *)tabBar shouldSelectItemIndex:(NSUInteger)itemIndex;

@end

// A custom tab bar for ready made tabs. Useful
// when you want to directly use your exported
// tab images from Inkscape, Photoshop etc.
@interface PARTabBar : UIView

@property (nonatomic, assign) id<PARTabBarDelegate> delegate;

// the counts should be the same, and the image
// frames should add up to the tab bar frame,
// else it explodes
@property (nonatomic, strong) NSArray *normalImages;
@property (nonatomic, strong) NSArray *activeImages;

// select this tab initially
@property (nonatomic, assign) NSUInteger initiallySelectedIndex;

// manually change tabs, does 'not' call
// tabBar:shouldSelectItemIndex; ignores
// re-selections
- (void)selectItemIndex:(NSUInteger)itemIndex;

@end
