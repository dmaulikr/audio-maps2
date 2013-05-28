//
//  Source.h
//  AudioMaps
//
//  Created by Brent Shadel on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "OpenAL/al.h"
#include "OpenAL/alc.h"


@interface Source : NSObject {
	
}

@property ALuint sourceID;
@property float xPos;
@property float zPos;
@property float gainScale;


-(id)initSourceWithID:(ALuint)newSourceID;
-(void)updateGainScale:(float)newGainScale;




-(id)initSource;

@end
