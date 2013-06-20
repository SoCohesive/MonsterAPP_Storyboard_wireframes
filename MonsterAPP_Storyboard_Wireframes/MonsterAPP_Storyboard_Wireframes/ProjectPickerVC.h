//
//  ProjectPickerVC.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProjectPickerVC : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) User *projPickerCurrentUser;
@property NSMutableArray *projectTypes;
@property (strong, nonatomic) IBOutlet UITableView *projectTypesTable;
@property (strong, nonatomic) NSString *projectTemplateName;
@property (weak, nonatomic) IBOutlet UILabel *whatProjectLabel;

@end
