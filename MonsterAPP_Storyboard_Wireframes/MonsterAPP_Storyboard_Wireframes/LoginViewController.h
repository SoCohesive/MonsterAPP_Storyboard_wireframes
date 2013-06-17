//
//  LoginViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Administrator on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD

@interface LoginViewController : UIViewController

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
=======
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
- (IBAction)loginDoneBarButton:(id)sender;

>>>>>>> 42b38aab70833dbb8744053da937a9a515e7f4de

@end
