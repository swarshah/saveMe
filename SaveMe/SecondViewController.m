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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    //When Save is clicked
    if(self.name.isEnabled){
        [self.editBtn setTitle:@"Edit"];
        self.name.enabled = NO;
        self.phone.enabled = NO;
        self.email.enabled = NO;
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
