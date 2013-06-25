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
#import "EvolutionViewController.h"




@interface TaskListViewController ()
{
//  TaskDetail                  *step;
//  NSString                    *stepString;
    NSString                    *pointString;
    ProjectListViewController   *projectListVC;

}

@property (strong, nonatomic) NSNumber  *totalActualXP;
@property (strong, nonatomic) NSNumber  *totalPossibleXP;
@property (strong, nonatomic) NSArray   *sortedEvolutions;

-(void)toggleEdit;
-(void) setUpPointsArray;
-(void) setNavigationLogic;

//-(void) showCheeksAnimation;
//-(void) rotateMonster;
//-(void) saveData;
//-(void) pushProjectListView;

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
    
    //NSLog(@"the existing task in task list has %@",self.selectedTask);
    //NSLog(@"user is: %@", self.taskListUser);
    
    self.navigationItem.title = self.selectedTask.taskName;
    NSLog(@"the selected project is %@",self.selectedTask.taskName);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    NSString *dueString = [dateFormatter stringFromDate:self.selectedTask.projectedEndDate];
    self.dateLabel.text = dueString;
    
    //sum up potential XP for setting evolution thresholds
    NSSet *possibleXPSet = self.selectedTask.taskDetails;
    int possibleXPFromTasks = [[possibleXPSet valueForKeyPath:@"@sum.possStepXP"] intValue];
    int possibleXPWithStartPoints = possibleXPFromTasks + 50;
    self.totalPossibleXP = [NSNumber numberWithInt:possibleXPWithStartPoints];
    self.selectedTask.possibleXP = self.totalPossibleXP;
    
    //actual XP for label
    NSString *xpString = [self.selectedTask.actualXP stringValue];
    self.xpLabel.text =xpString;
    
    //Set up edit/done button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"Edit";
    self.editButtonItem.action = @selector(toggleEdit);
    
    // set up points array 
    [self setUpPointsArray];
    [self stepsResultController];
    
    [self setNavigationLogic];


    
    // set up Timer for eye and cheek animation if monster is at this stage
        
        [self monsterImageLogic];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.parentViewController == nil) {
        NSLog(@"viewDidDisappear doesn't have parent so it's been popped");
        [self dismissViewControllerAnimated:YES completion: nil];
        
        //release stuff here
    } else {
        NSLog(@"TaskViewController view just hidden");
    }
}

-(void) monsterImageLogic {
    
    NSNumber *evolutionNumber;
    NSSet *evolutionSetForMonster = [self.selectedTask.monster evolutions];
    NSSortDescriptor *sortByEvoNumber = [[NSSortDescriptor alloc] initWithKey:@"currentEvolution"
                                                                    ascending:NO];
    
    self.sortedEvolutions = [evolutionSetForMonster sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortByEvoNumber]];
    evolutionNumber = ((Evolution *)self.sortedEvolutions[0]).evolutionNumber;
    
    if ([evolutionNumber intValue] == 0) {
        
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(blinkCloseAnimationForMonster)                                    userInfo:self
                                        repeats:YES];
        
        //set up timer for cheeks
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(animateCheeks)
                                       userInfo:self
                                        repeats:NO];
        
    }
    else if ([evolutionNumber intValue] == 1){
        
        self.monsterLeftEyeImage.hidden = YES;
        self.monsterRightEyeImage.hidden = YES;
        self.fullMonsterImage.hidden = YES;
        self.mouthOpenImage.hidden = YES;
        
        [self.monsterEvolutionImage animationOne];
        
    } else if ([evolutionNumber intValue] == 2) {
        
        self.monsterLeftEyeImage.hidden = YES;
        self.monsterRightEyeImage.hidden = YES;
        self.fullMonsterImage.hidden = YES;
        self.mouthOpenImage.hidden = YES;
        
        [self.monsterEvolutionImage tailFlickAnimate];
        
    } else if ([evolutionNumber intValue] == 3) {
        
        self.monsterLeftEyeImage.hidden = YES;
        self.monsterRightEyeImage.hidden = YES;
        self.fullMonsterImage.hidden = YES;
        self.mouthOpenImage.hidden = YES;
        
        [self.monsterEvolutionImage growLimbsEvo3];
        
    
    }
}

#pragma 
#pragma mark create new project list view controller if coming from the new project stack.
-(void) setNavigationLogic {

    if (projectListVC == nil) {
        projectListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectListViewController"];

        self.navigationController.viewControllers = @[projectListVC,self];
        projectListVC.currentUser = self.taskListUser;
        NSLog(@"new project list created");

    } else {

        self.navigationController.viewControllers = @[projectListVC,self];
        [self.navigationController popToViewController:projectListVC animated:NO];
        projectListVC.currentUser = self.taskListUser;
        NSLog(@"project list existed");
    }

}

#pragma mark add points
-(void) setUpPointsArray {
    
    self.pointsArray =[[NSMutableArray alloc] initWithObjects:@"50",@"100",@"150",@"75",@"25", nil];
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
            newStep.stepCreatedDate = [NSDate date];
            
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
           // int totalPossXPInt = [self.totalPossibleXP intValue]+ [newStep.possStepXP intValue];
            //self.totalPossibleXP = [NSNumber numberWithInt:totalPossXPInt];

            
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


-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.taskTable beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id) anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    
    {//app breaks on the first one, from a totally different viewcontroller
            //setting the date of the book report, test, etc.
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

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.taskTable endUpdates];
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

    UILabel *pointsLabel = (UILabel *)[cell viewWithTag:2];
    pointsLabel.text = [step.possStepXP stringValue];
    
    UILabel *stepsLabel = (UILabel *) [cell viewWithTag:1];
    stepsLabel.text = step.stepDetail;
    
    // set up Check mark image 
    NSNumber *baseNumber = [NSNumber numberWithInt:1];
    if ([step.stepCompleted isEqualToNumber:baseNumber]) {
        
        UIImageView *checkMarkImage = (UIImageView *)[cell viewWithTag:4];
        checkMarkImage.hidden = NO;
        pointsLabel.alpha = .3;
        stepsLabel.alpha = .3;
        UILabel *pointStringLabel = (UILabel *) [cell viewWithTag:5];
        pointStringLabel.alpha = .3; 
    }
    
    return cell;
    
}

