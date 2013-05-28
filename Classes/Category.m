//
//  Category.m
//  AudioMaps
//
//  Created by Brent Shadel on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Category.h"
#import "PointOfInterest.h"
#import "Source.h"
#import "SoundFile.h"


@implementation Category

@synthesize pointArray, sorted;

-(id)initCategoryWithCategory:(NSString *)categoryName
{
	NSLog(@"building category <%@> for environment", categoryName);
	pointArray = [self generatePointsForCategory:categoryName];
	self.sorted = 0;
	
	return self;
}


-(NSMutableArray *)generatePointsForCategory:(NSString *)categoryName
{
	NSArray *fileNames = [[NSBundle mainBundle] pathsForResourcesOfType:@".txt" inDirectory:[NSString stringWithFormat:@"categories/%@",categoryName]];
	NSMutableArray *temp = [NSMutableArray array];
	for (NSString *filePath in fileNames)
	{
		PointOfInterest *point = [[PointOfInterest alloc] initWithFile:filePath];
		[temp addObject:point];
		[point release];
	}
	
	return [[NSMutableArray alloc] initWithArray:temp];
}


-(PointOfInterest *)getPointAtIndex:(NSUInteger)index
{
	return [pointArray objectAtIndex:index];
}


-(NSUInteger)count
{
	return [pointArray count];
}

-(int)sortPointArray:(int)index
{
	NSLog(@"sorting");
	int i = index;
	
	if (i < [self.pointArray count] - 1)
	{
		PointOfInterest *point1 = [self.pointArray objectAtIndex:i];
		PointOfInterest *point2 = [self.pointArray objectAtIndex:i+1];
		
		float test1 = point1.currentDistance;
		float test2 = point2.currentDistance;
		
		if (test1 > test2)
		{
			NSLog(@"exchanging order");
			[self.pointArray exchangeObjectAtIndex:i withObjectAtIndex:i+1];
			if (i > 0) i--;
			self.sorted = 1;
		}
		else
		{
			NSLog(@"proceeding");
			i++;
		}
		[self sortPointArray:i];
	}
	
	return self.sorted;
}

-(void) dealloc
{
	[pointArray release], pointArray = nil;
	[super dealloc];
}

@end
