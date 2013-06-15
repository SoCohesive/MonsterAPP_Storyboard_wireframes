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
#import "TaskListViewController.h"

@interface ProjectListViewController ()

{
    NSMutableArray              *projectsBySection;
    NSArray                     *newProjectsArray;
    NSMutableArray              *existingProjectsArray;
    NSMutableArray              *completedProjectsArray;
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
    self.welcomeLabel.text = welcome;
    
    NSString *firstCellString = @"Create a New Project.";
    projectsBySection = [[NSMutableArray alloc] initWithObjects: [NSArray arrayWithObject: firstCellString], [NSMutableArray array], [NSMutableArray array], nil];

    [self setupTasksFetchController];
    //link this to core data for projects
//    NSMutableArray *dummyOpenProjArray = [NSMutableArray arrayWithObjects:@"Winn Dixie Report", @"Math Test", nil];
//    [projectsBySection[1] addObjectsFromArray:dummyOpenProjArray];
//    
//    NSLog(@"%@", [self.currentUser.tasks valueForKey:@"taskName"]);
//    
//    //use this to enumerate for the tasks.  though the fetch request controller may be more appropriate for table views
//    //for (id task in [appObject valueForKey:@"task"]) {
//      //  NSLog(@"name = %@", [person valueForKey:@"name"]);}
//    
//
//    //link this to core data for completed projects (maybe search for tasks whose task details are 0)
//    NSMutableArray *dummyClosedProjArray = [NSMutableArray arrayWithObjects:@"SuperFudge Report", @"Geography Test", nil];
//    [[projectsBySection objectAtIndex:2] addObjectsFromArray:dummyClosedProjArray];
    
    
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
    
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user = %@", self.currentUser];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext];
    [taskFetchRequest setEntity:entity];
    [taskFetchRequest setPredicate:userPredicate];
    
    //once you figure out predicates, filter by user rather than sorting?
    taskFetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"Task.taskDetails" ascending:NO], [NSSortDescriptor sortDescriptorWithKey:@"Task.projectedEndDate" ascending:YES]];
    
    self.taskResultsController = [[NSFetchedResultsController alloc]
                                    initWithFetchRequest:taskFetchRequest
                                    managedObjectContext:managedObjectContext
                                    sectionNameKeyPath:@"task.taskComplete"
                                    cacheName:@"nil"];
    NSError *error;
    BOOL success = [self.taskResultsController performFetch:&error];
    if (!success) {
        NSLog(@"Task Fetch Error: %@", error.description);
    }
    
    [projectsBySection[1] addObjectsFromArray: [self.taskResultsController objectAtIndexPath:0]];
    [projectsBySection[1] addObjectsFromArray: [self.taskResultsController objectAtIndexPath:0]];
    [self.projectsTableView reloadData];

}



#pragma
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [projectsBySection count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [projectsBySection[section] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID1 = @"newProjectCell";
    static NSString *cellID2 = @"existingProjectCell";
    static NSString *cellID3 = @"completedProjectCell";

    CreateNewProjectCell *newProjectCell =[[CreateNewProjectCell alloc] init];
    ExistingProjectCell *existingProjectCell =[[ExistingProjectCell alloc] init];
    CompletedProjectsCell *completedProjectCell =[[CompletedProjectsCell alloc] init];
    
    
        //NSLog(@"projectsBySection[1].row = %@", projectsBySection[1][0]);
    
    if (indexPath.section == 0) {
        
        newProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        newProjectCell.createLabel.text = [projectsBySection[0] objectAtIndex:indexPath.row];
        
        return newProjectCell;
        
    } else if (indexPath.section == 1) {
        
        existingProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        existingProjectCell.subtitle.text = [projectsBySection[1] objectAtIndex:indexPath.row];
        
        return existingProjectCell;
        
    } else {
        completedProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        completedProjectCell.textLabel.text = [projectsBySection[2] objectAtIndex:indexPath.row];
        
        return completedProjectCell;
    }
    
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   if (indexPath.section == 0) {
   
       [self performSegueWithIdentifier:@"segueToNewProject" sender:self];

   } else {
   
       [self performSegueWithIdentifier:@"segueToExistingTaskDetail" sender:self];
   }
    
    [self.projectsTableView deselectRowAtIndexPath:indexPath animated:YES];
 
}
*/


@end
