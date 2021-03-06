//
//  ViewController.m
//  Created by Sanchit Kumar Singh on 10/7/15.
//  Copyright (c) 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "ViewController.h"
#import "WallViewController.h"
#import "BrowseViewController.h"
#import "WishViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *wallTabBarItem = [tabBar.items   objectAtIndex:0];
    UITabBarItem *wishTabBarItem = [tabBar.items objectAtIndex:1];
    UITabBarItem *browseTabBarItem = [tabBar.items objectAtIndex:2];
    UIImage *image = [self resizeImage:[UIImage imageNamed:@"feed.png"] toSize:CGSizeMake(25, 25)];
//    self.navigationController.navigationItem.rightBarButtonItems =self.navItems;
    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wallTabBarItem.image=image;
    image = [self resizeImage:[UIImage imageNamed:@"search.png"] toSize:CGSizeMake(25,25)];
    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wishTabBarItem.image=image;
    image = [self resizeImage:[UIImage imageNamed:@"wish.png"] toSize:CGSizeMake(50, 50)];
    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    browseTabBarItem.image=image;
    
    SWRevealViewController *revealController = self.revealViewController;
    if(revealController){
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
//        self.navigationItem.leftBarButtonItem.title=@"browse";
        image = [self resizeImage:[UIImage imageNamed:@"menu_icon.png"] toSize:CGSizeMake(20, 20)];
        image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationItem.leftBarButtonItem setImage:image];
        [self.navigationItem.leftBarButtonItem setTarget:self.revealViewController];
        [self.navigationItem.leftBarButtonItem setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        revealController.rearViewRevealWidth=150.0f;
    }
    self.title=@"Home";
    [self navItems];
    //wallViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"mc" image:image selectedImage:image];
}

-(UIImage *) resizeImage : (UIImage *)image toSize :(CGSize)rect {
    UIGraphicsBeginImageContextWithOptions(rect, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, rect.width, rect.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) navItems {
    UINavigationItem *navItems = [[UINavigationItem alloc]init];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setBackgroundImage:[UIImage imageNamed:@"Binoculars Filled-32.png"] forState:UIControlStateNormal];
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"More Filled-32.png"] forState:UIControlStateNormal];
    UIBarButtonItem *moreActions = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"Shopping Cart-50.png"] forState:UIControlStateNormal];
    UIBarButtonItem *cart = [[UIBarButtonItem alloc]initWithCustomView:btn2];//    navItems.rightBarButtonItems =
    self.navigationItem.rightBarButtonItems=[[NSArray alloc]initWithObjects:moreActions,searchBtn,cart, nil];
//    return navItems;
}

@end
