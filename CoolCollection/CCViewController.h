//
//  CCViewController.h
//  CoolCollection
//
//  Created by Hagit Shemer on 11/17/13.
//
//

#import <UIKit/UIKit.h>

@interface CCViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,weak) IBOutlet UICollectionView *bottomCollectionView;
@property (nonatomic,weak) IBOutlet UICollectionView *topCollectionView;


@end
