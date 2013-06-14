//
//  LoginViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Administrator on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "LoginViewController.h"
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailField resignFirstResponder];
    [self.nameField resignFirstResponder];
    
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



@end
