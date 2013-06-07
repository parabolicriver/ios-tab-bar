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

#define kDefaultTag                     -1

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

@interface PARTabBar ()

@property (nonatomic, assign) BOOL setup;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) NSMutableArray *tabImageViews;
@property (nonatomic, strong) NSMutableArray *tabTapGRs;

- (void)viewTapped:(id)sender;

@end

@implementation PARTabBar

#pragma mark - Setup and Teardown

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _setup = NO;
        // initially we don't have a valid selection
        self.selectedIndex = kDefaultInvalidSelectedIndex;
    }
    
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

#pragma mark - Layout and Drawing

// Layout the tabs.
- (void)layoutSubviews
{
    // only if consistent data provided
    if (self.normalImages && self.activeImages && self.normalImages.count == self.activeImages.count)
    {
        // Note:
        // We do all calculations from the provided normal
        // images collection. Active images should be the
        // same sizes. 
        
        int nTabs = self.normalImages.count;
        
        // provided image height should be same as
        // the tab bar frame height
        CGFloat tabHeight = self.bounds.size.height;
        
        // calculate tab widths from images
        NSMutableArray *tabWidths = [[NSMutableArray alloc] initWithCapacity:nTabs];
        for (int i = 0; i < nTabs; i++)
        {
            UIImage *currentImage = [self.normalImages objectAtIndex:i];
            CGFloat currentImageWidth = currentImage.size.width;
            [tabWidths addObject:[NSNumber numberWithFloat:currentImageWidth]];
        }
        
        // Note:
        // At this point we could do a check that
        // the tab image widths add up to the tab
        // bar frame width, but we don't as hopefully
        // you're more interested in a tab bar than
        // screen junk, aka have done your math.
        
        // setup
        if (!self.setup)
        {
            // check if we have a valid tab we
            // can select on load
            if (self.initiallySelectedIndex >= nTabs)
            {
                self.selectedIndex = kDefaultValidSelectedIndex;
            }
            else
            {
                self.selectedIndex = self.initiallySelectedIndex;
            }
            
            self.tabImageViews = [[NSMutableArray alloc] initWithCapacity:nTabs];
            self.tabTapGRs = [[NSMutableArray alloc] initWithCapacity:nTabs];
            for (int i = 0; i < nTabs; i++)
            {
                // setup on screen tab visuals
                UIImageView *iv = [[UIImageView alloc] init];
                CGFloat x = 0.0f;
                for (int j = 0; j < i; j++)
                {
                    x += ((NSNumber *) [tabWidths objectAtIndex:j]).doubleValue;
                }
                iv.frame = CGRectMake(x, 0.0f, ((NSNumber *) [tabWidths objectAtIndex:i]).doubleValue, tabHeight);
                iv.userInteractionEnabled = YES;
                [self addSubview:iv];
                [self.tabImageViews insertObject:iv atIndex:i];
                
                // setup on screen tab interaction
                PARTaggedTapGestureRecognizer *ttgr = [[PARTaggedTapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
                ttgr.tag = i;
                [iv addGestureRecognizer:ttgr];
                [self.tabTapGRs insertObject:ttgr atIndex:i];
            }
        } // setup
        
        // add images
        for (int i = 0; i < nTabs; i++)
        {
            // active image
            if (i == self.selectedIndex)
            {
                UIImage *ai = [self.activeImages objectAtIndex:i];
                UIImageView *iv = [self.tabImageViews objectAtIndex:i];
                iv.image = ai;
            }
            // normal images
            else
            {
                UIImage *ni = [self.normalImages objectAtIndex:i];
                UIImageView *iv = [self.tabImageViews objectAtIndex:i];
                iv.image = ni;
            }
        }
        
        // call the delegate the first time around also
        // to allow initial tab setup
        if (!self.setup)
        {
            self.setup = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemIndex:)])
            {
                [self.delegate tabBar:self didSelectItemIndex:self.selectedIndex];
            }
        }
    } // valid data
    else
    {
        // noting yet, but ideally throw an
        // exception or something
    } // invalid data
} // layout subviews

#pragma mark - Gesture Handling

- (void)viewTapped:(id)sender
{
    PARTaggedTapGestureRecognizer *ttgr = (PARTaggedTapGestureRecognizer *) sender;
    
    // selection
    int selectedTab = ttgr.tag;
    
    // ignore re-selections
    if (self.selectedIndex != selectedTab)
    {
        // check if should select is implemented
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemIndex:)])
        {
            // can we go ahead with the tab
            // change ?
            BOOL allowTabChange = [self.delegate tabBar:self shouldSelectItemIndex:selectedTab];
            if (!allowTabChange)
            {
                return;
            }
        }
        
        // update selection
        self.selectedIndex = selectedTab;
        
        // redraw
        [self setNeedsLayout];
        
        // tell the delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemIndex:)])
        {
            [self.delegate tabBar:self didSelectItemIndex:self.selectedIndex];
        }
    }
}

#pragma mark - Tab Bar Helpers

- (void)selectItemIndex:(NSUInteger)itemIndex
{
    // selection validity
    int selectedTab = itemIndex;
    int nTabs = self.normalImages.count;
    if (selectedTab >= nTabs)
    {
        return; // invalid index
    }
    
    // ignore re-selections
    if (self.selectedIndex != selectedTab)
    {
        // update selection
        self.selectedIndex = selectedTab;
        
        // redraw
        [self setNeedsLayout];
        
        // tell delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemIndex:)])
        {
            [self.delegate tabBar:self didSelectItemIndex:self.selectedIndex];
        }
    }
}

@end
