//
//  MonsterStyleSheet.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by ehochs  on 6/16/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "MonsterStyleSheet.h"

@implementation MonsterStyleSheet

+(void)applyStyle{
    
    //sets UINavBar image.
    //ideally, set up @2x images, landscape.
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"monsterNavBar.png"]  forBarMetrics:UIBarMetricsDefault];
    
    
#pragma
#pragma NavBar Text Attributes
    //probably want to keep normal font (just playing for now)
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:@"LunchBox-Bold" size:12.0],UITextAttributeFont, nil];
    [navigationBarAppearance setTitleTextAttributes: textAttributes];
    
#pragma
#pragma BackButton Attributes
    //ideally, set up @2x images, landscape.
    
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    
    int imageSize = 44; //image width
    
    UIImage *barItemBackDefaultImg = [[UIImage imageNamed:@"monsterNavBar_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, imageSize, 0, 0)];
    UIImage *barItemBackSelectImg = [[UIImage imageNamed:@"monsterNavBar_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, imageSize, 0, 0)];
    
    [barButtonItemAppearance setBackButtonBackgroundImage: barItemBackDefaultImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage: barItemBackSelectImg forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, imageSize*2) forBarMetrics:UIBarMetricsDefault]; //this one scoots the default title offscreen.
    
    
    
    UIImage *doneButtonImage = [[UIImage imageNamed:@"monsterNavBar-done.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, imageSize, 0, 0)];
    UIImage *doneButtonTappedImage = [[UIImage imageNamed:@"monsterNavBar-done_tapped.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, imageSize, 0, 0)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:doneButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:doneButtonTappedImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -88.0) forBarMetrics:UIBarMetricsDefault];
    

}


@end
