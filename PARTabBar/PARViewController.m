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
    
    self.view.backgroundColor = [UIColor whiteColor];

    // iPad size tab bar
    PARTabBar *iPadTabBar = [[PARTabBar alloc] init];
    iPadTabBar.frame = CGRectMake(0, 0, kiPadTabBarWidth, kiPadTabBarHeight);
    iPadTabBar.delegate = self;
    
    // settings and about tabs are wider and come
    // first and last in our design, hence the
    // order change
    UIImage *settingsTabImage = [UIImage imageNamed:@"ipad_settings"];
    UIImage *settingsTabImageActive = [UIImage imageNamed:@"ipad_settings_active"];
    UIImage *planTabImage = [UIImage imageNamed:@"ipad_plan"];
    UIImage *planTabImageActive = [UIImage imageNamed:@"ipad_plan_active"];
    UIImage *shareTabImage = [UIImage imageNamed:@"ipad_share"];
    UIImage *shareTabImageActive = [UIImage imageNamed:@"ipad_share_active"];
    UIImage *aboutTabImage = [UIImage imageNamed:@"ipad_about"];
    UIImage *aboutTabImageActive = [UIImage imageNamed:@"ipad_about_active"];
    
    iPadTabBar.normalImages = [NSArray arrayWithObjects:settingsTabImage, planTabImage, shareTabImage, aboutTabImage, nil];
    iPadTabBar.activeImages = [NSArray arrayWithObjects:settingsTabImageActive, planTabImageActive, shareTabImageActive, aboutTabImageActive, nil];
    
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
