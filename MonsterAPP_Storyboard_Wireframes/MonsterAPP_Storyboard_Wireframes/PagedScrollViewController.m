//
//  PagedScrollViewController.m
//  Door_PageViewControllerTest
//
//  Created by Sonam Dhingra on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "PagedScrollViewController.h"

@interface PagedScrollViewController ()

@end

@implementation PagedScrollViewController

@synthesize scrollView;
@synthesize pageControl;
@synthesize pageImages;
@synthesize pageViews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (IBAction)getStartedButton:(id)sender {
    
     self.navigationItem.hidesBackButton = YES;
    [self performSegueWithIdentifier:@"pushToLogin" sender:self];
      
     }

- (void)loadVisiblePages {
    
   
    // First, determine which page is currently visible. the floor() function basically rounds a decimal to closest integer
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
       
    }
    
}

- (void)purgePage:(NSInteger)page {
    
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


-(void)loadPage:(NSInteger)page {
    
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // if the current page is the last page of page images array, unhide button.
    if ( pageControl.currentPage == 2) {
        [self unhideButton];
    }
    
        
    // 1
    UIView *pageView = [self.pageViews objectAtIndex:page];
    
    // Check to see if you have loaded the view
    if ((NSNull*)pageView == [NSNull null]) {
        // Since the view is null, you need to create a new view for the first page. First thing to do is set its size
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        // Add an imageView to the page
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        
        // Replace the Null page with this new view. So now you have added a page + imageView. So if this method was called again it would do nothing, since the page has been created
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

-(void) unhideButton {
    
    
    [UIView animateWithDuration:.7f
                          delay:.3f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        
        self.getStartedButton.hidden = NO;
        self.getStartedButton.alpha = 1;
        
    } completion:^(BOOL finished) {
       
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
     self.navigationItem.hidesBackButton = YES;
    self.getStartedButton.hidden = YES;
    self.getStartedButton.alpha = 0;
    
    //Add images to array
    self.pageImages = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"onboarding-1.png"],
                       [UIImage imageNamed:@"onboarding-2.png"],
                       [UIImage imageNamed:@"onboarding-3.png"], nil];
    
    //set up number of pages for page control
    NSInteger pageCount = self.pageImages.count;
    
    self.pageControl.currentPage=0;
    self.pageControl.numberOfPages = pageCount;
    
    
    // allocate views for NSMutablearray. Each view will have its own image so you can swipe through them
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i < pageCount; i++) {
        [self.pageViews addObject:[NSNull null]];
               
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Srollview needs to know content size, so here I set basically tell it to be the size of the images. Since this is a horizontal scrollView you want the width to be as wide as the number of pages. So lets say you have 3 pictures, you want the scrollView to be 3 times its size so that it fits 3 pages.  
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // 5
    [self loadVisiblePages];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
