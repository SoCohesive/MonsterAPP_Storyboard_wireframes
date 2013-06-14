//
//  ProjectListViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProjectListViewController : UIViewController

@property (strong, nonatomic) User *currentUser;

@property (strong, nonatomic) IBOutlet UITableView *projectsTableView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;

@end
