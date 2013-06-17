//
//  User.h
//  MonsterAPP_Storyboard_Wireframes
//
<<<<<<< HEAD
//  Created by Administrator on 6/10/13.
=======
//  Created by Erin Hochstatter on 6/14/13.
>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

<<<<<<< HEAD

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSDate * dateCreated;
=======
@class Task;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;
>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de

@end
