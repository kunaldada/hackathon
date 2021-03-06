//
//  ProductDetailViewController.h
//  ImagePickerProject
//
//  Created by Kunal Chelani on 10/12/15.
//  Copyright © 2015 til. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailViewController : UIViewController
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProduct:(Product *)product;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (weak,nonatomic) Product *product;
@property (weak, nonatomic) IBOutlet UIButton *buyBtnPressed;
@property (strong, nonatomic) NSString *btnTitle;

@end
