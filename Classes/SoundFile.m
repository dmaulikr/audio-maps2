//
//  SoundFile.m
//  AudioMaps
//
//  Created by Brent Shadel on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundFile.h"


@implementation SoundFile

@synthesize bufferList, fileID, fileName, fileSize, bufferIndex, loops;


-(id)initWithFile:(NSString *)filePath
{
	if (self = [super init])
	{
		self.fileName = filePath;
		self.fileID = [self openAudioFile:filePath];
		self.fileSize = [self audioFileSize:self.fileID];
		self.bufferIndex = 0;
		self.loops = YES;
		
		NSLog(@"building soundfile <%@> for point", [fileName lastPathComponent]);
		
		// create bufferList
		NSMutableArray *tempList = [NSMutableArray array];
		int i;
		for (i = 0; i < NUM_BUFFERS; i++)
		{
			NSUInteger bufferID;
			alGenBuffers(1, &bufferID);
			NSLog(@"building buffer <%d> for soundfile", bufferID);
			[tempList addObject:[NSNumber numberWithUnsignedInt:bufferID]];
		}
		self.bufferList = tempList;
		
		AudioFileClose(fileID);
		
	}
	
	return self;
}


-(AudioFileID)openAudioFile:(NSString *)filePath
{
	AudioFileID outAFID;
	
	NSURL *afURL = [NSURL fileURLWithPath:filePath];
	
	#if TARGET_OS_IPHONE
	OSStatus result = AudioFileOpenURL((CFURLRef)afURL, kAudioFileReadPermission, 0, &outAFID);
	
	#else
	OSStatus result = AudioFileOpenURL((CFURLRef)afUrl, fsRdPerm, 0, &outAFID);

	#endif
	if (result != 0) NSLog(@"cannot open file: %@",filePath);
	return outAFID;
}


-(UInt32)audioFileSize:(AudioFileID)fileDescriptor
{
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(UInt64);
	OSStatus result = AudioFileGetProperty(fileDescriptor, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if (result != 0) NSLog(@"cannot find file size");
	return (UInt32)outDataSize;
}


-(void)dealloc
{
	[bufferList release], bufferList = nil;
	[fileName release], fileName = nil;
	[super dealloc];
}

@end
