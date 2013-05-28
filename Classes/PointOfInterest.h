//
//  Category.h
//  AudioMaps
//
//  Created by Brent Shadel on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Source;
@class SoundFile;

@interface PointOfInterest : NSObject {
}

@property (nonatomic, retain) NSString *pointName;
@property float defaultX;
@property float defaultZ;
@property float currentX;
@property float currentZ;
@property float currentDistance;
@property (nonatomic, retain) SoundFile *soundFile;
@property (nonatomic, retain) Source *activeSource;



-(id)initWithFile:(NSString *)filePath;


@end
