//
//  ProjectListViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Task.h"

@interface ProjectListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) User *currentUser;

@property (strong, nonatomic) IBOutlet UITableView *projectsTableView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *currentHighPointMonster;
@property (weak, nonatomic) IBOutlet UITableView *staticesqueTable;

@end
