//
//  TaskListViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *taskTable;
@property (strong, nonatomic) IBOutlet UILabel *xpLabel;
@property (strong, nonatomic) IBOutlet UILabel *hpLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectDetailLabel;

@property NSMutableArray *selectedTaskTemplate;
@property NSMutableArray *scienceTaskTemplate;
@property NSMutableArray *bookReptTaskTemplate;
@property NSMutableArray *testTaskTemplate;
@property NSString *taskDueDate;
@property NSString *taskType;
@property NSString *taskName;

@end
