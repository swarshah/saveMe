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
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [main instantiateViewControllerWithIdentifier:@"addScreen"];
        [self presentViewController:vc animated:NO completion:nil ];
    }
    else{
        NSLog(@"NOT");
        /*UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [main instantiateViewControllerWithIdentifier:@"addScreen"];
        [self presentViewController:vc animated:NO completion:nil ];*/

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
}
@end
