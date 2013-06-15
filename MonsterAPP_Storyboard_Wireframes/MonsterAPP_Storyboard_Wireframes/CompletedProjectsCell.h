//
//  CompletedProjectsCell.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/13/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedProjectsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *completedMonsterProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *completedTitle;
@property (strong, nonatomic) IBOutlet UILabel *completedSubtitle;
@property (strong, nonatomic) IBOutlet UILabel *completedLabel;

@end
