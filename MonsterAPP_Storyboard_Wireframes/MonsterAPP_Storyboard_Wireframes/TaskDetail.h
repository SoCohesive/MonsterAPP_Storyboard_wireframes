//
//  TaskDetail.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/18/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface TaskDetail : NSManagedObject

@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSNumber * stepCompleted;
@property (nonatomic, retain) NSDate * stepCompletedDate;
@property (nonatomic, retain) NSDate * stepCreatedDate;
@property (nonatomic, retain) NSString * stepDetail;
@property (nonatomic, retain) NSString * stepHeader;
@property (nonatomic, retain) NSNumber * stepHP;
@property (nonatomic, retain) NSNumber * stepNumber;
@property (nonatomic, retain) NSNumber * stepXP;
@property (nonatomic, retain) NSNumber * taskID;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSNumber * possStepXP;
@property (nonatomic, retain) Task *task;

@end
