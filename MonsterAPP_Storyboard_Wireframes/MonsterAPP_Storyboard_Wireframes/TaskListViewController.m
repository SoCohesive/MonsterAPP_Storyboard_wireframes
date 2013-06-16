//
//  TaskListViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "TaskListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "Task.h"

@interface TaskListViewController ()

-(void)chooseTaskList;
-(void)toggleEdit;
-(void) setUpPointsArray;
-(void) showCheeksAnimation;
-(void) createTemplates;
-(void) rotateMonster;

@end

@implementation TaskListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSString *projectCaption = [NSString stringWithFormat:@"%@, due:%@", self.taskName, self.taskDueDate];
//    self.projectDetailLabel.text = projectCaption;
    
    // Add Project Title and due date. ** format due date ASAP!
    self.navigationItem.title = self.taskName;
    self.dateLabel.text = self.taskDueDate;
    
    
    
    //Set up edit/done button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.action = @selector(toggleEdit);
    
    // set up points array and task templates
    [self setUpPointsArray];
    [self createTemplates];
   
    
    // set up timer for eye blinking animation
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(blinkCloseAnimationForMonster)                                    userInfo:self
                                    repeats:YES];
    
    //set up timer for cheeks
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(showCheeksAnimation)
                                   userInfo:self
                                    repeats:NO];
    
    //set up timer for rotating turtle guy
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(rotateMonster)
                                   userInfo:self
                                    repeats:NO];
    

}

#pragma mark 
-(void) createTemplates {
    self.scienceTaskTemplate = [NSMutableArray arrayWithObjects:
                                @"Choose the scientific question you want to answer or what problem you want to solve.",
                                @"Compose your experiment idea in the form of a testable question.",
                                @"Submit your question to your teacher (or sponsor)",
                                @"If your project requires an endorsement - enter any additional steps as described by your teacher to this list.",
                                @"Perform background research on your topic: review books, scientific literature, and interviews with scientists, as well as any online research you may perform.",
                                @"Based on your research, write a statement that predicts the outcome of your experiment (your hypothesis).",
                                @"Design an experiment.",
                                @"Establish a consistent procedure for conducting your experiment.",
                                @"Decide what data you need to meet your research objective and how you will collect it.",
                                @"Identify all variables that could impact your data.",
                                @"Think of how to control any variables that are not being manipulated in your experiment."
                                @"Include a control group in your experiment.",
                                @"Confirm that you have enough quality data that the research is reliable.",
                                @"Maintain notes as you conduct your experiment.",
                                @"Collect data throughout the course of your experiment.",
                                @"Analyze data for patterns.",
                                @"write conclusion based on collected data.",
                                @"Prepare research summary paper.",
                                @"Prepare display board for classroom.",
                                nil];

    
    self.bookReptTaskTemplate = [NSMutableArray arrayWithObjects:
                                 @"Get book from Library",
                                 @"Study protagonist",
                                 @"Read first three chapters",
                                 @"Take notes on characters",
                                 nil];
    
    self.testTaskTemplate = [NSMutableArray arrayWithObjects:
                                 @"Review homework",
                                 @"Make FlashCards",
                                 @"Explain topics to friends",
                                 @"Get an A!",
                                 nil];
    
    [self chooseTaskList];
    
    }


#pragma mark rotate monster animation 
-(void) rotateMonster {
    
    [UIView animateWithDuration:1 animations:^{
        
        // In order to do this we need to make an animation group so that all elements move in accordance with the monsters full image
//        
//        self.fullMonsterImage.transform = CGAffineTransformMakeRotation(20 * M_PI / 180);
//        self.monsterRightEyeImage.transform = CGAffineTransformMakeRotation(20 * M_PI / 180);
//        self.monsterLeftEyeImage.transform = CGAffineTransformMakeRotation(20 * M_PI / 180);
//        self.blushedCheeksImage.transform = CGAffineTransformMakeRotation(20 * M_PI / 180);
      
        
    }];
    
}

