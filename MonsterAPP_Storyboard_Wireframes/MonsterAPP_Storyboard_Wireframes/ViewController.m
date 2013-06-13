//
//  ViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Sonam Dhingra on 6/8/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "ProjectListViewController.h"

@interface ViewController ()
{
    NSString    *userName;
    NSString    *segueID;
}
-(void)fetchForLanding;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchForLanding];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchForLanding
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];

    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    userName = [[NSString alloc] init];
    
    if (fetchedObjects == nil) {
    NSLog(@"error");
    }
    
if (fetchedObjects.count == 0){
    segueID = @"segueToOnboarding";
    [self chooseLanding];
} else {
    User * user = fetchedObjects.lastObject;
    userName = user.firstName;
    segueID = @"segueToHome";
    [self chooseLanding];
}

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
        if ([segueID isEqualToString: @"segueToHome"]) {
            ((ProjectListViewController*)(segue.destinationViewController)).currentUser = userName;
            NSLog(@"UserName: %@",  ((ProjectListViewController*)(segue.destinationViewController)).currentUser);
            
        } else {
            NSLog(@"no users");
        }
}

-(void)chooseLanding{
    [self performSegueWithIdentifier:segueID sender:self];
}
    

@end
