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
#import "Monster.h"
#import "Evolution.h"

@interface ProjectListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) Task *existingTask;
@property (weak, nonatomic) Task *tappedTask;

@property (strong, nonatomic) IBOutlet UITableView *projectsTableView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *currentHighPointMonster;
@property (weak, nonatomic) IBOutlet UITableView *staticesqueTable;


@end
