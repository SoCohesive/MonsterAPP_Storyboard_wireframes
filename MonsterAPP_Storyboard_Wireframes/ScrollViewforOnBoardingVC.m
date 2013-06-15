//
//  ScrollViewforOnBoardingVC.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Sonam Dhingra on 6/15/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ScrollViewforOnBoardingVC.h"

@interface ScrollViewforOnBoardingVC ()

-(void)setUpScrollView; 

@end

@implementation ScrollViewforOnBoardingVC
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


//const CGFloat kScrollObjHeight	= 199.0;
//const CGFloat kScrollObjWidth	= 280.0;
const NSUInteger kNumImages		= 3;

-(void) pageTurn {
    float width = self.scrollView.frame.size.width;
    int whichPage = self.pageControl.currentPage;
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         
                         self.scrollView.contentOffset = CGPointMake(width * whichPage, 0.0f);
    }];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //update page control to match the current scrolled view
    CGPoint offset = self.scrollView.contentOffset;
    float width = self.scrollView.frame.size.width;
    pageControl.currentPage = offset.x / width;
    
//    CGFloat pageWidth = self.scrollView.frame.size.width;
//    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    self.pageControl.currentPage = page;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    float width = self.scrollView.frame.size.width;
    self.scrollView.contentSize = CGSizeMake(kNumImages * width, self.scrollView.bounds.size.height);
    
    
    // 1. setup the scrollview for multiple images and add it to the view controller
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	//[self.scrollView setCanCancelContentTouches:NO];
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	//self.scrollView.clipsToBounds = YES;
	self.scrollView.scrollEnabled = YES;
	self.scrollView.pagingEnabled = YES;
	
	// load all the images from our bundle and add them to the scroll view
	NSUInteger i;
	for (i = 0; i < kNumImages; i++)
	{
        
        NSString *imageName = [NSString stringWithFormat:@"step%d.png", i +1];
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		// setup each frame to a default height and width

//        imageFrame.size.height = self.scrollView.bounds.size.height;
//		imageFrame.size.width = self.scrollView.bounds.size.width;
        imageView.frame= CGRectMake(i * width, 0.0f, width,width);
        
		//imageView.frame = CGRectMake(i * width, 0.0f, width, width);

		[self.scrollView addSubview:imageView];

    }
    
 //   [self layoutScrollImages];
   // [self.view addSubview:scrollView];
    
    // Set up page control to match scroll
    pageControl.numberOfPages = kNumImages;
    pageControl.currentPage = 0;
    [pageControl addTarget:self
                    action:@selector(pageTurn)
          forControlEvents:UIControlEventValueChanged];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
