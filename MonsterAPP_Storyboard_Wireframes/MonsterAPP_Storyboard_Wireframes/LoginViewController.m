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

@interface LoginViewController ()



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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
    // NSManagedObjectContext *managedObjectContext;
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    //user is our managedObject
    User *testUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    testUser.firstName = self.nameField.text;
    
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


@end
