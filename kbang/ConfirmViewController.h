//
//  ConfirmViewController.h
//  kbang
//
//  Created by Kittidech Vongsak on 7/17/16.
//  Copyright © 2016 Kittidech Vongsak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"
#import "t_account.h"

@interface ConfirmViewController : UIViewController
@property (strong, nonatomic) ShareViewController * shareViewController;
@property (weak, nonatomic) IBOutlet UILabel *lblFromName;
@property (weak, nonatomic) IBOutlet UILabel *lblFromBank;
@property (weak, nonatomic) IBOutlet UILabel *lblFromAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblToName;
@property (weak, nonatomic) IBOutlet UILabel *lblToAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblToBank;
@property (weak, nonatomic) IBOutlet UILabel *lblFee;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;

@property t_account *fromAccountSelected;
@property t_account *toAccountSelected;
@property double amount;

- (IBAction)GotoShare:(id)sender;


@end
