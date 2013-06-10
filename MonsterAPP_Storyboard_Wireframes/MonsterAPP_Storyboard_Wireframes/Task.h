//
//  Task.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Administrator on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


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

@end
