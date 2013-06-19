//  TaskListViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "TaskListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "User.h"




@interface TaskListViewController ()
{
    // TaskDetail *step;
    NSString *pointString;
    NSString *stepString;
    
    
}

@property (strong, nonatomic) NSNumber *totalActualXP;
@property (strong, nonatomic) NSNumber *totalPossibleXP;
@property (strong, nonatomic) NSArray *sortedEvolutions;

-(void)chooseTaskList;
-(void)toggleEdit;
-(void) setUpPointsArray;
-(void) showCheeksAnimation;
-(void) createTemplates;
-(void) rotateMonster;
-(void) saveData;
-(void) setNavigationLogic;
-(void) pushProjectListView;

@end

@implementation TaskListViewController

@synthesize stepsResultsController;

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
    
    self.navigationItem.title = self.selectedTask.taskName;
    NSLog(@"the selected project is %@",self.selectedTask.taskName);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    NSString *dueString = [dateFormatter stringFromDate:self.selectedTask.projectedEndDate];
    self.dateLabel.text = dueString;

    //sum up potential XP
    NSSet *possibleXPSet = self.selectedTask.taskDetails;
    self.totalPossibleXP = [possibleXPSet valueForKeyPath:@"@sum.possStepXP"];
    self.selectedTask.possibleXP = self.totalPossibleXP;
    

    NSLog(@"the existing task in task list has %@",self.selectedTask);
    //self.dateLabel.text = self.selectedTask.dateCreated;

    //sum up potential XP
    NSSet *actualXPSet = self.selectedTask.taskDetails;
    self.totalActualXP = [actualXPSet valueForKeyPath:@"@sum.stepXP"];
    self.selectedTask.possibleXP = self.totalActualXP;


    NSString *xpString = [self.selectedTask.actualXP stringValue];
    self.xpLabel.text =xpString;
    
    //Set up edit/done button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"Edit";
    self.editButtonItem.action = @selector(toggleEdit);
    
    // set up points array and task templates
    [self setUpPointsArray];
    // [self createTemplates];
    
    [self setNavigationLogic];

    
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


#pragma add custom left bar nav button
-(void) setNavigationLogic {
    
  if ([self.selectedTask.taskName isEqualToString:self.taskName]) {
        
      ProjectListViewController *projectListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectListViewController"];
        
      self.navigationController.viewControllers = @[projectListVC,self];
      
     // projectListVC.existingTask = self.selectedTask;

  }

}
#pragma mark add points
-(void) setUpPointsArray {
    
    self.pointsArray =[[NSMutableArray alloc] initWithObjects:@"50",@"100",@"500",@"250",@"20", nil];
}


#pragma mark set up keyboard response for textfield entry and add text to the array
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    self.customStepTextField.delegate = self;
    
    if ( textField == self.customStepTextField) {
        
        NSString *customStepsEntered = self.customStepTextField.text;
        if ([customStepsEntered length] > 0) {
            
            NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
            
            // creating new step object
            TaskDetail *newStep = [NSEntityDescription insertNewObjectForEntityForName:@"TaskDetail" inManagedObjectContext:managedObjectContext];
            newStep.stepDetail = customStepsEntered;
            newStep.stepNumber = [NSNumber numberWithInt:[self.stepsArray count]];
            
            // add steps to task 
            newStep.task = self.selectedTask;
            
            //[self.selectedTask addTaskDetailsObject:newStep];
            
            //[self.selectedTask.taskDetails setByAddingObject:newStep];
            
            int  pointsIndexPath = arc4random() % (self.pointsArray.count-1);
            pointString = self.pointsArray[pointsIndexPath];
            NSNumberFormatter *formatter= [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterNoStyle];
            //newStep.stepXP= [formatter numberFromString:pointString];
            newStep.possStepXP = [formatter numberFromString:pointString];
            int totalPossXPInt = [self.totalPossibleXP intValue]+ [newStep.possStepXP intValue];
            self.totalPossibleXP = [NSNumber numberWithInt:totalPossXPInt];

            
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                
                NSLog(@"An error occured: %@", error);
            }
            
           // NSLog(@"the steps array has %@",self.stepsArray);
            
        };
        
        // make textfield blank after pressing enter
        [textField setText:@""];
        [textField resignFirstResponder];
        
        
        return NO;
        
    }
    
    return YES;
}

