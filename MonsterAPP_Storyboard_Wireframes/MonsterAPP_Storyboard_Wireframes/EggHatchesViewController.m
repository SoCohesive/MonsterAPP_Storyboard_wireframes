//
//  EggHatchesViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/11/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "EggHatchesViewController.h"
#import "TaskListViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface EggHatchesViewController ()

-(void) hatchRightEgg;

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
    [self registerForKeyboardNotifications];
    
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.hatchedLabel.font.pointSize];
    self.hatchedLabel.font = lunchBoxBold;
    self.hatchedHeaderLabel.font = lunchBoxBold;
    
    self.monsterNameField.clearsOnInsertion = YES;
    self.monsterNameField.layer.cornerRadius=8.0f;
    self.monsterNameField.layer.masksToBounds=YES;
    self.monsterNameField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.monsterNameField.layer.borderWidth= 1.0f;
    self.monsterNameField.text = @"Let's give that monster a name.";
    
    self.nameButton.layer.cornerRadius = 8.0f;
    self.nameButton.layer.masksToBounds = YES;
    self.nameButton.tintColor = [UIColor purpleColor];
    //colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0];
    self.nameButton.titleLabel.font = lunchBoxBold;
    
    [self hatchRightEgg];
    
    
    SystemSoundID soundID2;
    NSString *soundFile2 = [[NSBundle mainBundle]
                            pathForResource:@"Monster_Hatch" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
									 [NSURL fileURLWithPath:soundFile2]
									 , &soundID2);
    AudioServicesPlaySystemSound(soundID2);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma
#pragma mark Segue to Naming Project

- (IBAction)enterNameButton:(id)sender {
    
    [self performSegueWithIdentifier:@"segueToTaskList" sender:self];
    [self saveMonster];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ((TaskListViewController*)(segue.destinationViewController)).selectedTask = self.task;
    ((TaskListViewController*)(segue.destinationViewController)).taskType = self.taskProjectType;
    ((TaskListViewController*)(segue.destinationViewController)).taskDueDate =self.taskDueString;
    ((TaskListViewController*)(segue.destinationViewController)).taskName = self.taskTitle;
    ((TaskListViewController*)(segue.destinationViewController)).taskListUser = self.eggHatchUser;

    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.monsterNameField resignFirstResponder];
    [self performSegueWithIdentifier:@"segueToTaskList" sender:self];
    return YES;
}

-(void)saveMonster
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    
    //create managedObject
    self.monster = [NSEntityDescription insertNewObjectForEntityForName:@"Monster" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    self.monster.monsterName = self.monsterNameField.text;
    self.monster.monsterType  =self.monsterType;
    self.monster.task = self.task;
    

    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
    self.task.monster = self.monster;
    [self saveEvolutionsToMonster];
    
}

-(void)saveEvolutionsToMonster
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    //create managedObject
    self.evolution1 = [NSEntityDescription insertNewObjectForEntityForName:@"Evolution" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    self.evolution1.evolutionNumber = [NSNumber numberWithInt:1];
    self.evolution1.evolutionDescription=@"Your turtling can wobble!";
    self.evolution1.thumbnailName = @"turtling-ev1-thumbnail.png";
    self.evolution1.eggImageName = @"firstEgg.png";
    self.evolution1.monster = self.monster;
    [self.monster addEvolutionsObject:self.evolution1];

    
    //create managedObject
    self.evolution2 = [NSEntityDescription insertNewObjectForEntityForName:@"Evolution" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    self.evolution2.evolutionNumber = [NSNumber numberWithInt:2];
    self.evolution2.evolutionDescription=@"Your turtling grew a tail! Now he's a tuserpent.";
    self.evolution2.thumbnailName = @"turtling-ev2-thumbnail.png";
    self.evolution2.monster = self.monster;
    [self.monster addEvolutionsObject:self.evolution2];
    
    //create managedObject
    self.evolution3 = [NSEntityDescription insertNewObjectForEntityForName:@"Evolution" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    self.evolution3.evolutionNumber = [NSNumber numberWithInt:3];
    self.evolution3.evolutionDescription=@"Your tuserpent grew some interesting forelimbs.";
    self.evolution3.thumbnailName = @"turtling-ev3-thumbnail.png";
    self.evolution3.monster = self.monster;
    [self.monster addEvolutionsObject:self.evolution3];

    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
   }

#pragma
#pragma slideView for Keyboard Space
//from documentation
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollViewForKeyboard.contentInset = contentInsets;
    self.scrollViewForKeyboard.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height+105;
    CGPoint origin = self.monsterNameField.frame.origin;
    origin.y -= self.scrollViewForKeyboard.contentOffset.y;
    if (!CGRectContainsPoint(aRect, origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.monsterNameField.frame.origin.y-(aRect.size.height));
        [self.scrollViewForKeyboard setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollViewForKeyboard.contentInset = contentInsets;
    self.scrollViewForKeyboard.scrollIndicatorInsets = contentInsets;
}

-(void) hatchRightEgg {
    
    CALayer *rightLayer = self.rightEggImage.layer;
    rightLayer.anchorPoint = CGPointMake(0.5, 1.0);
    
    CALayer *leftLayer = self.leftEggImage.layer;
    leftLayer.anchorPoint = CGPointMake(0.5, 1.0);
    
    
    //RightSide Egg position
    CGPoint position = rightLayer.position;
    CGFloat posX= position.x;
    CGFloat posY = 247;
    rightLayer.position = CGPointMake(posX, posY);
    
    CGPoint leftPosition = leftLayer.position;
    CGFloat leftPosX= leftPosition.x;
    CGFloat leftPosY = 247;
    leftLayer.position = CGPointMake(leftPosX, leftPosY);
    
    [UIView animateWithDuration:.07
                          delay: 0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         // ASK about looping through and adding degrees one at a time
                         
                         // for (int i=3; i < 10; i++) {
                         
                         [UIView setAnimationRepeatAutoreverses:YES];
                         [UIView setAnimationRepeatCount:10];
                         
                         self.rightEggImage.transform = CGAffineTransformMakeRotation(1.0 * M_PI/180);
                         self.leftEggImage.transform = CGAffineTransformMakeRotation(-1.0 * M_PI/180);
                         
                         
                     }
     
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:.10 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                             [UIView setAnimationRepeatAutoreverses:YES];
                             [UIView setAnimationRepeatCount:10];
                             
                             self.rightEggImage.transform = CGAffineTransformMakeRotation(4.5 * M_PI/180);
                             self.leftEggImage.transform = CGAffineTransformMakeRotation(-4.5 * M_PI/180);
                         } completion:^(BOOL finished) {
                             
                             
                         }];
                         
                         
                     }];
    
    
}


@end
