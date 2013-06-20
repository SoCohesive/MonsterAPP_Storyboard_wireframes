//
//  SparkleImageView.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "SparkleImageView.h"

@implementation SparkleImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)rotateShine{
    
    [UIView animateWithDuration: 1.0
                          delay: 0.2f
                        options:((UIViewAnimationOptions)(UIViewAnimationCurveEaseOut))
                     animations:^{
                         
                         [UIView setAnimationRepeatCount:5];
                         self.transform = CGAffineTransformMakeRotation(135 *M_PI/180);
                     }
     
                     completion:^(BOOL finished)
                     {
                         NSLog(@"SparkleDone!");
                     }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
