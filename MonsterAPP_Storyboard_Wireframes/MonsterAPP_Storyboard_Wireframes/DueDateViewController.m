//
//  DueDateViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "DueDateViewController.h"
#import "EggHatchesViewController.h"

@interface DueDateViewController ()

{
    NSString *dateRequest;
    NSString *selectionString;
}

-(void)chooseDueQuestion;

@end

@implementation DueDateViewController

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
    [self chooseDueQuestion];
    NSDate *pickerDate = [self.dueDatePicker date];
    selectionString = [[NSString alloc] initWithFormat:@"%@", [pickerDate descriptionWithLocale:[NSLocale currentLocale]]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)chooseDueQuestion
{
    if ([self.taskNameForDate isEqual:@"Write a Book Report"]) {
        self.dateDueQuestion.text = @"When is your report due?";
    }else if ([self.taskNameForDate isEqual:@"Study for a Test"]){
        self.dateDueQuestion.text = @"So when is the big test?";
    } else {
        self.dateDueQuestion.text = @"When will you present your discovery?";
    }
}
#pragma
#pragma mark Segue to Naming Project

- (IBAction)doneDateButton:(id)sender {
    
    NSLog(@"date entered: %@",selectionString);
    //submit date to data.
    [self performSegueWithIdentifier:@"segueToHatching" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ((EggHatchesViewController*)(segue.destinationViewController)).taskProjectType = self.taskNameForDate;
    ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString = selectionString;
    ((EggHatchesViewController*)(segue.destinationViewController)).taskTitle = selectionString;
    
    NSLog(@"ProjectDuesent to Hatchin View -->%@", ((EggHatchesViewController*)(segue.destinationViewController)).taskDueString = selectionString);
    
}
@end
