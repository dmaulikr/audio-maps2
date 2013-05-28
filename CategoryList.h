//
//  CategoryList.h
//  AudioMaps
//
//  Created by Brent Shadel on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoryList : NSObject {
	NSArray *categoryArray;
}

-(NSUInteger)count;
-(NSString *)categoryAtIndex:(NSUInteger)index;

@end
