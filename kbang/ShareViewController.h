//
//  ShareViewController.h
//  kbang
//
//  Created by Kittidech Vongsak on 7/17/16.
//  Copyright © 2016 Kittidech Vongsak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "t_account.h"

@interface ShareViewController : UIViewController

@property t_account *fromAccountSelected;
@property t_account *toAccountSelected;
@property double amount;
@property double fee;
@property NSDate * transactionDate;
@property int recordNo;

@property (weak, nonatomic) IBOutlet UIView *viewTran;
@property (weak, nonatomic) IBOutlet UILabel *lblTranDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRecordNo;
@property (weak, nonatomic) IBOutlet UILabel *lblFromAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblToAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblFee;
- (IBAction)GotoSharePhoto:(id)sender;

@end
