//
//  ProjectPickerVC.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "ProjectPickerVC.h"
#import "NewEggViewController.h"

@interface ProjectPickerVC ()


@end

@implementation ProjectPickerVC

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
    self.projectTemplateName = [[NSString alloc] init];
    
    self.title = @"Pick a Project Type";

    // related to table view for generating project items, and segue to next view.  These will likely later become entities.
    self.projectTypes = [NSMutableArray arrayWithObjects: @"Write a Book Report", @"Study for a Test", @"Prepare for a Science Project", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.projectTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"projectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:identifier];
    }
    
    //UIImage *background = [UIImage imageNamed:@"{custom table cell?}.png"];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:background];
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.projectTypes objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}

#pragma
#pragma mark Segue to first reward 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.projectTemplateName = [self.projectTypes objectAtIndex:indexPath.row];
    [self.projectTypesTable deselectRowAtIndexPath:indexPath animated:YES];
    
   [self performSegueWithIdentifier:@"segueToRewardView" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
((NewEggViewController*)(segue.destinationViewController)).projectTypeName = self.projectTemplateName;
    
    NSLog(@"PickedProject as sent to egg -->%@",((NewEggViewController*)(segue.destinationViewController)).projectTypeName );
    
}


@end
