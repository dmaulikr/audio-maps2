//
//  SoundFile.h
//  AudioMaps
//
//  Created by Brent Shadel on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "OpenAL/al.h"
#include "OpenAL/alc.h"
#include "AudioToolbox/AudioToolbox.h"
#include "Constants.h"


@interface SoundFile : NSObject {

}

@property (nonatomic, retain) NSArray *bufferList;
@property (nonatomic, retain) NSString *fileName;
@property AudioFileID fileID;
@property UInt32 fileSize;
@property UInt32 bufferIndex;
@property BOOL loops;


-(id)initWithFile:(NSString *)fileURL;
-(AudioFileID)openAudioFile:(NSString *)filePath;
-(UInt32)audioFileSize:(AudioFileID)fileDescriptor;


@end
