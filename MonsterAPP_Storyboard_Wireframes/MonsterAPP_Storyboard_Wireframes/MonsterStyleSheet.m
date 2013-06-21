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
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:@"LunchBox-Bold" size:24.0],UITextAttributeFont, nil];
    [navigationBarAppearance setTitleTextAttributes: textAttributes];
    
#pragma
#pragma BackButton Attributes
    //ideally, set up @2x images, landscape.
    
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

    UIImage *barButtonImage = [[UIImage imageNamed:@"monsterNavBar-stretchyButton.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] ;
    UIImage *barButtonTappedImage = [[UIImage imageNamed:@"monsterNavBar-stretchyButton-tapped.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] ;
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage
                                            forState:UIControlStateNormal |UIControlStateHighlighted
                                               style:UIBarButtonItemStyleBordered
                                          barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonTappedImage
                                            forState:UIControlStateSelected
                                               style:UIBarButtonItemStyleBordered
                                          barMetrics:UIBarMetricsDefault];
    
}


@end
