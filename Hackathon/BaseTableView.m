//
//  BaseTableView.m
//  Hackathon
//
//  Created by Sanchit Kumar Singh on 10/13/15.
//  Copyright (c) 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "BaseTableView.h"
#import "TableViewCell.h"
#import "ProductDetailViewController.h"
#import "HackathonAppManager.h"
#import "Prefix.pch"
#import "WishViewController.h"
#import "WallViewController.h"
#import "SVProgressHUD.h"
@implementation BaseTableView

-(id) initWithFrame:(CGRect)frame andProductsArray:(NSArray*) prodsArray{
    
    self.productArray=prodsArray;
    self.dataSource=self;
    self.delegate=self;
    [self registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    
    return [self initWithFrame:frame];
}



-(UIImage *) resizeImage : (UIImage *)image toSize :(CGSize)rect {
    UIGraphicsBeginImageContextWithOptions(rect, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, rect.width, rect.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return _productArray.count;
//    return 10;

}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    TableViewCell *cell= (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bindDataFor:[_productArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil andProduct:[self.productArray objectAtIndex:indexPath.row]];
    
    if ([self getWallController] && [HackathonAppManager sharedInstance].appUserType==kSeller) {
        vc.btnTitle=@"Respond";
    }
    
    UINavigationController *navCont = [self getViewController];
        if (navCont) {
        [navCont pushViewController:vc animated:YES];
    }
    else{
        [SVProgressHUD dismiss];
    }
}




- (UINavigationController *)getViewController {
    UIResponder *nextResponderView = [self nextResponder];
    while (![nextResponderView isKindOfClass:[UINavigationController class]]) {
        nextResponderView = [nextResponderView nextResponder];
        if (nil == nextResponderView) {
            break;
        }
    }
    return (UINavigationController *)nextResponderView;
}


- (UIViewController *)getWallController {
    UIResponder *nextResponderView = [self nextResponder];
    while (![nextResponderView isKindOfClass:[WallViewController class]]) {
        nextResponderView = [nextResponderView nextResponder];
        if (nil == nextResponderView) {
            break;
        }
    }
    return (UIViewController *)nextResponderView;
}


-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}

@end
