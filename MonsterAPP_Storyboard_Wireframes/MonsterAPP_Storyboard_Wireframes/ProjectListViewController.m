//
//  ProjectListViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ProjectListViewController.h"
#import "CreateNewProjectCell.h"

@interface ProjectListViewController ()

{
    NSMutableArray  *projectsBySection;
    NSArray         *newProjectsArray;
    NSMutableArray  *existingProjectsArray;
    NSMutableArray  *completedProjectsArray;
}

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
    NSString *welcome = [NSString stringWithFormat:@"Welcome back, %@", self.currentUser];
    self.welcomeLabel.text = welcome;
    NSString *firstCellString = @"Create a New Project.";
    projectsBySection = [[NSMutableArray alloc] initWithObjects: [NSArray arrayWithObject: firstCellString], [NSMutableArray array], [NSMutableArray array], nil];
    
    NSMutableArray *dummyOpenProjArray = [NSMutableArray arrayWithObjects:@"Winn Dixie Report", @"Math Test", nil];
    [projectsBySection[1] addObjectsFromArray:dummyOpenProjArray];
    
    //link this to core data for projects
    
    //link this to core data for completed projects (maybe search for tasks whose task details are 0)
    NSMutableArray *dummyClosedProjArray = [NSMutableArray arrayWithObjects:@"SuperFudge Report", @"Geography Test", nil];
    [[projectsBySection objectAtIndex:2] addObjectsFromArray:dummyClosedProjArray];
    
    
    
    // [self.projectsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *cellID3 = @"completedTaskCell";
    NSLog(@"projectsBySection[1].row = %@", projectsBySection[1][0]);
    
    if (indexPath.section == 0) {
        
        CreateNewProjectCell *newProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        
        newProjectCell.textLabel.text = [projectsBySection[0] objectAtIndex:indexPath.row];
        
        return newProjectCell;
        
    } else if (indexPath.section == 1) {
        
        UITableViewCell *existingProjectCell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        existingProjectCell.textLabel.text = [projectsBySection[1] objectAtIndex:indexPath.row];
        
        return existingProjectCell;
    } else {
        UITableViewCell *completedTaskCell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        completedTaskCell.textLabel.text = [projectsBySection[2] objectAtIndex:indexPath.row];
        
        return completedTaskCell;
    }
    
}

@end
