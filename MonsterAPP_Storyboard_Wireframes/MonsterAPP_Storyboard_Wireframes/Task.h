//
//  Task.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/14/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Monster, TaskDetail, User;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * actualHP;
@property (nonatomic, retain) NSNumber * actualXP;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSNumber * possibleHP;
@property (nonatomic, retain) NSNumber * possibleXP;
@property (nonatomic, retain) NSDate * projectedEndDate;
@property (nonatomic, retain) NSDate * projectedStartDate;
@property (nonatomic, retain) NSNumber * taskID;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * taskType;
@property (nonatomic, retain) Monster *monster;
@property (nonatomic, retain) NSSet *taskDetails;
@property (nonatomic, retain) User *user;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addTaskDetailsObject:(TaskDetail *)value;
- (void)removeTaskDetailsObject:(TaskDetail *)value;
- (void)addTaskDetails:(NSSet *)values;
- (void)removeTaskDetails:(NSSet *)values;

@end
