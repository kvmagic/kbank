//
//  ViewController.h
//  kbang
//
//  Created by Kittidech Vongsak on 7/17/16.
//  Copyright © 2016 Kittidech Vongsak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmViewController.h"

@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *fromCollectionView;
@property(weak,nonatomic)IBOutlet UIPageControl *fromPageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *toCollectionView;
@property(weak,nonatomic)IBOutlet UIPageControl *toPageControl;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;

@property (strong, nonatomic) ConfirmViewController * confirmViewController;

- (IBAction)GotoConfirm:(id)sender;

@end

