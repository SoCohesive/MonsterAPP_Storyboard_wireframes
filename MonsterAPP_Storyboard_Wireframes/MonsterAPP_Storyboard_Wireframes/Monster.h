//
//  Monster.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Administrator on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Monster : NSManagedObject

@property (nonatomic, retain) NSNumber * monsterID;
@property (nonatomic, retain) NSString * monsterName;
@property (nonatomic, retain) NSString * monsterDescription;

@end
