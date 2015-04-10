//
//  FirstRunViewController.m
//  SaveMe
//
//  Created by Swar on 4/8/2015.
//  Copyright (c) 2015 Swar. All rights reserved.
//

#import "FirstRunViewController.h"

@interface FirstRunViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oName;
@property (weak, nonatomic) IBOutlet UITextField *cName;
@property (weak, nonatomic) IBOutlet UITextField *cNumber;
@property (weak, nonatomic) IBOutlet UITextField *cEmail;
- (IBAction)saveButton:(id)sender;

@end

@implementation FirstRunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Hiding navigation bar
- (void) viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
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

//Saves all values
- (IBAction)saveButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"false" forKey: @"firstRun"];
    [defaults setObject:self.oName.text forKey: @"oName"];
    [defaults setObject:self.cName.text forKey: @"cName"];
    [defaults setObject:self.cNumber.text forKey: @"cNumber"];
    [defaults setObject:self.cEmail.text forKey: @"cEmail"];
    [defaults synchronize];
    NSLog(@"Saved all data");
    //Segue push
    [self performSegueWithIdentifier:@"AssociateBack" sender:NULL];
}
@end
