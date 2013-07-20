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
    
}

-(void)fetchUserInfo;
@property (strong, nonatomic) User *currentUser;

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
-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.loginLabel.text= @"Sign up";
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.loginLabel.font.pointSize];
    self.loginLabel.font = lunchBoxBold;
    
    self.nameLabel.text= @"Name:";
    UIFont *lunchBoxBold2 = [UIFont fontWithName:@"LunchBox-Light" size:self.nameLabel.font.pointSize];
    self.nameLabel.font = lunchBoxBold2;
    
    self.nicknameLabel.text = @"Nickname:";
    self.nicknameLabel.font = lunchBoxBold2;
    
    [self formatTextFields];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
////    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
//    
//    // Save the context.
//    NSError *error = nil;
//    if (![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//}

-(void)formatTextFields
{
//    self.nameField.text = @"What's your name?";
//    self.emailField.text = @"Give us a special nickname, too.";
    
    self.nameField.clearsOnInsertion = YES;
    self.nameField.layer.cornerRadius=8.0f;
    self.nameField.layer.masksToBounds=YES;
    self.nameField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.nameField.layer.borderWidth= 1.0f;
    self.nameField.backgroundColor = [UIColor whiteColor];

    
    self.emailField.layer.cornerRadius=8.0f;
    self.emailField.layer.masksToBounds=YES;
    self.emailField.layer.borderColor = [[UIColor colorWithRed:49.0/255.0 green:25.0/255.0 blue:60.0/255.0 alpha:1.0]CGColor];
    self.emailField.layer.borderWidth= 1.0f;
    self.emailField.backgroundColor = [UIColor whiteColor];

    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.nameField) {
        
        self.nameField.delegate = self;
        
        [self.nameField resignFirstResponder];
        [self.emailField becomeFirstResponder];
        //add titleTextField.text to task properties
    } else {
        
        [self saveUser];
        
        [self performSegueWithIdentifier:@"segueToPicker" sender:self];
        
    }
    return YES;
}


-(void)saveUser
{
NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;

//user is our managedObject
User *testUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];

testUser.firstName = self.nameField.text;
testUser.nickname = self.emailField.text;
testUser.dateCreated = [NSDate date];

NSError *error = nil;
if (![managedObjectContext save:&error]) {
    
    NSLog(@"An error occured: %@", error);
}
self.currentUser = testUser;
NSLog(@"currentUser: %@", self.currentUser);
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ((ProjectPickerVC*)(segue.destinationViewController)).projPickerCurrentUser = self.currentUser;
    
    NSLog(@"User sent to Name View -->%@",((ProjectPickerVC*)(segue.destinationViewController)).projPickerCurrentUser);
    
}

- (IBAction)loginWithButton:(id)sender {
    [self saveUser];
    [self performSegueWithIdentifier:@"segueToPicker" sender:self];
}
@end
