//
//  Environment.h
//  AudioMaps
//
//  Created by Brent Shadel on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenAL/al.h"
#import "OpenAL/alc.h"
#import "CoreLocation/CoreLocation.h"

@class AudioPlayer, Category, Listener;

@interface Environment : NSObject
{
	BOOL tracking;
}

@property (nonatomic, retain) Category *activeCategory;
@property (nonatomic, retain) AudioPlayer *audioPlayer;
@property (nonatomic, retain) NSArray *sourceList;
@property (nonatomic, retain) Listener *activeListener;
@property int maxSources;
@property float maxDistance;
@property BOOL tracking;
@property BOOL isPlaying;

-(id)initEnvironmentWithCategory:(NSString *)category;
-(void)updateListenerHeading:(CLHeading *)newListenerHeading;
-(void)updateSourceGains:(CLHeading *)newListenerHeading;
-(void)updateSourceLocations:(CLLocation *)newListenerLocation;
-(NSArray *)generateSourcesForEnvironment;
-(void)cleanUpOpenAL;
-(float)gaussianBellCurve:(float)difference;
-(NSString *)getClosestPointName;
-(float)getClosestPointDistance:(float)userLatitude withLon:(float)userLongtitude;

@end
