//
//  ProjectPickerVC.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectPickerVC : UIViewController

@property NSMutableArray *projectTypes;
@property (strong, nonatomic) IBOutlet UITableView *projectTypesTable;

@end
