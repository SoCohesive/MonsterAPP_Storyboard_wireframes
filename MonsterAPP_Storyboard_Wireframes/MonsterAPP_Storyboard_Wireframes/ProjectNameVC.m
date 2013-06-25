//
//  ProjectNameVC.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ProjectNameVC.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "EggHatchesViewController.h"
#import "TaskDetail.h"

@interface ProjectNameVC ()
{
    //NSString *nameRequest;
    //NSString *dateRequest;
    
    //NSString      *selectionString;
    NSDate          *pickerDate;

}


-(void)chooseNameRequest;
-(void)formatTextFields;
-(void) chooseTaskList;
-(void) createTemplates;


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
    
    [self formatTextFields];
    [self chooseNameRequest];
    [self chooseDueQuestion];
    [self createTemplates];
    
    
    pickerDate = [self.datePicker date];
    //selectionString = [[NSString alloc] initWithFormat:@"%@", [pickerDate descriptionWithLocale:[NSLocale currentLocale]]];
    
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.titleLabel.font.pointSize];
    self.titleLabel.font = lunchBoxBold;
    
    self.nameLabel.text= @"Project Name:";
    UIFont *lunchBoxBold2 = [UIFont fontWithName:@"LunchBox-Light" size:self.nameLabel.font.pointSize];
    self.nameLabel.font = lunchBoxBold2;
    
    self.dueDateLabel.text = @"Due Date:";
    self.dueDateLabel.font = lunchBoxBold2;
    
    [self formatTextFields];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)formatTextFields
{
    self.titleTextField.layer.cornerRadius=8.0f;
    self.titleTextField.layer.masksToBounds=YES;
    self.titleTextField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.titleTextField.layer.borderWidth= 1.0f;
    
    self.dateEntryField.layer.cornerRadius=8.0f;
    self.dateEntryField.layer.masksToBounds=YES;
    self.dateEntryField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.dateEntryField.layer.borderWidth= 1.0f;
    
    self.dateEntryField.inputView = self.datePicker;
    self.dateEntryField.inputAccessoryView = self.datePickToolbar;

}


#pragma
#pragma Title/Name Input

-(void)chooseNameRequest
{
    if ([self.projectTypeForName isEqual:@"Write a Book Report"]) {
        self.titleTextField.text = @"What book are you reading?";
    }else if ([self.projectTypeForName isEqual:@"Study for a Test"]){
        self.titleTextField.text = @"What test are you studying for?";
    } else {
        self.titleTextField.text = @"What will your experiment be about?";
    }
    //at some point these questions may be an entity property?
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.titleTextField) {
        return YES;
    }else{
        return NO;
    
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.titleTextField) {
        self.titleTextField.delegate = self;
        
        if ( [self.titleTextField.text length] > 0) {
            
            [self.titleTextField resignFirstResponder];
            [self.dateEntryField becomeFirstResponder];
            [self animateDatePicker];
            
        }
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    return YES;
}


#pragma
#pragma DueDate Input

-(void)chooseDueQuestion
{
    if ([self.projectTypeForName isEqual:@"Write a Book Report"]) {
        self.dateEntryField.text = @"Select Date";
        
    }else if ([self.projectTypeForName isEqual:@"Study for a Test"]){
        self.dateEntryField.text = @"So when is the big test?";
        
    } else {
        self.dateEntryField.text = @"When will you present your discovery?";
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self animateDatePicker];
}


-(void)animateDatePicker
{

    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    
    // Set the type & direction of the transition,
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    // Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
    [animation setDuration:0.1];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [[self.datePicker layer] addAnimation:animation forKey:@"transitionViewAnimation"];
    [[self.datePickToolbar layer] addAnimation:animation forKey:@"transitionViewAnimation"];
    
    self.datePicker.hidden = FALSE;
    self.datePickToolbar.hidden = FALSE;
    self.datePicker.minimumDate = [NSDate date];
    
    [[self.datePicker layer] removeAnimationForKey:@"transitionViewAnimation"];
    [[self.datePickToolbar layer] removeAnimationForKey:@"transitionViewAnimation"];
    animation = nil;
    
    
}
#pragma
#pragma CoreData

-(void)addTask
{
       
    NSLog(@"datepicker date:%@", pickerDate);
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    //create managedObject
    self.currentTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:managedObjectContext];
    
    
    //set managedObject properties
    self.currentTask.dateCreated =  [NSDate date];
    self.currentTask.projectedEndDate =  [self.datePicker date];
    self.currentTask.taskName = self.titleTextField.text;
    self.currentTask.taskType= self.projectTypeForName;
    self.currentTask.actualHP = [NSNumber numberWithInt: 50];
    self.currentTask.actualXP = [NSNumber numberWithInt:50];
    self.currentTask.user = self.projNameUser;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy hh:mm:ssa"];
    NSString *logDateString = [dateFormatter stringFromDate:self.currentTask.projectedEndDate];
    NSLog(@"the date picked is %@", logDateString);
    
    
    for (NSString *step in self.selectedTaskTemplate) {
        //create the object
        TaskDetail * taskDetail = [NSEntityDescription insertNewObjectForEntityForName:@"TaskDetail" inManagedObjectContext:managedObjectContext];
        taskDetail.stepDetail = step;
        taskDetail.stepCreatedDate = [NSDate date];
        taskDetail.task = self.currentTask;
        taskDetail.possStepXP = [NSNumber numberWithInt:25];
        
        [self.currentTask addTaskDetailsObject:taskDetail];
    }
    
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
    [self.projNameUser addTasksObject:self.currentTask];
    
    //once this works, we should prevent the back button from saving over it, and do some kind of edit instead.
    //when the project is saved, we should assign a new monster, and save the monster name on the next screen.
    
}

#pragma
#pragma mark Setup & Save Preformatted Templates

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
    
    [self chooseTaskList];
    
}


-(void)chooseTaskList
{
    if ([self.projectTypeForName isEqual:@"Write a Book Report"]) {
        self.selectedTaskTemplate = self.bookReptTaskTemplate;
        
    }else if ([self.projectTypeForName isEqual:@"Study for a Test"]){
        self.selectedTaskTemplate =self.testTaskTemplate;
    } else {
        self.selectedTaskTemplate = self.scienceTaskTemplate;
    }
}


#pragma
#pragma mark Segue to EggHatch

- (IBAction)saveTaskDoneButton:(id)sender
{
    //add titleTextField.text to task properties
    [self performSegueWithIdentifier:@"segueToHatch" sender:self];
  
}

- (IBAction)pickerToolbarDoneButton:(id)sender {

    [self performSegueWithIdentifier:@"segueToHatch" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [self addTask];
    
    
    ((EggHatchesViewController*)(segue.destinationViewController)).eggHatchUser = self.projNameUser;
    ((EggHatchesViewController*)(segue.destinationViewController)).taskProjectType = self.projectTypeForName;
    ((EggHatchesViewController*)(segue.destinationViewController)).taskTitle = self.titleTextField.text;
    
    
    //((EggHatchesViewController*)(segue.destinationViewController)).taskDueString = selectionString;
    ((EggHatchesViewController*)(segue.destinationViewController)).monsterType = self.monsterKind;
    ((EggHatchesViewController*)(segue.destinationViewController)).task = self.currentTask;
    
    //NSLog(@"Project sent to Hatching View -->%@, due: %@, namedTaskName: %@",((EggHatchesViewController*)(segue.destinationViewController)).taskTitle,  ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString, self.currentTask);
    
}


- (IBAction)pickDateButton:(id)sender {
    [self performSegueWithIdentifier:@"segueToHatch" sender:self];

}
@end
