//
//  CategoryViewController.m
//  AudioMaps
//
//  Created by Brent Shadel on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "Environment.h"
#import "AudioPlayer.h"
#import "Listener.h"

@implementation CategoryViewController

@synthesize activeCategory, environment, locationManager;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = activeCategory;
	
	
	CLLocationManager *tempManager = [[CLLocationManager alloc] init];
	self.locationManager = tempManager;
	[tempManager release], tempManager = nil;
	self.locationManager.delegate = self;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	self.locationManager.headingFilter = 1;
	
	[self loadSelectedPage];
	
	//automatically start tracking?
}

-(void)loadSelectedPage
{
	environment = [environment initEnvironmentWithCategory:activeCategory];
}

-(IBAction)playButtonPressed
{
	if (self.environment.tracking)
	{
		[environment.audioPlayer playAllSoundsInEnvironment:environment];
		environment.isPlaying = YES;
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Error" message:@"Must begin tracking first!" delegate:self
							  cancelButtonTitle:@"Return" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}

-(IBAction)pauseButtonPressed
{
	[environment.audioPlayer pauseAllSoundsInEnvironment:environment];
	environment.isPlaying = NO;
}

-(IBAction)stopButtonPressed
{
	[environment.audioPlayer stopAllSoundsInEnvironment:environment];
	environment.isPlaying = NO;
}

-(IBAction)distanceSliderDidUpdate
{
	environment.maxDistance = distanceSlider.value;
	distanceValue.text = [NSString stringWithFormat:@"%1.2f",environment.maxDistance];
}


-(IBAction)trackingButtonPressed
{
	if (environment.tracking)
	{
		NSLog(@"stopping tracking");
		environment.tracking = NO;
		[self.locationManager stopUpdatingHeading];
		[self.locationManager stopUpdatingLocation];
		[trackingButton setTitle:@"Start Tracking" forState:UIControlStateNormal];
	}
	else
	{
		NSLog(@"starting tracking");
		environment.tracking = YES;
		
		[self.locationManager startUpdatingHeading];
		[self.locationManager startUpdatingLocation];
		[trackingButton setTitle:@"Stop Tracking" forState:UIControlStateNormal];
	}

}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newListenerLocation fromLocation:(CLLocation *)previousListenerLocation
{
	NSLog(@"updating position");
	[environment updateSourceLocations:newListenerLocation];
	
	xPos.text = [NSString stringWithFormat:@"%.5f",newListenerLocation.coordinate.latitude];
	zPos.text = [NSString stringWithFormat:@"%.5f",newListenerLocation.coordinate.longitude];

	sourceName.text = [self.environment getClosestPointName];
	sourceDistance.text = [NSString stringWithFormat:@"%.1f meters",[self.environment getClosestPointDistance:newListenerLocation.coordinate.latitude withLon:newListenerLocation.coordinate.longitude]];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newListenerHeading
{
	NSLog(@"updating heading");
	[environment updateListenerHeading:newListenerHeading];
	
	//[environment updateSourceGains:newListenerHeading];
	
	orientation.text = [NSString stringWithFormat:@"%.0f",[environment.activeListener getListenerHeadingInDegrees]];
}

-(void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
	if ([error code] == kCLErrorDenied)
		[locationManager stopUpdatingLocation];
	NSLog(@"location manager failed");
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}


- (void)dealloc
{
	NSLog(@"deallocating CategoryViewController");

	NSLog(@"trying to dealloc environment");
	[environment release], environment = nil;
	
	NSLog(@"trying to dealloc category");
	[activeCategory release], activeCategory = nil;
	
	NSLog(@"trying to dealloc locationManager");
	[locationManager release], locationManager = nil;
	
	NSLog(@"trying to dealloc super");
    [super dealloc];
}


@end
