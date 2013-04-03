//
//  Sushi.h
//  Sushi
//
//  Created by Tianyu Liu on 3/31/13.
//  Copyright (c) 2013 Tianyu Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sushi : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *imageName;

- (id)initWithName:(NSString *)aName
       description:(NSString *)aDescription
         imageName:(NSString *)aImageName;

@end
