//
//  HackathonAppManager.m
//  Hackathon
//
//  Created by Kunal Chelani on 10/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "HackathonAppManager.h"
#import "Archiver.h"
@implementation HackathonAppManager



+ (HackathonAppManager*)sharedInstance {
    static HackathonAppManager *_sharedInstance;
    if(!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
            // Init the dictionary
        });
    }
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

-(id)init
{
    self = [super init];
    self.favIdsArray = [[NSMutableArray alloc]init];
    self.buyerWishes = [Archiver retrieve:@"buyerWishes"];
    if (!self.buyerWishes) {
        self.buyerWishes = [[ProductRepo alloc] init];
    }
    self.sellerResponses = [Archiver retrieve:@"sellerResponses"];
    if (!self.sellerResponses) {
        self.sellerResponses = [[ProductRepo alloc] init];
    }
    return self;
    
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#if (!__has_feature(objc_arc))

- (id)retain {
    
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}



- (id)autorelease {
    return self;
}
#endif


- (NSDictionary *) getObjectFromPlist{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"CategoriesList.plist"];
    NSDictionary *plistData =[NSDictionary dictionaryWithContentsOfFile:finalPath];
    return plistData;
}

-(NSArray*) getSubCategoriesFor:(NSString*) category{
    
    NSDictionary *dict = [self getObjectFromPlist];
    return [dict objectForKey:category];
    
}

-(BOOL) productExist:(NSNumber *)prodId{
    if([self.favIdsArray containsObject:prodId]){
        if([self.favIdsArray indexOfObject:prodId]<[self.favIdsArray count]&&[self.favIdsArray indexOfObject:prodId]>=0){
            return YES;
        }
    }
    return  NO;
}

-(void) removeItemFromFavIdsArray:(NSNumber *)prodId{
    [self.favIdsArray removeObject:prodId];
}

-(void) addItemInFavIdsArray:(NSNumber *)prodId{
    [self.favIdsArray addObject:prodId];
}

-(void) addProduct:(Product*) product{
    
    int max=8000;
    int min=2000;
    
    int randNum = rand() % (max - min) + min; //create the random number.
    self.buyerWishes = [Archiver retrieve:@"buyerWishes"];
    if (!self.buyerWishes) {
        self.buyerWishes = [[ProductRepo alloc] init];
    }
    self.sellerResponses = [Archiver retrieve:@"sellerResponses"];
    if (!self.sellerResponses) {
        self.sellerResponses = [[ProductRepo alloc] init];
    }

    product.prodId = randNum;
    product.seller=@"Sanchit & sons";
    if (self.appUserType==kSeller) {
        [self.sellerResponses.prodsArray addObject:product];
        [Archiver delete:@"sellerResponses"];
        [Archiver persist:self.sellerResponses key:@"sellerResponses"];
    }
    else{
        [self.buyerWishes.prodsArray addObject:product];
        [Archiver delete:@"buyerWishes"];
        [Archiver persist:self.buyerWishes key:@"buyerWishes"];
    }
}

@end
