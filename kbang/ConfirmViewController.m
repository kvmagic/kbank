//
//  ConfirmViewController.m
//  kbang
//
//  Created by Kittidech Vongsak on 7/17/16.
//  Copyright © 2016 Kittidech Vongsak. All rights reserved.
//

#import "ConfirmViewController.h"
#import "Vars.h"
#import "Util.h"
#import "t_account.h"

@interface ConfirmViewController ()
{
    double fee;
    long loginID;
}
@end

@implementation ConfirmViewController
@synthesize lblAmount,lblToBank,lblFee,lblToName,lblFromBank,lblFromName,lblToAccount,lblFromAccount,fromAccountSelected,toAccountSelected,amount;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(GotoBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title =NSLocalizedString(@"Confirm", @"Confirm");
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    fee = 25;
    loginID = 1;
    
    lblFromName.text =[NSString stringWithFormat:@"%@ %@",fromAccountSelected.VAR_NAME,fromAccountSelected.VAR_SURNAME];
    lblFromAccount.text = fromAccountSelected.VAR_AC_NO;
    lblFromBank.text=[NSString stringWithFormat:@"%@ %@",fromAccountSelected.VAR_BANK,fromAccountSelected.VAR_BRANCH];
    
    lblToName.text =[NSString stringWithFormat:@"%@ %@",toAccountSelected.VAR_NAME,toAccountSelected.VAR_SURNAME];
    lblToAccount.text = toAccountSelected.VAR_AC_NO;
    lblToBank.text=[NSString stringWithFormat:@"%@ %@",toAccountSelected.VAR_BANK,toAccountSelected.VAR_BRANCH];
    
    lblFee.text =[numberFormatter stringFromNumber:[NSNumber numberWithFloat:fee]];
    lblAmount.text =[numberFormatter stringFromNumber:[NSNumber numberWithFloat:amount]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)GotoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)GotoShare:(id)sender {
    
    NSMutableArray * accounts = [[NSMutableArray alloc]init];
    fromAccountSelected.NUM_AMOUNT=fromAccountSelected.NUM_AMOUNT-fee-amount;
    fromAccountSelected.NUM_MODIFIED_BY=loginID;
    fromAccountSelected.NUM_CREATED_BY=loginID;
    
    toAccountSelected.NUM_AMOUNT=toAccountSelected.NUM_AMOUNT+amount;
    toAccountSelected.NUM_MODIFIED_BY=loginID;
    toAccountSelected.NUM_CREATED_BY=loginID;
    
    [accounts addObject:fromAccountSelected];
    [accounts addObject:toAccountSelected];
    
    NSDate * transactionDate;
    int recordNo;
    
    t_account* account = [[t_account alloc]init];
    NSString* errorString =   [account UpdateByID:accounts CurrentDate:&transactionDate LoginID:loginID Amount:amount Fee:fee RecordNo:&recordNo];
    if ([errorString isEqualToString:errorString]) {
        
        self.shareViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
        self.shareViewController.fromAccountSelected = fromAccountSelected;
        self.shareViewController.toAccountSelected = toAccountSelected;
        self.shareViewController.amount = amount;
        self.shareViewController.fee = fee;
        self.shareViewController.transactionDate = transactionDate;
        self.shareViewController.recordNo = recordNo;
        [self.navigationController pushViewController:self.shareViewController animated:YES];
        
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}
@end
