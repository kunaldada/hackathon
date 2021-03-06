//
//  WishViewController.m
//  Hackathon
//
//  Created by Sanchit Kumar Singh on 10/9/15.
//  Copyright (c) 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "WishViewController.h"
#import "BaseTableView.h"
#import "ProductData.h"
#import "AddWishViewController.h"
#import "CollectionViewCell.h"
#import "Prefix.pch"
#import "ProductDetailViewController.h"
#import "HackathonAppManager.h"
#define SPACING 10.0
@interface WishViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    BaseTableView *wishTableView;
}
@end

@implementation WishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ProductData *prodData = [[ProductData alloc] init];
    [self showResponsesCollectionView];
//    [prodData fetchDataFor:@"Clothing" withSuccess:^(NSMutableArray *data) {
//        
//        self.dataArray = data;
//    } failure:^(NSError *error) {
//        
//    }];
    [prodData fetchWishDataWithSuccess:^(NSMutableArray *data) {
        self.dataArray = data;
    } failure:^(NSError *error) {
        
    }];
    wishTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 120, getScreenWidth(), getScreenHeight()-120-50) andProductsArray:nil];
    wishTableView.separatorColor = [UIColor clearColor];
    wishTableView.backgroundColor=RGBA(244, 245, 244, 1);
    self.view.backgroundColor=RGBA(244, 245, 244, 1);
    [self.view addSubview:wishTableView];
    [self.addNewWishBtn.layer setBorderColor:RGBA(217, 218, 216, 1).CGColor];
    [self.addNewWishBtn.layer setBorderWidth:1.0];
    [self.addNewWishBtn.layer setCornerRadius:5.0f];
    [self.addNewWishBtn setBackgroundColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view.
}

-(void) adjustFrames{
    self.topSegmentControl.frame=CGRectMake((getScreenWidth()-139)*0.5, 78, 139, 29);
    
    if ([HackathonAppManager sharedInstance].appUserType==kSeller) {
        self.addNewWishBtn.frame = CGRectMake(16, getOriginY(self.topSegmentControl)+getHeight(self.topSegmentControl)+14, getScreenWidth()-32, 0);
        self.addNewWishBtn.hidden=YES;
        self.addIcon.hidden=YES;
        int ycord = getOriginY(self.topSegmentControl)+getHeight(self.topSegmentControl)+14;
        self.responsesCollectionView.frame=CGRectMake(0, ycord, getScreenWidth(), getScreenHeight()-ycord-50);
        
    }
    else{
        self.addNewWishBtn.frame = CGRectMake(16, getOriginY(self.topSegmentControl)+getHeight(self.topSegmentControl)+14, getScreenWidth()-32, 30);
        self.addIcon.frame = CGRectMake(45, getOriginY(self.addNewWishBtn)+3, 30, 25);
        
        self.addNewWishBtn.hidden=NO;
        self.addIcon.hidden=NO;
        int ycord = getOriginY(self.addNewWishBtn)+getHeight(self.addNewWishBtn)+14;
        self.responsesCollectionView.frame=CGRectMake(0, getOriginY(self.addNewWishBtn)+getHeight(self.addNewWishBtn)+14, getScreenWidth(), getScreenHeight()-ycord-50);
        
    }
    self.topSegmentControl.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated{
    [self doNecessaryActions];
    [self adjustFrames];

}
- (IBAction)segmentValChanged:(id)sender {
    
    [self doNecessaryActions];
    [self adjustFrames];
}

-(void) doNecessaryActions{
    
    if (self.topSegmentControl.selectedSegmentIndex==0) {
        self.addNewWishBtn.hidden=NO;
        self.responsesCollectionView.hidden=NO;
        wishTableView.hidden=YES;
    }
    else{
        self.addNewWishBtn.hidden=YES;
        self.responsesCollectionView.hidden=YES;
        ProductData *prodData = [[ProductData alloc] init];

        [prodData fetchFavoritesWithSuccess:^(NSMutableArray *data) {
            wishTableView.productArray=data;
            [wishTableView reloadData];
        } failure:^(NSError *error) {
            
        }];
        
        wishTableView.hidden=NO;
    }

    
}


- (IBAction)addNewWishBtn:(id)sender {
    
    AddWishViewController *wishCont = [[AddWishViewController alloc] initWithNibName:@"AddWishViewController" bundle:nil];
    [self.navigationController pushViewController:wishCont animated:YES];
    
}



#pragma mark UICollectionViewMethods


-(void) showResponsesCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    NSInteger width = (getScreenWidth()-3*SPACING)*0.5;
    layout.itemSize = CGSizeMake(width, width);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = SPACING;
    layout.minimumInteritemSpacing = SPACING;
    self.responsesCollectionView.collectionViewLayout=layout;
    self.responsesCollectionView.backgroundColor=RGBA(244, 245, 244, 1);
    [self.responsesCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    [cell bindDataFor:[self.dataArray objectAtIndex:indexPath.row]];
    cell.backgroundColor=RGBA(244, 245, 244, 1);
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SPACING, SPACING, SPACING, SPACING);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil andProduct:[self.dataArray objectAtIndex:indexPath.row]];
    if ([HackathonAppManager sharedInstance].appUserType==kSeller) {
        vc.btnTitle=@"Respond";
    }
    else{
    }

    [self.navigationController pushViewController:vc animated:YES];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