#pragma mark select row action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   //[self performSegueWithIdentifier:@"segueToEvolve" sender:self];
    UITableViewCell *cell = [self.taskTable cellForRowAtIndexPath:indexPath];
    
    // Unhide image of check mark
    UIImageView *checkMarkImage = (UIImageView *)[cell viewWithTag:4];
    checkMarkImage.hidden = NO;
    cell.alpha = .3;
    
        
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    TaskDetail *step = [stepsResultsController objectAtIndexPath:indexPath];
    step.stepCompleted = [NSNumber numberWithBool:YES];
    
    
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
    self.xpLabel.text =[[NSNumber numberWithInt:updatedTaskXP] stringValue];
    
    
    float percentageOfCompletedSteps = updatedTaskXP/[self.totalPossibleXP floatValue];
    NSLog(@"percent of tasks complete:%f", percentageOfCompletedSteps);
    
    if (percentageOfCompletedSteps ==1){
        self.selectedTask.taskComplete = [NSNumber numberWithBool:YES];
    }
    
    float percentageOfPotentialEvolutions= [self.selectedTask.monster.evolutions count]*.1f;
    NSLog(@"percent of evolutions:%f", percentageOfPotentialEvolutions);
    
    float justToKnow = percentageOfPotentialEvolutions * [self.totalPossibleXP floatValue];
    NSLog(@"points per evolution: %f", justToKnow);
   
    
    NSSet *evolutionsSet = [self.selectedTask.monster evolutions];
    NSSortDescriptor *sortByEvoNumber = [[NSSortDescriptor alloc] initWithKey:@"evolutionNumber"
                                                                   ascending:YES];
    self.sortedEvolutions = [evolutionsSet sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortByEvoNumber]];

    
    if (percentageOfCompletedSteps < percentageOfPotentialEvolutions){
        NSLog(@"evolution s/b: 1");
        self.selectedTask.actualXP = [NSNumber numberWithInt: updatedTaskXP];
        //[self performSegueWithIdentifier:@"segueToEvolve" sender:self];
        ((Evolution*)self.sortedEvolutions[0]).currentEvolution = [NSNumber numberWithBool:YES];
        ((Evolution*)self.sortedEvolutions[1]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[2]).currentEvolution = [NSNumber numberWithBool:NO];
        
    } else if (percentageOfCompletedSteps < (percentageOfPotentialEvolutions*2)){
        NSLog(@"evolution s/b: 2");
        self.selectedTask.actualXP = [NSNumber numberWithInt: updatedTaskXP];
        //[self performSegueWithIdentifier:@"segueToEvolve" sender:self];
        ((Evolution*)self.sortedEvolutions[0]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[1]).currentEvolution = [NSNumber numberWithBool:YES];
        ((Evolution*)self.sortedEvolutions[2]).currentEvolution = [NSNumber numberWithBool:NO];
        
    } else if (percentageOfCompletedSteps <percentageOfPotentialEvolutions*3){
        NSLog(@"evolution s/b: 3");
        self.selectedTask.actualXP = [NSNumber numberWithInt: updatedTaskXP];
        //[self performSegueWithIdentifier:@"segueToEvolve" sender:self];
        ((Evolution*)self.sortedEvolutions[0]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[1]).currentEvolution = [NSNumber numberWithBool:NO];
        ((Evolution*)self.sortedEvolutions[2]).currentEvolution = [NSNumber numberWithBool:YES];    }
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"An error occured: %@", error);
    }
     
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"evolutions at save; %@", self.sortedEvolutions);

    [self performSegueWithIdentifier:@"segueToEvolve" sender:self];
    [self monsterImageLogic];
}



#pragma mark cheek animation
-(void) animateCheeks {
    [self.blushedCheeksImage showCheeksAnimation];
}


#pragma mark create monster eye animation
-(void) blinkCloseAnimationForMonster {
    
    [self.monsterLeftEyeImage animateEyesForBlinking];
    [self.monsterRightEyeImage animateEyesForBlinking];
     
}
  #pragma prepareForEvolutionSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"segueToEvolve"]){
        
    NSSet *evolutionsSet = [self.selectedTask.monster evolutions];
    NSSortDescriptor *sortByEvoComplete = [[NSSortDescriptor alloc] initWithKey:@"currentEvolution"
                                                                    ascending:NO];
    self.sortedEvolutions = [evolutionsSet sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortByEvoComplete]];
    
    NSLog(@"TaskListVC SortedEvol.%@", self.sortedEvolutions);
   ((EvolutionViewController*)(segue.destinationViewController)).evolutionForImages = [self.sortedEvolutions objectAtIndex:0];
    }
    
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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"stepCreatedDate"
                                                                   ascending:NO];
    
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
        
        //  [self.taskTable reloadData];
        
    }
    
    stepsResultsController.delegate = self;
    return stepsResultsController;
    
    
}




@end
