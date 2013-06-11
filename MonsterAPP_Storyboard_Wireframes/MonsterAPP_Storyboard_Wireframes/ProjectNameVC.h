//
//  ProjectNameVC.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectNameVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *nameRequestLabel;
@property (strong, nonatomic) NSString *projectTypeForName;
- (IBAction)nameWithButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@end