#pragma mark Setup FetchedResults controller

-(NSFetchedResultsController *) stepsResultController {
    
    if (stepsResultsController != nil) {
        return stepsResultsController;
    }
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TaskDetail" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"stepDetail"
                                                                   ascending:YES];
    
   NSArray *taskDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:taskDescriptors];
    
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"task == %@",self.selectedTask];
   [fetchRequest setPredicate:predicate];
    NSLog(@"the predicate is %@",predicate);
    
    
    stepsResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                               managedObjectContext:managedObjectContext
                                                                 sectionNameKeyPath:nil
                                                                          cacheName:nil];
    
    NSError *error;
    BOOL success = [stepsResultsController performFetch:&error];
    if (!success) {
        NSLog(@"Task Fetch Error: %@", error.description);
    }
    
    if (success) {
        
        [self.taskTable reloadData];
       
    }
     
    stepsResultsController.delegate = self;
    return stepsResultsController;
    
    
}

//-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    
//    [self.taskTable beginUpdates];
//}


-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.taskTable reloadData];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id) anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    
    {
        case NSFetchedResultsChangeInsert:
            [self.taskTable insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.taskTable
                                 cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.taskTable insertRowsAtIndexPaths:[NSArray
                                                    arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (cell == [self.taskTable dequeueReusableCellWithIdentifier:@"taskCell"]) {
        
        TaskDetail *addStep = [self.stepsResultController objectAtIndexPath:indexPath];
        UILabel *stepLabel = (UILabel *) [cell viewWithTag:1];
        stepLabel.text = [addStep valueForKey:@"stepDetail"];
        
    }
    
}




#pragma mark
-(void) createTemplates {
    self.scienceTaskTemplate = [NSMutableArray arrayWithObjects:
                                @"Choose the scientific question",
                                @"Create hypothesis",
                                @"Submit hypothesis to teacher",
                                @"Interview somebody",
                                //                                @"Based on your research, write a statement that predicts the outcome of your experiment (your hypothesis).",
                                //                                @"Design an experiment.",
                                //                                @"Establish a consistent procedure for conducting your experiment.",
                                //                                @"Decide what data you need to meet your research objective and how you will collect it.",
                                //                                @"Identify all variables that could impact your data.",
                                //                                @"Think of how to control any variables that are not being manipulated in your experiment."
                                //                                @"Include a control group in your experiment.",
                                //                                @"Confirm that you have enough quality data that the research is reliable.",
                                //                                @"Maintain notes as you conduct your experiment.",
                                //                                @"Collect data throughout the course of your experiment.",
                                @"Analyze data for patterns.",
                                @"write conclusion",
                                // @"Prepare research summary paper.",
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
    
    //[self chooseTaskList];
    
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
    
    tableView = self.taskTable;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
        TaskDetail *stepToDelete = [stepsResultsController objectAtIndexPath:indexPath];
        [managedObjectContext deleteObject:stepToDelete];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Error! %@",error);
        }
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  chooose corresponding task list
//-(void)chooseTaskList
//{
//    if ([self.taskType isEqual:@"Write a Book Report"]) {
//        self.selectedTaskTemplate = self.bookReptTaskTemplate;
//
//    }else if ([self.taskType isEqual:@"Study for a Test"]){
//        self.selectedTaskTemplate =self.testTaskTemplate;
//    } else {
//        self.selectedTaskTemplate = self.scienceTaskTemplate;
//    }
//}


#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    //return [[stepsResultController sections]count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.stepsResultController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:identifier];
        }
    

    
    TaskDetail *step = [stepsResultsController objectAtIndexPath:indexPath];
    
    NSSet *steps = self.selectedTask.taskDetails;
//    NSMutableArray *stepListArray = [NSMutableArray arrayWithArray:[steps allObjects]];
//    // enumerate through array and get all steps for task
    
//    for (TaskDetail *details in stepListArray) {
//        
//        // use this for an EXISTING project. In a new project there are NO stepdetails so this would be null.
//        stepString = details.stepDetail;
//    }
    
    UILabel *pointsLabel = (UILabel *)[cell viewWithTag:2];
    pointsLabel.text = [step.possStepXP stringValue];
    
    UILabel *stepsLabel = (UILabel *) [cell viewWithTag:1];
    stepsLabel.text = step.stepDetail;
    
    
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
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    TaskDetail *step = [stepsResultsController objectAtIndexPath:indexPath];
    step.stepCompleted = [NSNumber numberWithInt:1];
    
    NSLog (@"actualxp: %@", self.selectedTask.actualXP);
    //set actual xp to potential.
    step.stepXP = step.possStepXP;
    NSLog(@"actual step HP: %@", step.stepXP);
    int totalActualXPInt = [self.totalActualXP intValue]+ [step.stepXP intValue];
    self.totalActualXP = [NSNumber numberWithInt:totalActualXPInt];

    // i put this here because it needs access to step.
    //the number of points per evolution, relates to a completion percentage
    //the actual xp / possible xp, creates a percentage of points completed.
    
    int updatedTaskXP = [self.selectedTask.actualXP intValue]+ [step.stepXP intValue];

    NSLog(@"updated task XP: %d", updatedTaskXP);
    NSLog(@" total poss%@", self.totalPossibleXP);
    
    float percentageOfCompletedSteps = updatedTaskXP/[self.totalPossibleXP floatValue];
    NSLog(@"percent of tasks complete:%f", percentageOfCompletedSteps);
    
    float percentageOfPotentialEvolutions= [self.selectedTask.monster.evolutions count]*.1f;
    NSLog(@"percent of evolutions:%f", percentageOfPotentialEvolutions);
    
    float justToKnow = percentageOfPotentialEvolutions * [self.totalPossibleXP floatValue];
    NSLog(@"this should probably tell me the point threshhold for evolution 1, 2 is this x2, etc.: %f", justToKnow);
   
    //creates array of evolutions, sorted by number, so that [0] should be evolution1, etc.?
    NSSet *evolutionsSet = [self.selectedTask.monster evolutions];
    NSSortDescriptor *sortByEvoNumber = [[NSSortDescriptor alloc] initWithKey:@"evolutionNumber"
                                                                   ascending:YES];
    self.sortedEvolutions = [evolutionsSet sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortByEvoNumber]];

    //can i clear all of the evolution completes?  do it before setting the value of one to yes. 
    
    if (percentageOfCompletedSteps < percentageOfPotentialEvolutions){
        NSLog(@"evolution s/b: 1");
        self.selectedTask.actualXP = [NSNumber numberWithInt: updatedTaskXP];
        [self performSegueWithIdentifier:@"segueToEvolve" sender:self];
        ((Evolution*)self.sortedEvolutions[0]).currentEvolution = [NSNumber numberWithBool:YES];
        ((Evolution*)self.sortedEvolutions[1]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[2]).currentEvolution = [NSNumber numberWithBool:NO];
        
    } else if (percentageOfCompletedSteps < (percentageOfPotentialEvolutions*2)){
        NSLog(@"evolution s/b: 2");
        self.selectedTask.actualXP = [NSNumber numberWithInt: updatedTaskXP];
        [self performSegueWithIdentifier:@"segueToEvolve" sender:self];
        ((Evolution*)self.sortedEvolutions[0]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[1]).currentEvolution = [NSNumber numberWithBool:YES];
        ((Evolution*)self.sortedEvolutions[2]).currentEvolution = [NSNumber numberWithBool:NO];
        
    } else if (percentageOfCompletedSteps <percentageOfPotentialEvolutions*3){
        NSLog(@"evolution s/b: 2");
        self.selectedTask.actualXP = [NSNumber numberWithInt: updatedTaskXP];
        [self performSegueWithIdentifier:@"segueToEvolve" sender:self];
        ((Evolution*)self.sortedEvolutions[0]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[1]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[2]).currentEvolution = [NSNumber numberWithBool:YES];    }
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"An error occured: %@", error);
    }
    
}

#pragma mark rotate monster animation
-(void) rotateMonster {
    
    [UIView animateWithDuration:1 animations:^{
        
        // In order to do this we need to make an animation group so that all elements move in accordance with the monsters full image
        
        
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
    
    SystemSoundID soundID3;
    NSString *soundFile3 = [[NSBundle mainBundle]
                            pathForResource:@"Monster_Wink" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
									 [NSURL fileURLWithPath:soundFile3]
									 , &soundID3);
    AudioServicesPlaySystemSound(soundID3);
    
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