#pragma mark cheek animation
-(void) showCheeksAnimation {
    
    self.blushedCheeksImage.alpha =0.0f;
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
    
        self.blushedCheeksImage.alpha = 1.0;
        self.blushedCheeksImage.hidden= NO;
        
    } completion:^(BOOL finished) {
        //
    }];
    
}

#pragma mark add points
-(void) setUpPointsArray {
    
    // i thought it would be best to stick to common numbers instead of very very random ones. This outputs on a random basis
    
    self.pointsArray =[[NSMutableArray alloc] initWithObjects:@"50",@"100",@"500",@"250",@"20", nil];
}

#pragma mark edit button & actions
-(void)toggleEdit
{
    
    [self.taskTable setEditing:!self.taskTable.editing animated:YES];
    
    if (self.taskTable.editing == YES)
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
}

#pragma mark commit editing style
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"editing tableview");
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.selectedTaskTemplate removeObjectAtIndex:indexPath.row];
        
        [NSArray arrayWithObject:indexPath];
        [self.taskTable  deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  chooose corresponding task list
-(void)chooseTaskList
{
    if ([self.taskType isEqual:@"Write a Book Report"]) {
        self.selectedTaskTemplate = self.bookReptTaskTemplate;
        
    }else if ([self.taskType isEqual:@"Study for a Test"]){
        self.selectedTaskTemplate =self.testTaskTemplate;
    } else {
        self.selectedTaskTemplate = self.scienceTaskTemplate;
    }
}

#pragma mark set up keyboard response for textfield entry and add text to the array
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.customStepTextField.delegate = self;
    
    if ( textField == self.customStepTextField) {
        
        NSString *customStepsEntered = self.customStepTextField.text;
        NSLog(@"the custom step is %@",customStepsEntered);
        
        if ([customStepsEntered length] > 0) {
            
            [self.selectedTaskTemplate addObject:customStepsEntered];
            [self.taskTable reloadData];
            
        };
        
        // make textfield blank after pressing enter
        [textField setText:@""];
        
        [textField resignFirstResponder];
        
        
        return NO;
        
    }
    
    return YES;
}



#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.selectedTaskTemplate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:identifier];
    }
    
     // add points from points array
    UILabel *pointsLabel = (UILabel *)[cell viewWithTag:2];
    int  pointsIndexPath = arc4random() % (self.pointsArray.count-1);
    pointsLabel.text = self.pointsArray[pointsIndexPath];
    
    UILabel *stepsLabel = (UILabel *) [cell viewWithTag:1];
    stepsLabel.text = [self.selectedTaskTemplate objectAtIndex:indexPath.row];
    
    
    //UIImage *background = [UIImage imageNamed:@"{custom table cell?}.png"];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:background];
    //cell.textLabel.backgroundColor = [UIColor clearColor];    
    
    return cell;
}

#pragma mark select row action 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.taskTable cellForRowAtIndexPath:indexPath];
    
    // Unhide image of check mark
    UIImageView *checkMarkImage = (UIImageView *)[cell viewWithTag:4];
    checkMarkImage.hidden = NO;
    
    // lessen alpha of cell itself
    cell.alpha = .3;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark create monster eye animation
-(void) blinkCloseAnimationForMonster {
    
    //self.monsterLeftEyeImage.hidden = NO;
    
    [UIView animateWithDuration:.4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
        self.monsterRightEyeImage.hidden= NO;
        self.monsterLeftEyeImage.hidden = NO;
                         
        self.monsterLeftEyeImage.alpha = 1.0f;
        self.monsterRightEyeImage.alpha = 1.0f;
        
        
        
    } completion:^(BOOL finished) {
        
        [self blinkOpeneAnimationForMonster];
        
    }];
    
}

#pragma mark open eye animation
-(void) blinkOpeneAnimationForMonster {
    [UIView animateWithDuration:.4 delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
        self.monsterLeftEyeImage.alpha = 0.0f;
        self.monsterRightEyeImage.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
   
        
    }];
    
}



@end
