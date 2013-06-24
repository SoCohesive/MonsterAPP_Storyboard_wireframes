//
//  ProjectListViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ProjectListViewController.h"
#import "AppDelegate.h"
#import "CreateNewProjectCell.h"
#import "ExistingProjectCell.h"
#import "CompletedProjectsCell.h"
#import "ProjectPickerVC.h"
#import "TaskDetail.h"
#import "TaskListViewController.h"

@interface ProjectListViewController ()

{
    NSMutableArray              *projectsBySection;
    NSMutableArray              *existingTasksArray;
   
}

@property (strong, nonatomic) NSFetchedResultsController  *taskResultsController;
@property (strong, nonatomic) NSString *thumbPath;

-(void)setupTasksFetchController;

@end

@implementation ProjectListViewController

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
    
    self.navigationItem.hidesBackButton = YES;
    NSLog(@"ProjectListNavStack %@", [self.navigationController viewControllers]);
    
    //do an array where we have random greetings, random between name/nickname
    NSString *welcome = [NSString stringWithFormat:@"Welcome back, %@", self.currentUser.firstName];
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.welcomeLabel.font.pointSize];
    self.welcomeLabel.font = lunchBoxBold;
    self.welcomeLabel.text = welcome;
    
    NSString *firstCellString = @"Create a New Project.";
    projectsBySection = [[NSMutableArray alloc] initWithObjects: [NSArray arrayWithObject: firstCellString], [NSMutableArray array], [NSMutableArray array], nil];

    [self setupTasksFetchController];
    
    NSString *projectCount = [NSString stringWithFormat:@"%d",[self.taskResultsController.fetchedObjects count]];
    self.projectCountLabel.text = projectCount;

    //sum up Total XP for label
    NSSet *actualXPSet = self.currentUser.tasks;
    NSNumber *totalXP = [actualXPSet valueForKeyPath:@"@sum.actualXP"];
    self.currentUser.totalXP = totalXP;
    NSString *xpString = [self.currentUser.totalXP stringValue];
    self.pointCountLabel.text =xpString;
    
    
    NSLog(@"the existing tasks in project list have these steps %@",self.existingTask.taskDetails);

    [self.projectsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma CoreData


-(void)setupTasksFetchController
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    NSFetchRequest *taskFetchRequest = [[NSFetchRequest alloc] init];
    
//    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user = %@", self.currentUser];  user.tasks?
    NSPredicate * completionPredicate = [NSPredicate predicateWithFormat:@"taskComplete = %@", nil];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext];
    [taskFetchRequest setEntity:entity];
  //  [taskFetchRequest setPredicate:userPredicate];
    [taskFetchRequest setPredicate: completionPredicate];
    
//once Tasks save taskDetails, switch name to taskDetails
    
    taskFetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"taskComplete" ascending:NO],[NSSortDescriptor sortDescriptorWithKey:@"projectedEndDate" ascending:NO]];
    
    self.taskResultsController = [[NSFetchedResultsController alloc]
                                    initWithFetchRequest:taskFetchRequest
                                    managedObjectContext:managedObjectContext
                                    sectionNameKeyPath:@"taskComplete" 
                                    cacheName:@"nil"];
   
    NSError *error;
    BOOL success = [self.taskResultsController performFetch:&error];
    if (!success) {
        NSLog(@"Task Fetch Error: %@", error.description);
    }

    
}



#pragma
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.staticesqueTable) {
        
        return 1;
        
    } else {
   
        return [[self.taskResultsController sections] count];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.staticesqueTable) {
        
        return 1;
        
    } else {

    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.taskResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    }
}

