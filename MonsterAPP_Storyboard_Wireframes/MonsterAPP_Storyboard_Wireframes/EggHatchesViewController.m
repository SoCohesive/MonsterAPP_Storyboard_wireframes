//
//  EggHatchesViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "EggHatchesViewController.h"
#import "TaskListViewController.h"

@interface EggHatchesViewController ()

@end

@implementation EggHatchesViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma
#pragma mark Segue to Naming Project

- (IBAction)enterNameButton:(id)sender {
    //fix this post-merge.
    [self performSegueWithIdentifier:@"segueToTaskList" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ((TaskListViewController*)(segue.destinationViewController)).taskType = self.taskProjectType;
    ((TaskListViewController*)(segue.destinationViewController)).taskDueDate =self.taskDueString;
    ((TaskListViewController*)(segue.destinationViewController)).taskName = self.taskTitle;
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.monsterNameField resignFirstResponder];
    return YES;
}



@end
