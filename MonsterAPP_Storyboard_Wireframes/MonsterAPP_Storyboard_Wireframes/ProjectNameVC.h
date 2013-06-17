//
//  ProjectNameVC.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProjectNameVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSString    *projectTypeForName;
@property (strong, nonatomic) NSString    *taskTitleEntered;
@property (strong, nonatomic) NSString *monsterKind;

@property (strong, nonatomic) IBOutlet  UITextField *titleTextField;

@property (strong, nonatomic) IBOutlet  UITextField *dateEntryField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)saveTaskDoneButton:(id)sender;

@end
