//
//  TurtlingClass.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by ehochs  on 6/17/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "TurtlingClass.h"
#import "AppDelegate.h"

@implementation TurtlingClass

-(void)saveEvolutionsToMonster
{
    //what monster will it pull if I put this someplace else. 
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
