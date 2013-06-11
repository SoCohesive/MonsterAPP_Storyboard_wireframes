//
//  User.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Administrator on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * userID;

@end
