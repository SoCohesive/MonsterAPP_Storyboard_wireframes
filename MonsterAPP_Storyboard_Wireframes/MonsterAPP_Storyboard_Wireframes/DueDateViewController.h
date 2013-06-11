//
//  DueDateViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DueDateViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel  *dateDueQuestion;
@property (strong, nonatomic) NSString          *taskNameForDate;
@property (strong, nonatomic) NSString *taskTitleEntered;


@property (strong, nonatomic) IBOutlet UIDatePicker     *dueDatePicker;


- (IBAction)doneDateButton:(id)sender;
@end
