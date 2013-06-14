//
//  Monster.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/13/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Monster : NSManagedObject

@property (nonatomic, retain) NSString * monsterDescription;
@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSString * monsterName;
@property (nonatomic, retain) Task *task;

@end
