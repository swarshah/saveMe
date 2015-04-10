//
//  FirstViewController.m
//  SaveMe
//
//  Created by Swar on 4/8/2015.
//  Copyright (c) 2015 Swar. All rights reserved.
//

#import "FirstViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface FirstViewController ()  <CLLocationManagerDelegate>
- (IBAction)savemeButton:(id)sender;

@end

@implementation FirstViewController{
    CLLocationManager *manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    manager = [[CLLocationManager alloc] init]; //init location manager
}

- (void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadString = [defaults objectForKey:@"firstRun"];
    if (loadString == nil) {
        NSLog(@"BLANK");
        [self performSegueWithIdentifier:@"Associate" sender:NULL];
    }
    else{
        NSLog(@"NOT BLANK");
    }
}

//Hiding nav bar
- (void) viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Save me button press
- (IBAction)savemeButton:(id)sender {
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;  //get best accuracy
    [manager startUpdatingLocation];    //start getting location
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error : %@", error);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //NSLog(@"Location: %f", newLocation.coordinate.longitude);
    CLLocation *currentLocation = newLocation;  //assigning new location
    NSString *latitude, *longitude; //created strings
    if(currentLocation != nil){ //checking for not null current location
        latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    }
    NSLog(@"Latitude: %@", latitude);
    NSLog(@"Latitude: %@", longitude);
    //stop updating location
    [manager stopUpdatingLocation];
    //[self getJSON];
    [self getDetails:latitude :longitude];
}

//function to get details from NSDefaults
- (void) getDetails :(NSString*)latitude :(NSString*)longitude{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"oName"];
    NSString *phone = [defaults objectForKey:@"cPhone"];
    NSString *email = [defaults objectForKey:@"cEmail"];
    NSString *location = [NSString stringWithFormat:@"%@,%@", latitude, longitude];
    [self sendHttpReq:name :phone :email :location];
}

-(void) sendHttpReq :(NSString*)name :(NSString*)phone :(NSString*)email :(NSString*)location{
    NSLog(@"%@", location);
    
}



@end
