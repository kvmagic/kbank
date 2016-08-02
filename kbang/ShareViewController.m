//
//  ShareViewController.m
//  kbang
//
//  Created by Kittidech Vongsak on 7/17/16.
//  Copyright © 2016 Kittidech Vongsak. All rights reserved.
//

#import "ShareViewController.h"
#import "Util.h"

@interface ShareViewController ()
{
    UIImage *originalImage;
}
@end

@implementation ShareViewController
@synthesize lblAmount,lblFee,lblFromAccount,lblToAccount,lblRecordNo,lblTranDate,viewTran,transactionDate,recordNo,amount,fee,fromAccountSelected,toAccountSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(GotoHome:)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = homeButton;
    self.navigationItem.title =NSLocalizedString(@"E-Slip", @"E-Slip");
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[dateFormat stringFromDate:transactionDate];
    lblTranDate.text=dateString;

    lblRecordNo.text = [NSString stringWithFormat:@"%d",recordNo];
    lblFromAccount.text =fromAccountSelected.VAR_AC_NO;
    lblToAccount.text =toAccountSelected.VAR_AC_NO;
    lblFee.text =[numberFormatter stringFromNumber:[NSNumber numberWithFloat:fee]];
    lblAmount.text =[numberFormatter stringFromNumber:[NSNumber numberWithFloat:amount]];
    
    originalImage= [Util getUIImageFromThisUIView:viewTran];
    UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil , nil);
    /*UIImage *originalImage= [Util.getUIImageFromThisUIView:self.view];
     
     NSString *text = @"How to add Facebook and Twitter sharing to an iOS app";
     NSURL *url = [NSURL URLWithString:@""];
     
     UIActivityViewController *controller =[[UIActivityViewController alloc]initWithActivityItems:@[text, originalImage]
     applicationActivities:nil];
     
     controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
     UIActivityTypeMessage,
     UIActivityTypeMail,
     UIActivityTypePrint,
     UIActivityTypeCopyToPasteboard,
     UIActivityTypeAssignToContact,
     UIActivityTypeSaveToCameraRoll,
     UIActivityTypeAddToReadingList,
     UIActivityTypePostToFlickr,
     UIActivityTypePostToVimeo,
     UIActivityTypePostToTencentWeibo,
     UIActivityTypeAirDrop];
     
     [self presentViewController:controller animated:YES completion:nil];
     
     UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil , nil);*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GotoHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (IBAction)GotoSharePhoto:(id)sender {
    
     NSString *text = @"E-Slip sharing to an iOS app";
     //NSURL *url = [NSURL URLWithString:@"http://www.kasikornbank.com/TH/Pages/Default.aspx"];

     UIActivityViewController *controller =[[UIActivityViewController alloc]initWithActivityItems:@[text, originalImage]
     applicationActivities:nil];
     
     controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
     UIActivityTypeMessage,
     UIActivityTypeMail,
     UIActivityTypePrint,
     UIActivityTypeCopyToPasteboard,
     UIActivityTypeAssignToContact,
     UIActivityTypeSaveToCameraRoll,
     UIActivityTypeAddToReadingList,
     UIActivityTypePostToFlickr,
     UIActivityTypePostToVimeo,
     UIActivityTypePostToTencentWeibo,
     UIActivityTypeAirDrop];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    else {
        
        controller.popoverPresentationController.sourceView = self.view;
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
}
@end
