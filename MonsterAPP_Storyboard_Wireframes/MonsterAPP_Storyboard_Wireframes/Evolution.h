//
//  Evolution.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/17/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Monster;

@interface Evolution : NSManagedObject

@property (nonatomic, retain) NSString * eggImageName;
@property (nonatomic, retain) NSString * evolutionDescription;
@property (nonatomic, retain) NSString * thumbnailName;
@property (nonatomic, retain) NSNumber * evolutionNumber;
@property (nonatomic, retain) Monster *monster;

@end
