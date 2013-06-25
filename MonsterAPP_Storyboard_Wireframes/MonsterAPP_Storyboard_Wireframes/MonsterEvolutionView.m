//
//  MonsterEvolutionView.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Sonam Dhingra on 6/24/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "MonsterEvolutionView.h"

@implementation MonsterEvolutionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)evol1Animate
{
    NSArray *turtleWobble;
    turtleWobble = [NSArray arrayWithObjects:
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-1.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-2.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-3.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-4.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-3.png"], [UIImage imageNamed:@"turtling-ev1-for-TaskView-2.png"],  [UIImage imageNamed:@"turtling-ev1-for-TaskView-1.png"],nil];
    
    self.wobbleView.animationImages = turtleWobble;
    self.wobbleView.animationDuration = 1.0f;
    //self.stillStickFigureImageView.alpha = 0;
    
    [self.wobbleView startAnimating];
}



@end
