//
//  EggHatchesViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Task.h"
#import "Monster.h"
#import "Evolution.h"


@interface EggHatchesViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *hatchedHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *hatchedLabel;

@property (strong, nonatomic) IBOutlet UITextField *monsterNameField;
@property (strong, nonatomic) NSString *monsterType;
@property (strong, nonatomic) Monster *monster;

@property (strong, nonatomic) Evolution *evolution1;
@property (strong, nonatomic) Evolution *evolution2;
@property (strong, nonatomic) Evolution *evolution3;

@property (strong, nonatomic) NSString *taskDueString;
@property (strong, nonatomic) NSString *taskProjectType;
@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) Task *task;

- (IBAction)enterNameButton:(id)sender;

@end
