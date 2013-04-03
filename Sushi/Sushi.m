//
//  Sushi.m
//  Sushi
//
//  Created by Tianyu Liu on 3/31/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import "Sushi.h"

@implementation Sushi

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithName:(NSString *)aName
       description:(NSString *)aDescription
         imageName:(NSString *)aImage{
    self = [super init];
    if(self) {
        self.name = aName;
        self.description = aDescription;
        self.imageName = aImage;
    }
    return self;
}

@end
