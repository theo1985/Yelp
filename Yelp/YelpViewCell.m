//
//  YelpViewCell.m
//  Yelp
//
//  Created by Theofanis Pantelides on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpViewCell.h"

@implementation YelpViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setYelpObj:(YelpObject *)yObject
{
    self.lblName.text  = yObject.name;
    
    NSLog(@"the: %@", yObject.name);
    
    //self.yelpObj = yObject;
}

@end
