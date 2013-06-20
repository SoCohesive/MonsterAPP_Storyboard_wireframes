//
//  TaskListViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TaskDetail.h"
#import "Task.h"
#import <CoreData/CoreData.h>
#import "ProjectListViewController.h"

@interface TaskListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate , UINavigationControllerDelegate>

@property  (strong, nonatomic) NSFetchedResultsController *stepsResultsController; 

@property (strong, nonatomic) IBOutlet UITableView *taskTable;
@property (strong, nonatomic) IBOutlet UILabel *xpLabel;
@property (strong, nonatomic) IBOutlet UILabel *hpLabel;
@property (weak, nonatomic) IBOutlet UITextField *customStepTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


//monster images
@property (weak, nonatomic) IBOutlet UIImageView *fullMonsterImage;
@property (weak, nonatomic) IBOutlet UIImageView *monsterRightEyeImage;
@property (weak, nonatomic) IBOutlet UIImageView *monsterLeftEyeImage;
@property (weak, nonatomic) IBOutlet UIImageView *blushedCheeksImage;
@property (weak, nonatomic) IBOutlet UIImageView *mouthOpenImage;


@property NSMutableArray *selectedTaskTemplate;
@property NSMutableArray *scienceTaskTemplate;
@property NSMutableArray *bookReptTaskTemplate;
@property NSMutableArray *testTaskTemplate;
@property NSString *taskDueDate;
@property NSString *taskType;
@property NSString *taskName;

@property (strong,nonatomic) Task *selectedTask;
@property (strong,nonatomic) Task *taskFromProjectList;

@property (strong,nonatomic) NSMutableArray *pointsArray;
@property (strong,nonatomic) NSMutableArray *stepsArray;

@property (strong, nonatomic) User *taskListUser;
@end
