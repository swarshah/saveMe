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
	[manager requestAlwaysAuthorization]; 	//Get's the permission of using location
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error : %@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Please turn on your location services."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [manager stopUpdatingLocation];
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
    //calling function
    [self getDetails:latitude :longitude];
}

//function to get details from NSDefaults
- (void) getDetails :(NSString*)latitude :(NSString*)longitude{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"oName"];
    NSString *phone = [defaults objectForKey:@"cNumber"];
    NSString *email = [defaults objectForKey:@"cEmail"];
    NSString *location = [NSString stringWithFormat:@"%@,%@", latitude, longitude];
    NSString *params = [NSString stringWithFormat:@"name=%@&phone=%@&email=%@&location=%@", name, phone, email, location];
    //calling function with params
    [self sendHttpReq:params];
}

//sending http post req
-(void) sendHttpReq :(NSString*)params {
    //API URL
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://saveme.ml/saveMeAPI/api.php"]];
    //Headers
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    NSError *error = nil;
    NSURLResponse *response = nil;
    //Sending request
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        //error
        NSLog(@"Error:%@", error.localizedDescription);
    }
    else {
        //success
        NSLog(@"Success");
        //Data from request
        NSString *newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", newStr);
        //Displaying alert for validation
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"We have sucessfully informed your contact."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
