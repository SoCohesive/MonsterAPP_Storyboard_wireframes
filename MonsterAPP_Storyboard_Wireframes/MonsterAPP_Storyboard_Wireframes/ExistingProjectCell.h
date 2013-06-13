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
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UILabel *deadlineReminderLabel;

@end
