//
//  OnboardingViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/12/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "OnboardingViewController.h"
#import "ScrollViewforOnBoarding.h"

@interface OnboardingViewController ()
{
    CATransform3D *theTransformer;
    CABasicAnimation *rotateAnimation; 
    
}

@property (strong, nonatomic) IBOutlet UIImageView *wormChat;

-(void) openDoorAnimation;
-(void) playOpenDoorSound;
-(void) showMonsterAnimation; 


@end

@implementation OnboardingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:YES]; 
    //animated was never read.
    //animated = YES;
    
    [self performSelector:@selector(playOpenDoorSound) withObject:nil afterDelay:.02];
    [self performSelector:@selector(openDoorAnimation) withObject:nil afterDelay:.15];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) openDoorAnimation {
    
    // Make layer for door image and then change the anchorpoint so you can rotate the door on the y-axis 
    CALayer *layer = self.doorImage.layer;
    layer.anchorPoint = CGPointMake(0.0, 0.0);
    
    CGPoint position = layer.position;
    CGSize size = layer.bounds.size;
    CGFloat posX= position.x - size.width / 2;
    CGFloat posY = position.y - size.height / 2;
    layer.position = CGPointMake(posX, posY);
    
        [UIView animateWithDuration:2.0f animations:^{
                
        CATransform3D rotateT = CATransform3DIdentity;
        rotateT.m34 = 1.0 /-300;
        rotateT= CATransform3DRotate(rotateT, -150.0f * M_PI/180.0f, 0, 1, 0);
        layer.transform = rotateT;
        
        [self showMonsterAnimation];

    }];
    
    
}

-(void) playOpenDoorSound {
    
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle]
                           pathForResource:@"Monster_Door" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
                                     [NSURL fileURLWithPath:soundFile]
                                     , &soundID);
    AudioServicesPlaySystemSound(soundID);

    
}

-(void) showMonsterAnimation {
    
    // starting position of Monster Body Image
    CALayer *layer   = self.monsterImage.layer;
    CGPoint position = layer.position;
    CGFloat posX = -36;
    CGFloat posY = 350;
    layer.position = CGPointMake(posX, posY);
    
    self.monsterImage.hidden = NO;
    
    //starting position of Monster Paw
    CALayer *pawLayer = self.monsterPawImage.layer;
    CGFloat pawPosX = 20;
    CGFloat pawPosY = 350;
    pawLayer.position = CGPointMake(pawPosX, pawPosY);
    self.monsterPawImage.hidden = NO;
    
    //starting position of note Image
    CALayer *noteLayer = self.noteImageForButton.layer;
    CGFloat notePosX = 40;
    CGFloat notePosY = 350;
    noteLayer.position = CGPointMake(notePosX,notePosY);
    self.noteImageForButton.hidden = NO; 
    
    
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //ending position Monster Body
        CGFloat newPosX = 100;
        CGFloat newPosY = 165;
        layer.position = CGPointMake(newPosX, newPosY);
        self.monsterImage.alpha = 1;
        
        //ending position Monster Paw
        CGFloat newPawPosX = 150;
        CGFloat newPawPosY = 170;
        pawLayer.position = CGPointMake(newPawPosX, newPawPosY);
        self.monsterPawImage.alpha =1;
        
        CGFloat newNotePosX = 182;
        CGFloat newNotePosY = 204;
        noteLayer.position = CGPointMake(newNotePosX, newNotePosY);
        self.noteImageForButton.alpha = 1; 
        
        

    } completion:^(BOOL finished) {
        
               
    }];
    
}

- (IBAction)getStartedButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pushToLogin" sender:self];
}
@end
