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
    
    [self performSegueWithIdentifier:@"segueToTaskList" sender:self];
    [self saveMonster];
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

-(void)saveMonster
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    
    //create managedObject
    Monster *monster = [NSEntityDescription insertNewObjectForEntityForName:@"Monster" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    monster.monsterName = self.monsterNameField.text;
    monster.monsterType  =self.monsterType;
    monster.task = self.task;
    

    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
    self.task.monster = monster;
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
    
    //create managedObject
    self.evolution2 = [NSEntityDescription insertNewObjectForEntityForName:@"Evolution" inManagedObjectContext:managedObjectContext];
    
    //set managedObject properties
    self.evolution2.evolutionNumber = [NSNumber numberWithInt:1];
    self.evolution2.evolutionDescription=@"Your turtling grew a tail! Now he's a tuserpent.";
    self.evolution2.thumbnailName = @"turtling-ev2-thumbnail.png";
    self.evolution2.monster = self.monster;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"Could not save task: %@", error);
    }
    
    [self.monster addEvolutionsObject:self.evolution1];
    [self.monster addEvolutionsObject:self.evolution2];
    
    
}


@end
