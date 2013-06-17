//
//  Task.h
//  MonsterAPP_Storyboard_Wireframes
//
<<<<<<< HEAD
//  Created by Administrator on 6/10/13.
=======
//  Created by Erin Hochstatter on 6/17/13.
>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

<<<<<<< HEAD

@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSNumber * taskID;
@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSNumber * possibleHP;
@property (nonatomic, retain) NSNumber * possibleXP;
@property (nonatomic, retain) NSNumber * actualHP;
@property (nonatomic, retain) NSNumber * actualXP;
@property (nonatomic, retain) NSDate * projectedStartDate;
@property (nonatomic, retain) NSDate * projectedEndDate;
@property (nonatomic, retain) NSDate * dateCreated;
=======
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
@property (nonatomic, retain) NSNumber * taskComplete;
@property (nonatomic, retain) NSNumber * taskID;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSString * taskType;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) Monster *monster;
@property (nonatomic, retain) NSSet *taskDetails;
@property (nonatomic, retain) User *user;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addTaskDetailsObject:(TaskDetail *)value;
- (void)removeTaskDetailsObject:(TaskDetail *)value;
- (void)addTaskDetails:(NSSet *)values;
- (void)removeTaskDetails:(NSSet *)values;
>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de

@end
