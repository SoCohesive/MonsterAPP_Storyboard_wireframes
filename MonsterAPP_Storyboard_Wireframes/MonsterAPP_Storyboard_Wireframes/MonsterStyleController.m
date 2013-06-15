//
//  MonsterStyleController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by ehochs  on 6/15/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "MonsterStyleController.h"
#import <QuartzCore/QuartzCore.h>


@implementation MonsterStyleController

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
    [barButtonItemAppearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, imageSize*2) forBarMetrics:UIBarMetricsDefault];
  
    
    //trying here to get the damnable title to go away- set the color to clear or purple setting the title to nil crashes. 
    NSDictionary *barItemTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor greenColor],UITextAttributeTextColor, [UIColor redColor], UITextAttributeTextShadowColor, nil];
    [barButtonItemAppearance setTitleTextAttributes:barItemTextAttributes forState:UIControlStateSelected |UIControlStateNormal |UIControlStateHighlighted |UIControlStateHighlighted |UIControlStateApplication];


    //((UIColor*)[[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor])
    //for the other buttons, i think you use identifiers.
    
    
    /*UIBarButtonItem *doneButton =[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"monsterNavBar-done.png"] style:UIBarButtonItemStylePlain target:<#(id)#> action:<#(SEL)#>
    */
    
}

@end
