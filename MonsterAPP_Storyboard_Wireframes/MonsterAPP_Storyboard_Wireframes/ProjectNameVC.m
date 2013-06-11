//
//  ProjectNameVC.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ProjectNameVC.h"
#import "DueDateViewController.h"

@interface ProjectNameVC ()
{
    NSString *nameRequest;
}
-(void)chooseNameRequest;

@end

@implementation ProjectNameVC

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
	nameRequest = [[NSString alloc] init];
    [self chooseNameRequest];
    self.nameRequestLabel.text = nameRequest;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)chooseNameRequest
{
    if ([self.projectTypeForName isEqual:@"Write a Book Report"]) {
        nameRequest = @"What book are you reading?";
    }else if ([self.projectTypeForName isEqual:@"Study for a Test"]){
        nameRequest = @"What test are you studying for?";
    } else {
        nameRequest = @"What will your experiment be about?";
    }
//at some point these questions may be an entity property?
}

#pragma
#pragma mark Segue to Naming Project

- (IBAction)nameWithButton:(id)sender {
    //add titleTextField.text to task properties
    [self performSegueWithIdentifier:@"segueToDate" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ((DueDateViewController*)(segue.destinationViewController)).taskNameForDate = self.projectTypeForName;
    
    ((DueDateViewController*)(segue.destinationViewController)).taskTitleEntered = self.titleTextField.text;
    
    
    NSLog(@"ProjectType sent to Date View -->%@",((DueDateViewController*)(segue.destinationViewController)).taskNameForDate);
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.titleTextField resignFirstResponder];
    return YES;
}
@end
