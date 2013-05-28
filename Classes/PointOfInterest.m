//
//  Category.m
//  AudioMaps
//
//  Created by Brent Shadel on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PointOfInterest.h"
#import "SoundFile.h"


@implementation PointOfInterest

@synthesize pointName, defaultX, defaultZ, currentX, currentZ, soundFile, activeSource, currentDistance;


-(id)initWithFile:(NSString *)filePath;
{
	if (self = [super init])
	{
		self.pointName = [[filePath lastPathComponent] stringByDeletingPathExtension];
		
		NSLog(@"building point <%@> for category",self.pointName);
		
		NSString *contents = [[NSString alloc] initWithContentsOfFile:filePath];
		NSArray *chunks = [contents componentsSeparatedByString:@":"];
		[contents release], contents = nil;
		self.defaultX = [[chunks objectAtIndex:2] floatValue];
		self.defaultZ = [[chunks objectAtIndex:0] floatValue];
		self.currentX = self.defaultX;
		self.currentZ = self.defaultZ;
		
		NSString *soundFileURL = [NSString stringWithFormat:@"%@.caf",[filePath stringByDeletingPathExtension]];
		SoundFile *tempSoundFile = [[SoundFile alloc] initWithFile:soundFileURL];
		self.soundFile = tempSoundFile;
		[tempSoundFile release], tempSoundFile = nil;
		
		self.currentDistance = 0;
	}
	return self;
}

-(void)dealloc
{
	[pointName release], pointName = nil;
	[soundFile release], soundFile = nil;
	[activeSource release], activeSource = nil;
	[super dealloc];
}
@end
