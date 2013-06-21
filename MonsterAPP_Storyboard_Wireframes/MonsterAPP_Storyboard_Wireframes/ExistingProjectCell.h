//
//  ExistingProjectCell.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/13/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExistingProjectCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *monsterProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *existingTitle;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UILabel *deadlineReminderLabel;
@property (strong, nonatomic) IBOutlet UILabel *deadlineIntervalType;
@property (strong, nonatomic) IBOutlet UILabel *deadlineAmtType;

@end
