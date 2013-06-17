//
//  Monster.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by ehochs  on 6/17/13.
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
@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) NSSet *evolutions;
@end

@interface Monster (CoreDataGeneratedAccessors)

- (void)addEvolutionsObject:(Evolution *)value;
- (void)removeEvolutionsObject:(Evolution *)value;
- (void)addEvolutions:(NSSet *)values;
- (void)removeEvolutions:(NSSet *)values;

@end
