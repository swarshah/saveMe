//
//  SecondViewController.m
//  SaveMe
//
//  Created by Swar on 4/8/2015.
//  Copyright (c) 2015 Swar. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)edit:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"cName"];
    NSString *number = [defaults objectForKey:@"cNumber"];
    NSString *email = [defaults objectForKey:@"cEmail"];
    self.name.text = name;
    self.phone.text = number;
    self.email.text = email;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    //When Save is clicked
    if(self.name.isEnabled){
        if([self.name.text isEqual:@""] || [self.phone.text isEqual:@""] || [self.email.text isEqual:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"All fields are required."
                                                            message:@"You must fill all the details to use this app."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            [self.editBtn setTitle:@"Edit"];
            self.name.enabled = NO;
            self.phone.enabled = NO;
            self.email.enabled = NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.name.text forKey: @"cName"];
            [defaults setObject:self.phone.text forKey: @"cNumber"];
            [defaults setObject:self.email.text forKey: @"cEmail"];
            [defaults synchronize];
        }
    }
    //Wehn Edit is clicked
    else{
        [self.editBtn setTitle:@"Save"];
        self.name.enabled = YES;
        self.phone.enabled = YES;
        self.email.enabled = YES;
    }
    
}

@end
