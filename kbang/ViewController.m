//
//  ViewController.m
//  kbang
//
//  Created by Kittidech Vongsak on 7/17/16.
//  Copyright © 2016 Kittidech Vongsak. All rights reserved.
//

#import "ViewController.h"
#import "Vars.h"
#import "FromCollectionViewCell.h"
#import "ToCollectionViewCell.h"
#import "Util.h"
#import "t_account.h"

@interface ViewController ()
{
    NSMutableArray * fromAccounts;
    NSMutableArray * toAccounts;
    
    t_account *fromAccountSelected;
    t_account *toAccountSelected;
}
@end

@implementation ViewController
@synthesize txtAmount,fromPageControl,toPageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =NSLocalizedString(@"KBank", @"KBank");
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    txtAmount.placeholder = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:100000]];

    [self.toCollectionView setDelegate:self];
    [self.toCollectionView setDataSource:self];
    [self.fromCollectionView setDelegate:self];
    [self.fromCollectionView setDataSource:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:FALSE];
    
    txtAmount.text=@"";
    
    fromAccounts =  [[t_account alloc]Select:1];
    toAccounts =  [[t_account alloc]Select:0];
    
    [self.toCollectionView reloadData];
    [self.fromCollectionView reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
    [super touchesBegan:touches withEvent:event];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger row=0;
    switch (collectionView.tag) {
        case 0:
            row =fromAccounts.count;
            break;
        case 1:
            row =toAccounts.count;
            break;
    }
    return row;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FromCollectionViewCell *cellFrom;
    ToCollectionViewCell *cellTo;
    long row =(long)indexPath.row;
    switch (collectionView.tag) {
        case 0:
        {
            cellFrom = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
            t_account *fromAccount = [fromAccounts objectAtIndex:row];
            cellFrom.lblName.text = [NSString stringWithFormat:@"%@ %@",fromAccount.VAR_NAME,fromAccount.VAR_SURNAME];
            cellFrom.lblBank.text = [NSString stringWithFormat:@"%@ %@",fromAccount.VAR_BANK,fromAccount.VAR_BRANCH];
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            cellFrom.lblAmount.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:fromAccount.NUM_AMOUNT]];
            
            cellFrom.lblAcNo.text =  fromAccount.VAR_AC_NO;
            
            fromAccountSelected =fromAccount;
            
            if (fromAccounts.count<4) {
                fromPageControl.currentPage = row;
            }else
            {
                fromPageControl.currentPage =(int)floor((double)row/(fromAccounts.count/fromPageControl.numberOfPages));
            }
            return cellFrom;
        }
        case 1:
        {
            cellTo = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
            t_account *toAccount = [toAccounts objectAtIndex:row];
            cellTo.lblName.text = [NSString stringWithFormat:@"%@ %@",toAccount.VAR_NAME,toAccount.VAR_SURNAME];
            cellTo.lblBank.text = [NSString stringWithFormat:@"%@ %@",toAccount.VAR_BANK,toAccount.VAR_BRANCH];
            
            cellTo.lblAcNo.text =  toAccount.VAR_AC_NO;
            
            toAccountSelected =toAccount;
            
            if (toAccounts.count<4) {
                toPageControl.currentPage = row;
            }else
            {
                toPageControl.currentPage =(int)floor((double)row/(toAccounts.count/toPageControl.numberOfPages));
            }
            
            return cellTo;
        }
    }
    return NULL;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:true];
    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GotoConfirm:(id)sender {
    
    if ([txtAmount.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Input" message: [NSString stringWithFormat:@"Please, insert amount."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        double amount = [txtAmount.text doubleValue];
        if ([self PassValidateAmount:amount Account:fromAccountSelected])
        {
            self.confirmViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmViewController"];
            self.confirmViewController.fromAccountSelected = fromAccountSelected;
            self.confirmViewController.toAccountSelected = toAccountSelected;
            self.confirmViewController.amount = amount;
            [self.navigationController pushViewController:self.confirmViewController animated:YES];
        
        }
    }
    
}

- (BOOL)PassValidateAmount:(double)amount Account:(t_account*)account
{
    BOOL passValidate = true;
    UIAlertView *alert;
    if (amount>100000) {
        alert= [[UIAlertView alloc]initWithTitle:@"Over" message: [NSString stringWithFormat:@"Amount limit."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        passValidate = false;
    }else if(amount>account.NUM_AMOUNT)
    {
        alert= [[UIAlertView alloc]initWithTitle:@"Over" message: [NSString stringWithFormat:@"Amount over balance."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        passValidate = false;
    }
    return passValidate;
}

@end
