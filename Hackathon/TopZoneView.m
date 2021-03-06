//
//  TopZoneView.m
//  demoPolling
//
//  Created by Kunal Chelani on 5/10/15.
//  Copyright (c) 2015 Kunal Chelani. All rights reserved.
//

#import "TopZoneView.h"
#import "TopZoneCollectionViewCell.h"
#import "Prefix.pch"
#import "HackathonAppManager.h"
@implementation TopZoneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) initWithFrame: (CGRect)frame andItems:(NSArray *)productArray
{
    self=[super initWithFrame:frame];
    if (self) {
        self.noOfItems=productArray.count;
        self.productsArray=productArray;
        [self initCollectionView];
        [self initPageControl];
    }
    return self;
}

-(id) initWithFrame: (CGRect)frame andProduct:(Product*)product
{
    self=[super initWithFrame:frame];
    if (self) {
        self.product=product;
        self.noOfItems=3;
        [self initCollectionView];
        [self initPageControl];
    }
    return self;
}


-(void) initCollectionView
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.topZoneCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    [self.topZoneCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.topZoneCollectionView.delegate=self;
    self.topZoneCollectionView.dataSource=self;
    self.topZoneCollectionView.backgroundColor=[UIColor whiteColor];
    self.topZoneCollectionView.showsHorizontalScrollIndicator = NO;
    self.topZoneCollectionView.pagingEnabled = YES;
    [self.topZoneCollectionView registerNib:[UINib nibWithNibName:@"TopZoneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TopZoneCollectionViewCell"];
    [self addSubview:self.topZoneCollectionView];
}

-(void) initPageControl
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    // Set up the page control
    CGRect frame = CGRectMake(0, h - 60, w, 60);
    self.pageControl = [[UIPageControl alloc]
                        initWithFrame:frame
                        ];
    
    // Add a target that will be invoked when the page control is
    // changed by tapping on it
    [self.pageControl
     addTarget:self
     action:@selector(pageControlChanged:)
     forControlEvents:UIControlEventValueChanged
     ];
    
    // Set the number of pages to the number of pages in the paged interface
    // and let the height flex so that it sits nicely in its frame
//    self.pageControl.numberOfPages = self.productsArray.count;
    self.pageControl.numberOfPages = 3;
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = RGBA(51, 73, 255, 1.0);
    [self addSubview:self.pageControl];
}

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.topZoneCollectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.topZoneCollectionView setContentOffset:scrollTo animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.topZoneCollectionView.frame.size.width;
    self.pageControl.currentPage = self.topZoneCollectionView.contentOffset.x / pageWidth;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return  self.productsArray.count;
    return 3;
}

- (UIViewController *)getViewController {
    UIResponder *nextResponderView = [self nextResponder];
    while (![nextResponderView isKindOfClass:[UIViewController class]]) {
        nextResponderView = [nextResponderView nextResponder];
        if (nil == nextResponderView) {
            break;
        }
    }
    return (UIViewController *)nextResponderView;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}




- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


/*
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath;
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath; // called when the user taps on an already-selected item in multi-select mode
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
 
 - (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
 - (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
 */

// Method to Overrite
- (TopZoneCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopZoneCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"TopZoneCollectionViewCell"
                                              forIndexPath:indexPath];//    [cell setBackgroundColor:[UIColor redColor]];
//    [cell bindItemData:[self.productsArray objectAtIndex:indexPath.row]];
    cell.product=self.product;
    if (indexPath.row==0) {
        [cell bindItemData:self.product];
        
        if (self.product.imagesArray.count>0) {
//            [(TopZoneCollectionViewCell*)cell setBgImageView:[self.product.imagesArray objectAtIndex:0]];
            [(TopZoneCollectionViewCell*)cell bindActualImageFor:[self.product.imagesArray objectAtIndex:0]];
            
        }
        else
            [cell bindImageFor:self.product.img1];
    }
    else if (indexPath.row==1) {
        [cell bindItemData:self.product];
        if (self.product.imagesArray.count>1) {
            [(TopZoneCollectionViewCell*)cell bindActualImageFor:[self.product.imagesArray objectAtIndex:1]];
        }
        else
            [cell bindImageFor:self.product.img2];
    }
    else if (indexPath.row==2) {
        [cell bindItemData:self.product];
        if (self.product.imagesArray.count>2) {
            [(TopZoneCollectionViewCell*)cell bindActualImageFor:[self.product.imagesArray objectAtIndex:2]];
        }
        else
            [cell bindImageFor:self.product.img3];
    }   if([[HackathonAppManager sharedInstance]productExist:[NSNumber numberWithInteger:self.product.prodId]]){
        [cell.favButtonTapped setBackgroundImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
        [cell.favButtonTapped setBackgroundImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateHighlighted];
    }
    else{
        [cell.favButtonTapped setBackgroundImage:[UIImage imageNamed:@"unFav.png"] forState:UIControlStateNormal];
        [cell.favButtonTapped setBackgroundImage:[UIImage imageNamed:@"unFav.png"] forState:UIControlStateHighlighted];
    }
    return cell;
}

@end
