//
//  TaskDetail.h
//  MonsterAPP_Storyboard_Wireframes
//
<<<<<<< HEAD
//  Created by Administrator on 6/10/13.
=======
//  Created by Erin Hochstatter on 6/13/13.
>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

<<<<<<< HEAD

@interface TaskDetail : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSNumber * taskID;
@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSNumber * stepNumber;
@property (nonatomic, retain) NSString * stepHeader;
@property (nonatomic, retain) NSString * stepDetail;
@property (nonatomic, retain) NSNumber * stepHP;
@property (nonatomic, retain) NSNumber * stepXP;
@property (nonatomic, retain) NSNumber * stepCompleted;
@property (nonatomic, retain) NSDate * stepCompletedDate;
@property (nonatomic, retain) NSDate * stepCreatedDate;
=======
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
@property (nonatomic, retain) Task *task;
>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de

@end
