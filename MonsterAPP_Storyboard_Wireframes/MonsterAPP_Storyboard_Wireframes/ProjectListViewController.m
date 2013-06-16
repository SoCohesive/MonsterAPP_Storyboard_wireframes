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
   
}

@property (strong, nonatomic) NSFetchedResultsController  *taskResultsController;


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
    //do an array where we have random greetings, random between name/nickname
    NSString *welcome = [NSString stringWithFormat:@"Welcome back, %@", self.currentUser.firstName];
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.welcomeLabel.font.pointSize];
    self.welcomeLabel.font = lunchBoxBold;
    self.welcomeLabel.text = welcome;
    
    NSString *firstCellString = @"Create a New Project.";
    projectsBySection = [[NSMutableArray alloc] initWithObjects: [NSArray arrayWithObject: firstCellString], [NSMutableArray array], [NSMutableArray array], nil];

    [self setupTasksFetchController];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma
#pragma CoreData


-(void)setupTasksFetchController
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    NSFetchRequest *taskFetchRequest = [[NSFetchRequest alloc] init];
    
//    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user = %@", self.currentUser];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext];
    [taskFetchRequest setEntity:entity];
  //  [taskFetchRequest setPredicate:userPredicate];
    
//once Tasks save taskDetails, switch name to taskDetails
    taskFetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"taskName" ascending:NO]];
    
    self.taskResultsController = [[NSFetchedResultsController alloc]
                                    initWithFetchRequest:taskFetchRequest
                                    managedObjectContext:managedObjectContext
                                    sectionNameKeyPath:@"taskComplete" //taskComplete
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
        
        existingProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID2 forIndexPath:indexPath];
        
        Task *existingTask = [self.taskResultsController objectAtIndexPath:indexPath];
        existingProjectCell.existingTitle.text = existingTask.taskName;
        existingProjectCell.subtitle.text = existingTask.taskType;
        
        NSString *dateString =  [[NSString alloc] initWithFormat:@"%@", [existingTask.projectedEndDate descriptionWithLocale:[NSLocale currentLocale]]];
        existingProjectCell.deadlineReminderLabel.text = dateString;
                
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
        //once the segues pass info, set this up to do the @"segueToCreateProject" segue

    }else {
     
        [self.projectsTableView deselectRowAtIndexPath:indexPath animated:YES];
        //once the segues pass info, set this up to do the @"segueToCreateProject" segue & fetch taskDetails
    }
}
@end
