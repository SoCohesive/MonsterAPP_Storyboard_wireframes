//
//  LoginViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Administrator on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "User.h"
#import "AppDelegate.h"
#import "ProjectPickerVC.h"
// ? #import <CoreData/CoreData.h>

@interface LoginViewController ()
{
    NSNumber    *userNumber;
    User        *currentUser;
}

-(void)fetchUserInfo;
@end

@implementation LoginViewController

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
    
    self.loginLabel.text= @"Login, please:";
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.loginLabel.font.pointSize];
    self.loginLabel.font = lunchBoxBold;
    
    
    [self formatTextFields];
    
    NSLog(@"LunchBox: %@", [UIFont fontNamesForFamilyName:@"LunchBox"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(void)formatTextFields
{
    self.nameField.text = @"What's your name?";
    self.emailField.text = @"Give us a special nickname, too.";
    
    self.nameField.layer.cornerRadius=8.0f;
    self.nameField.layer.masksToBounds=YES;
    self.nameField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.nameField.layer.borderWidth= 1.0f;
    
    self.emailField.layer.cornerRadius=8.0f;
    self.emailField.layer.masksToBounds=YES;
    self.emailField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.emailField.layer.borderWidth= 1.0f;
}

/*- (IBAction)loginButton:(id)sender {
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    //user is our managedObject
    User *testUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    testUser.firstName = self.nameField.text;
    testUser.nickname = self.emailField.text;
    testUser.userID = userNumber;
    testUser.dateCreated = [NSDate date];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"An error occured: %@", error);
    }

    }*/


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.nameField) {
        
        self.nameField.delegate = self;
        
        [self.nameField resignFirstResponder];
        [self.emailField becomeFirstResponder];
        //add titleTextField.text to task properties
    } else {
        
         self.emailField.delegate = self;
        
        //maybe this should be a separate method, called at button and enter
        
        NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
        
        //user is our managedObject
        User *testUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
        
        testUser.firstName = self.nameField.text;
        testUser.nickname = self.emailField.text;
        testUser.userID = userNumber;
        testUser.dateCreated = [NSDate date];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            
            NSLog(@"An error occured: %@", error);
        }

        
    }
    return YES;
}


-(void)fetchUserInfo
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
    //this isn't working as of 1pm, 6/14.
    if (fetchedObjects.count == 0){
       userNumber = [NSNumber numberWithInt: 1] ;
        
    } else {
        userNumber = [NSNumber numberWithInt: fetchedObjects.count +1];

    }
    //insert comparison feature here.
}




- (IBAction)loginDoneBarButton:(id)sender {
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    //user is our managedObject
    User *testUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    testUser.firstName = self.nameField.text;
    testUser.nickname = self.emailField.text;
    testUser.userID = userNumber;
    testUser.dateCreated = [NSDate date];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        
        NSLog(@"An error occured: %@", error);
    }

}
@end
