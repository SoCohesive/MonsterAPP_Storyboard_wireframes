//
//  EggHatchesViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EggHatchesViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *monsterNameField;

@property (strong, nonatomic) NSString *taskDueString;
@property (strong, nonatomic) NSString *taskProjectType;
@property (strong, nonatomic) NSString *taskTitle;

- (IBAction)enterNameButton:(id)sender;

@end
