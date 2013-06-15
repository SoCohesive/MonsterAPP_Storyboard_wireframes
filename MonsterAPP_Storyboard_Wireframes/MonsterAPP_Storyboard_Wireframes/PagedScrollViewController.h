//
//  PagedScrollViewController.h
//  Door_PageViewControllerTest
//
//  Created by Sonam Dhingra on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedScrollViewController : UIViewController <UIScrollViewDelegate>

//Array for scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong,nonatomic) NSArray *pageImages;
@property (strong,nonatomic) NSMutableArray *pageViews;


@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;


- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;


@end
