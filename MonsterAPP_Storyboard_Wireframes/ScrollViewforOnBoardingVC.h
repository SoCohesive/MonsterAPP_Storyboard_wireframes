//
//  ScrollViewforOnBoardingVC.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Sonam Dhingra on 6/15/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewforOnBoardingVC : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong,nonatomic) NSArray *pageImages;
@property (strong,nonatomic) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;



@end
