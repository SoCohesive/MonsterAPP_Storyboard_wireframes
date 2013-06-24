//
//  MonsterStyleSheet.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by ehochs  on 6/16/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "MonsterStyleSheet.h"
#import "LoginViewController.h"
#import "ProjectNameVC.h"

@implementation MonsterStyleSheet

+(void)applyStyle{

    
#pragma
#pragma Navigation Bar Appearance

    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"monsterNavBar.png"]  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleVerticalPositionAdjustment:5.0f forBarMetrics:UIBarMetricsDefault];

    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:@"LunchBox-Bold" size:18.0],UITextAttributeFont, nil];
    [navigationBarAppearance setTitleTextAttributes: textAttributes];
    
    
#pragma
#pragma BackButton Attributes
    
    int imageSize = 44; //image width
    
    UIImage *barItemBackDefaultImg = [[UIImage imageNamed:@"monsterNavBar_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, imageSize, 0, 0)];
    UIImage *barItemBackSelectImg = [[UIImage imageNamed:@"monsterNavBar_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, imageSize, 0, 0)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage: barItemBackDefaultImg
                                                 forState:UIControlStateNormal
                                               barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage: barItemBackSelectImg
                                                 forState:UIControlStateSelected
                                               barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, imageSize*2)
                                                         forBarMetrics:UIBarMetricsDefault]; //this one scoots the default title offscreen.
    
    UIImage *barButtonImage = [[UIImage imageNamed:@"monsterNavBar-stretchyButton.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0] ;
    UIImage *barButtonTappedImage = [[UIImage imageNamed:@"monsterNavBar-stretchyButton-tapped.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0] ;

    [[UIBarButtonItem appearance] setTintColor: [UIColor purpleColor]];
        
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage
                                            forState:UIControlStateNormal
                                               style:UIBarButtonItemStyleBordered
                                          barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonTappedImage
                                            forState:UIControlStateHighlighted
                                               style:UIBarButtonItemStyleBordered
                                          barMetrics:UIBarMetricsDefault];
 
    [[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 1.f) forBarMetrics:UIBarMetricsDefault];
}


@end
