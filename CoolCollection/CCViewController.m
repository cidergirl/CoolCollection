//
//  CCViewController.m
//  CoolCollection
//
//  Created by Hagit Shemer on 11/17/13.
//
//

#import "CCViewController.h"

@interface CCViewController ()

@end



@implementation CCViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.bottomCollectionView registerNib:[UINib nibWithNibName:@"CCBottomCell" bundle:[NSBundle mainBundle]]
             forCellWithReuseIdentifier:@"CCBottomCell"];
    [self.topCollectionView registerNib:[UINib nibWithNibName:@"CCTopCell" bundle:[NSBundle mainBundle]]
             forCellWithReuseIdentifier:@"CCTopCell"];
    
    [self.topCollectionView registerNib:[UINib nibWithNibName:@"CCCollectionTransparentHeader" bundle:[NSBundle mainBundle]]
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:@"CCCollectionTransparentHeader"];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.bottomCollectionView) {
        return 4;
    }
    else { // self.topCollectionView
        return 30;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.bottomCollectionView) {
        UICollectionViewCell *cell = [self.bottomCollectionView dequeueReusableCellWithReuseIdentifier:@"CCBottomCell"
                                                                                          forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:(indexPath.row + 1)/5.0 green:(indexPath.row + 1)/5.0 blue:(indexPath.row + 1)/5.0 alpha:1];
        return cell;
    }
    else { // self.topCollectionView
        UICollectionViewCell *cell = [self.topCollectionView dequeueReusableCellWithReuseIdentifier:@"CCTopCell"
                                                                                          forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:indexPath.row/30.0 green:indexPath.row/30.0 blue:0.5 alpha:1];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerTransparentView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                             withReuseIdentifier:@"CCCollectionTransparentHeader"
                                                                                                    forIndexPath:indexPath];
        if (![headerTransparentView gestureRecognizers].count) {
            UISwipeGestureRecognizer *swipeLeftRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                       action:@selector(swipeLeftGesture:)];
            swipeLeftRecongnizer.direction = UISwipeGestureRecognizerDirectionLeft;
            [headerTransparentView addGestureRecognizer:swipeLeftRecongnizer];
            
            UISwipeGestureRecognizer *swipeRightRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                        action:@selector(swipeRightGesture:)];
            swipeRightRecongnizer.direction = UISwipeGestureRecognizerDirectionRight;
            [headerTransparentView addGestureRecognizer:swipeRightRecongnizer];
            
            UITapGestureRecognizer *tapRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(tapGesture:)];
            [headerTransparentView addGestureRecognizer:tapRecongnizer];
        }
        return headerTransparentView;
    }
    return nil;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.bottomCollectionView) {
        NSLog(@"==>> bottom cell selected");
    }
    else { // self.topCollectionView
        NSLog(@"==>> top cell selected");
    }
}


#pragma mark - Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Private

- (void)swipeLeftGesture:(UISwipeGestureRecognizer *)recognizer
{
    NSIndexPath *indexPath = [self.bottomCollectionView indexPathForCell:[[self.bottomCollectionView visibleCells] objectAtIndex:0]];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row+1) inSection:indexPath.section];
    
    if (newIndexPath.row < [self collectionView:self.bottomCollectionView numberOfItemsInSection:indexPath.section]) {
        NSLog(@"=> left scrolling to index path %@", newIndexPath);
        [self.bottomCollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

- (void)swipeRightGesture:(UISwipeGestureRecognizer *)recognizer
{
    NSIndexPath *indexPath = [self.bottomCollectionView indexPathForCell:[[self.bottomCollectionView visibleCells] objectAtIndex:0]];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row-1) inSection:indexPath.section];
    
    if (newIndexPath.row >= 0) {
        NSLog(@"=> right scrolling to index path %@", newIndexPath);
        [self.bottomCollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    NSIndexPath *visibleIndex = [[self.bottomCollectionView indexPathsForVisibleItems] objectAtIndex:0];
    [self.bottomCollectionView selectItemAtIndexPath:visibleIndex animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self collectionView:self.bottomCollectionView didSelectItemAtIndexPath:visibleIndex];
}

@end