/* If we want to include completed projects, use this to section them, 
 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.staticesqueTable) {
        return nil;
                
    } else {
        
        
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.taskResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
        
    }
    
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *cellID1 = @"newProjectCell";
static NSString *cellID2 = @"existingProjectCell";
static NSString *cellID3 = @"completedProjectCell";

CreateNewProjectCell *newProjectCell =[[CreateNewProjectCell alloc] init];
ExistingProjectCell *existingProjectCell =[[ExistingProjectCell alloc] init];
CompletedProjectsCell *completedProjectCell =[[CompletedProjectsCell alloc] init];

    if (tableView == self.staticesqueTable) {
        
    
        newProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        newProjectCell.createLabel.text = [projectsBySection[0] objectAtIndex:indexPath.row];
        
        return newProjectCell;
        
    } else {
    
    if ([[self.taskResultsController sections] objectAtIndex:0]) {
        //confirm that this will always be completedTasks, should I use array?    
        existingProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID2 forIndexPath:indexPath];
        
        self.existingTask = [self.taskResultsController objectAtIndexPath:indexPath];
        existingProjectCell.existingTitle.text = self.existingTask.taskName;
        existingProjectCell.subtitle.text = self.existingTask.taskType;
    
        //pulls monster's thumbnail that aligns with the appropriate evolution.
        NSSet *evolutions = [self.existingTask.monster evolutions];
        NSSortDescriptor *sortByEvoComplete = [[NSSortDescriptor alloc] initWithKey:@"currentEvolution"
            ascending:NO];
        
        NSArray *sortedEvolutions = [evolutions sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortByEvoComplete]];
        
        self.thumbPath = ((Evolution*)sortedEvolutions[0]).thumbnailName;
        NSLog(@"evolution marked as current %@", ((Evolution*)sortedEvolutions[0]).evolutionDescription);
        NSLog(@"thumbPath: %@", self.thumbPath);
        
        UIImage *cellThumb = [UIImage imageNamed:self.thumbPath];
        existingProjectCell.monsterProfilePic.image = cellThumb;
        
        //formats the due date in days or hours left
        NSDate *dueDate = self.existingTask.projectedEndDate;
        NSDate *currentDate = [NSDate date];
        NSTimeInterval differenceInDays;
        NSTimeInterval differenceInHours;
        NSTimeInterval differenceInWeeks;
        
        differenceInWeeks = [currentDate timeIntervalSinceDate:dueDate] / 604800;;
        differenceInDays = [currentDate timeIntervalSinceDate:dueDate] / 86400;
        differenceInHours = [currentDate timeIntervalSinceDate:dueDate] / 3600;
        
        NSString *weekDiffString = [NSString stringWithFormat:@"%d", abs(differenceInWeeks)];
        NSString *dayDiffString = [NSString stringWithFormat:@"%d", abs(differenceInDays)];
        NSString *hourDiffString = [NSString stringWithFormat:@"%d", abs(differenceInHours)];
        
        if (ABS(differenceInWeeks) > 1){
            existingProjectCell.deadlineAmtType.text = weekDiffString;
            existingProjectCell.deadlineIntervalType.text = @"weeks";
        }
        else if (ABS(differenceInDays) > 1) {
            existingProjectCell.deadlineAmtType.text = dayDiffString;
            existingProjectCell.deadlineIntervalType.text = @"days";
        }else{
            existingProjectCell.deadlineAmtType.text = hourDiffString;
            existingProjectCell.deadlineIntervalType.text = @"hours";
        }
        
                
        return existingProjectCell;
        
    } else {
        completedProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID3 forIndexPath:indexPath];
        
        Task *completedTask = [self.taskResultsController objectAtIndexPath:indexPath];
        completedProjectCell.completedTitle.text = completedTask.taskName;
        completedProjectCell.completedSubtitle.text = completedTask.taskType;
        
        NSString *dateString =  [[NSString alloc] initWithFormat:@"%@", [completedTask.projectedEndDate descriptionWithLocale:[NSLocale currentLocale]]];
        completedProjectCell.completedLabel.text = dateString;
        
        return completedProjectCell;

    }
   
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)
indexPath
{
    if (tableView == self.staticesqueTable) {
        
        [self.staticesqueTable deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:@"segueToCreateProject" sender:self];
        
    } else {
        
        
        [self.projectsTableView deselectRowAtIndexPath:indexPath animated:YES];
       
        self.tappedTask= [self.taskResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"segueToExistingTaskDetail" sender:self];
        
    }

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
if ([segue.identifier isEqualToString:@"segueToExistingTaskDetail"]) {
    

    ((TaskListViewController *)segue.destinationViewController).selectedTask = self.tappedTask;
    ((TaskListViewController *)segue.destinationViewController).taskListUser = self.currentUser;
    }
    
if ([segue.identifier isEqualToString:@"segueToCreateProject"]) {
    ((ProjectPickerVC*)(segue.destinationViewController)).projPickerCurrentUser = self.currentUser;
    NSLog(@"making new project");
    }
    
}



@end
