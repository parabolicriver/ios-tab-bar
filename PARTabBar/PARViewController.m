//
//  PARViewController.m
//  PARTabBar
//
//  Created by Anuj Seth on 2/13/13.
//  Copyright (c) 2013 Parabolic River. All rights reserved.
//

#import "PARViewController.h"

#define kiPhoneTabBarWidth          320
#define kiPhoneTabBarHeight         51
#define kiPadTabBarWidth            768
#define kiPadTabBarHeight           51

@interface PARViewController ()

@end

@implementation PARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // iPad size tab bar
    PARTabBar *iPadTabBar = [[PARTabBar alloc] init];
    iPadTabBar.frame = CGRectMake(0, 0, kiPadTabBarWidth, kiPadTabBarHeight);
    iPadTabBar.delegate = self;
    
    UIImage *aboutTabImage = [UIImage imageNamed:@"ipad_about"];
    UIImage *aboutActiveTabImage = [UIImage imageNamed:@"ipad_about_active"];
    UIImage *planTabImage = [UIImage imageNamed:@"ipad_plan"];
    UIImage *planTabImageActive = [UIImage imageNamed:@"ipad_plan_active"];
    UIImage *settingsTabImage = [UIImage imageNamed:@"ipad_settings"];
    UIImage *settingsActiveTabImage = [UIImage imageNamed:@"ipad_settings_active"];
    UIImage *shareTabImage = [UIImage imageNamed:@"ipad_share"];
    UIImage *shareTabImageActive = [UIImage imageNamed:@"ipad_share_active"];
    
    iPadTabBar.normalImages = [NSArray arrayWithObjects:aboutTabImage, planTabImage, settingsTabImage, shareTabImage, nil];
    iPadTabBar.activeImages = [NSArray arrayWithObjects:aboutActiveTabImage, planTabImageActive, settingsActiveTabImage, shareTabImageActive, nil];
    
    iPadTabBar.initiallySelectedIndex = 2;
    
    [self.view addSubview:iPadTabBar];
    
    // iPhone size tab bar
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tab Bar Delegate

- (void)tabBar:(PARTabBar *)tabBar didSelectItemIndex:(NSUInteger)itemIndex
{
    NSLog(@"tab bar %@ selection tab with index %d.", tabBar, itemIndex);
}

@end
