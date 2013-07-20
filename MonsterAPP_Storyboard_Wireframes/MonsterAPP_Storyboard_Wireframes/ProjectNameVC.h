//
//  ProjectNameVC.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Task.h"

@interface ProjectNameVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSString    *projectTypeForName;
@property (strong, nonatomic) NSString    *taskTitleEntered;
@property (strong, nonatomic) NSString    *monsterKind;
@property (strong, nonatomic) Task        *currentTask;
@property (strong, nonatomic) User *projNameUser;

@property NSMutableArray *selectedTaskTemplate;
@property NSMutableArray *scienceTaskTemplate;
@property NSMutableArray *bookReptTaskTemplate;
@property NSMutableArray *testTaskTemplate;

@property (strong, nonatomic)   IBOutlet    UITextField *titleTextField;
@property (strong, nonatomic)   IBOutlet    UITextField *dateEntryField;
@property (strong, nonatomic)   IBOutlet    UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *datePickToolbar;
- (IBAction)pickDateButton:(id)sender;
@property (weak, nonatomic)     IBOutlet    UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

- (IBAction)saveTaskDoneButton:(id)sender;
- (IBAction)datePickerValueChange:(id)sender;


@end
