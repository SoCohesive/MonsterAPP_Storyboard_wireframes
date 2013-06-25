//
//  SelectedTaskDelegate.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/25/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectedTaskDelegate <NSObject>
-(void)selectedValueIs: (Task*) delegateTask;

@end
