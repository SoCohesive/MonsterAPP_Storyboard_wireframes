//
//  TaskListViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "TaskListViewController.h"

@interface TaskListViewController ()

-(void)chooseTaskList;

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
    NSString *projectCaption = [NSString stringWithFormat:@"%@, due:%@", self.taskName, self.taskDueDate];
    self.projectDetailLabel.text = projectCaption;
    
    
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

    
    self.bookReptTaskTemplate = [NSArray arrayWithObjects:
                                 @"this one is still in progress"
                                 @"Get book from library."
                                 @"Read first third of the chapters"
                                 @"Take notes on characters as you read the first section."
                                 @"Take notes on major plot themes in first section",
                                 @"Take notes on unfamiliar vocabulary words in first section",
                                 nil];
    
    self.testTaskTemplate = [NSArray arrayWithObjects:
                                 @"this one is still in progress",
                                 @"i found a video on cornell's website",
                                 @"that i plan to break into steps for this",
                                 @"i just wanted to have something here in the test",
                                 nil];
    
    [self chooseTaskList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
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
    
    //UIImage *background = [UIImage imageNamed:@"{custom table cell?}.png"];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:background];
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.selectedTaskTemplate objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}


@end
