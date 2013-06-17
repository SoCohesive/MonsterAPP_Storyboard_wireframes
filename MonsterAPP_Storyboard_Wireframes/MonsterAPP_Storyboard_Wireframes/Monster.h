//
//  Monster.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/17/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Evolution, Task;

@interface Monster : NSManagedObject

@property (nonatomic, retain) NSString * monsterDescription;
@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSString * monsterName;
@property (nonatomic, retain) NSString * monsterType;
@property (nonatomic, retain) NSSet *evolutions;
@property (nonatomic, retain) Task *task;
@end

@interface Monster (CoreDataGeneratedAccessors)

- (void)addEvolutionsObject:(Evolution *)value;
- (void)removeEvolutionsObject:(Evolution *)value;
- (void)addEvolutions:(NSSet *)values;
- (void)removeEvolutions:(NSSet *)values;

@end
