//
//  YelpObject.h
//  Yelp
//
//  Created by Theofanis Pantelides on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpObject : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *stars;
@property (nonatomic, strong) NSString *reviews;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
