//
//  Product.m
//  ImagePickerProject
//
//  Created by Kunal Chelani on 10/12/15.
//  Copyright © 2015 til. All rights reserved.
//

#import "Product.h"

@implementation Product


-(instancetype) init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self autoEncodeWithCoder:coder];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        [self autoDecode:coder];
    }
    return self;
}

@end
