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

@interface ProjectNameVC ()
{
    //NSString *nameRequest;
    //NSString *dateRequest;
    
    NSString    *selectionString;
    NSDate      *pickerDate;
    NSDate      *currentDate;
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

    [self formatTextFields];
    [self chooseNameRequest];
    [self chooseDueQuestion];
    [self fetchCurrentUser];
    
    pickerDate = [self.datePicker date];
    selectionString = [[NSString alloc] initWithFormat:@"%@", [pickerDate descriptionWithLocale:[NSLocale currentLocale]]];
    
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.titleLabel.font.pointSize];
    self.titleLabel.font = lunchBoxBold;
    
    
    
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

    
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self.dateEntryField
//                                            action:@selector(handleSingleTap:)];
//    [self.dateEntryField addGestureRecognizer:singleFingerTap];
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
        return YES;
    }

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.titleTextField) {
        self.titleTextField.delegate = self;
    
        [self.titleTextField resignFirstResponder];
        [self.dateEntryField becomeFirstResponder];
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
    self.currentTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:managedObjectContext];
    
    
    //set managedObject properties
    currentDate = [NSDate date];
    self.currentTask.dateCreated =  currentDate;
    self.currentTask.projectedEndDate =  pickerDate;
    self.currentTask.taskName = self.titleTextField.text;
    self.currentTask.taskType= self.projectTypeForName;
    self.currentTask.actualHP = [NSNumber numberWithInt: 50];
    self.currentTask.actualXP = [NSNumber numberWithInt:50];
    self.currentTask.user = currentUser;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
    [currentUser addTasksObject:self.currentTask];
   
    //once this works, we should prevent the back button from saving over it, and do some kind of edit instead.
    //when the project is saved, we should assign a new monster, and save the monster name on the next screen.

}

#pragma
#pragma mark Date Difference Logic

    //currentDate
    //pickerDate

-(void)calculateDateDifference:(NSDate *)chosenDate{
//    NSDate *todaysDate;
    NSString *differenceOutput;
    NSString *currentDateString;
    NSString *pickerDateString;
    NSDateFormatter *dateFormat;
    NSTimeInterval differenceInDays;
    
//    todaysDate = [NSDate date];
    differenceInDays = [currentDate timeIntervalSinceDate:chosenDate] / 86400;
    
    dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MMMM d, yyyy hh:mm:ssa"];
    currentDateString = [dateFormat stringFromDate:currentDate];
    pickerDateString = [dateFormat stringFromDate:pickerDate];
    
    differenceOutput = [[NSString alloc] initWithFormat:@"Your begin date is %@, you plan to finish by %@, so you have %1.2f days left!!", pickerDateString, currentDateString, fabs(differenceInDays)];
    
    NSLog(@"Your begin date is %@, you plan to finish by %@, so you have %1.2f days left!!", pickerDateString, currentDateString, fabs(differenceInDays));
//    self.outputLabel.text = differenceOutput;
    
}


#pragma
#pragma mark Segue to EggHatch

- (IBAction)saveTaskDoneButton:(id)sender
{
    //add titleTextField.text to task properties
    [self performSegueWithIdentifier:@"segueToHatch" sender:self];
       
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    [self addTask];
    
    //these will go away
    ((EggHatchesViewController*)(segue.destinationViewController)).taskProjectType = self.projectTypeForName;
    ((EggHatchesViewController*)(segue.destinationViewController)).taskTitle = self.titleTextField.text;
    
    
    ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString = selectionString;
    ((EggHatchesViewController*)(segue.destinationViewController)).monsterType = self.monsterKind;
     ((EggHatchesViewController*)(segue.destinationViewController)).task = self.currentTask;
    
     NSLog(@"Project sent to Hatching View -->%@, due: %@, namedTaskName: %@",((EggHatchesViewController*)(segue.destinationViewController)).taskTitle,  ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString, self.currentTask);
    
}

@end
