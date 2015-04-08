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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog([defaults objectForKey:@"oName"]);
    NSLog([defaults objectForKey:@"cName"]);
    NSLog([defaults objectForKey:@"cNumber"]);
    NSLog([defaults objectForKey:@"cEmail"]);
    NSLog([defaults objectForKey:@"firstRun"]);
   //NSLog(loadString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"false" forKey: @"firstRun"];
    [defaults setObject:self.oName.text forKey: @"oName"];
    [defaults setObject:self.cName.text forKey: @"cName"];
    [defaults setObject:self.cNumber.text forKey: @"cNumber"];
    [defaults setObject:self.cEmail.text forKey: @"cEmail"];
    [defaults synchronize];
    NSLog(@"Saved all data");
}
@end
