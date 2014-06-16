//
//  YelpObject.m
//  Yelp
//
//  Created by Theofanis Pantelides on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpObject.h"

@implementation YelpObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        //NSLog(@"dic: %@", dictionary);
        
        self.image = dictionary[@"image_url"];
        self.name = dictionary[@"name"];
        //self.distance = dictionary[@""];
        self.stars = dictionary[@"rating_img_url"];
        self.reviews = dictionary[@"review_count"];
        //self.price = dictionary[@""];
        self.address = dictionary[@"location"][@"display_address"];
        //self.categories = dictionary[@""];
        
    }
    
    return self;
}

@end
