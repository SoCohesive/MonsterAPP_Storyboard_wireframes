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
#import "User.h"
#import "Task.h"
#import "EggHatchesViewController.h"

@interface ProjectNameVC ()
{
    //NSString *nameRequest;
    //NSString *dateRequest;
    
    NSString    *selectionString;
    NSDate      *pickerDate;
    User        *currentUser;

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

	//nameRequest = [[NSString alloc] init];
    
    [self chooseNameRequest];
    [self chooseDueQuestion];
    [self fetchCurrentUser];
    
    pickerDate = [self.datePicker date];
    selectionString = [[NSString alloc] initWithFormat:@"%@", [pickerDate descriptionWithLocale:[NSLocale currentLocale]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } else {
        return NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.titleTextField.delegate = self;
    
    if (textField == self.titleTextField) {
        
        [self.titleTextField resignFirstResponder];
        [self.dateEntryField becomeFirstResponder];
        //add titleTextField.text to task properties
    }
    return YES;
}

#pragma
#pragma DueDate Input

-(void)chooseDueQuestion
{
    if ([self.projectTypeForName isEqual:@"Write a Book Report"]) {
        self.dateEntryField.text = @"When is your report due?";
    }else if ([self.projectTypeForName isEqual:@"Study for a Test"]){
        self.dateEntryField.text = @"So when is the big test?";
    } else {
        self.dateEntryField.text = @"When will you present your discovery?";
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //self.datePicker = [[UIDatePicker alloc] init];
    [self animateDatePicker];
    [self.view addSubview:self.datePicker];
 }

-(void)animateDatePicker
{
    
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    
    // Set the type & direction of the transition,
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    // Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
    [animation setDuration:0.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [[self.datePicker layer] addAnimation:animation forKey:@"transitionViewAnimation"];
    
    self.datePicker.hidden = FALSE;
    
    [[self.datePicker layer] removeAnimationForKey:@"transitionViewAnimation"];
    animation = nil;
    
}
#pragma 
#pragma CoreData 

-(void)fetchCurrentUser
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        NSLog(@"user fetch error");
    }
    
    currentUser = fetchedObjects.lastObject;

}

-(void)addTask
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    //create managedObject
    Task *currentTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    NSDate *currentDate = [NSDate date];
    currentTask.dateCreated =  currentDate;
    currentTask.projectedEndDate =  pickerDate;
    currentTask.taskName = self.titleTextField.text;
    currentTask.taskType= self.projectTypeForName;
    currentTask.actualHP = [NSNumber numberWithInt: 50];
    currentTask.actualXP = [NSNumber numberWithInt:50];
    currentTask.user = currentUser;
    //currentTask.monster =
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
    [currentUser addTasksObject:currentTask];
    
    //once this works, we should prevent the back button from saving over it, and do some kind of edit instead.
    //when the project is saved, we should assign a new monster, and save the monster name on the next screen.

}
#pragma
#pragma mark Segue to EggHatch

- (IBAction)saveTaskDoneButton:(id)sender
{
    //add titleTextField.text to task properties
    [self performSegueWithIdentifier:@"segueToHatch" sender:self];
    [self addTask];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    //these will go away
    ((EggHatchesViewController*)(segue.destinationViewController)).taskProjectType = self.projectTypeForName;
    ((EggHatchesViewController*)(segue.destinationViewController)).taskTitle = self.titleTextField.text;
    
    
    ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString = selectionString;
    //send monster type, and set image path for that monster's egg/hatch sequence.
    
     NSLog(@"Project sent to Hatching View -->%@, due%@",((EggHatchesViewController*)(segue.destinationViewController)).taskTitle,  ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString);
    
}









@end
