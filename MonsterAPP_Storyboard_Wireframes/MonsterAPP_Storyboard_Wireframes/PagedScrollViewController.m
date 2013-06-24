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
    
        }
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
