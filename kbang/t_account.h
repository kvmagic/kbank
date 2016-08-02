#import <Foundation/Foundation.h>
@import UIKit;
@interface t_account : NSObject
@property int ID;
@property (retain,nonatomic) NSString * VAR_NAME;
@property (retain,nonatomic) NSString * VAR_AC_NO;
@property (retain,nonatomic) NSString * VAR_AC_NO_ORG;
@property (retain,nonatomic) NSString * VAR_BANK;
@property (retain,nonatomic) NSString * VAR_BRANCH;
@property double NUM_AMOUNT;
@property (retain,nonatomic) NSString * CHAR_STATUS;
@property (retain,nonatomic) NSDate * DTM_CREATED;
@property double NUM_CREATED_BY;
@property (retain,nonatomic) NSDate * DTM_MODIFIED;
@property double NUM_MODIFIED_BY;
@property (retain,nonatomic) NSString * VAR_DESCRIPTION;
@property bool IS_OWNER;
@property double NUM_SEQUENCE;
@property (retain,nonatomic) NSString * VAR_SURNAME;
-(id)initWithID:(int)_id VAR_NAME:(NSString *)_var_name VAR_AC_NO:(NSString *)_var_ac_no VAR_BANK:(NSString *)_var_bank VAR_BRANCH:(NSString *)_var_branch NUM_AMOUNT:(double)_num_amount CHAR_STATUS:(NSString *)_char_status DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by DTM_MODIFIED:(NSDate *)_dtm_modified NUM_MODIFIED_BY:(double)_num_modified_by VAR_DESCRIPTION:(NSString *)_var_description IS_OWNER:(bool)_is_owner NUM_SEQUENCE:(double)_num_sequence VAR_SURNAME:(NSString *)_var_surname ;
-(NSMutableArray*)Select:(int)_isowner;
-(t_account *) SelectByID:(int)_id ;
-(NSString *) DeleteByID:(int)_id ;
-(NSString *) InsertVAR_NAME:(NSString *)_var_name VAR_AC_NO:(NSString *)_var_ac_no VAR_BANK:(NSString *)_var_bank VAR_BRANCH:(NSString *)_var_branch NUM_AMOUNT:(double)_num_amount CHAR_STATUS:(NSString *)_char_status DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by DTM_MODIFIED:(NSDate *)_dtm_modified NUM_MODIFIED_BY:(double)_num_modified_by VAR_DESCRIPTION:(NSString *)_var_description IS_OWNER:(bool)_is_owner NUM_SEQUENCE:(double)_num_sequence VAR_SURNAME:(NSString *)_var_surname ;
-(NSString *) UpdateByID:(int)_id VAR_NAME:(NSString *)_var_name VAR_AC_NO:(NSString *)_var_ac_no VAR_BANK:(NSString *)_var_bank VAR_BRANCH:(NSString *)_var_branch NUM_AMOUNT:(double)_num_amount CHAR_STATUS:(NSString *)_char_status DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by DTM_MODIFIED:(NSDate *)_dtm_modified NUM_MODIFIED_BY:(double)_num_modified_by VAR_DESCRIPTION:(NSString *)_var_description IS_OWNER:(bool)_is_owner NUM_SEQUENCE:(double)_num_sequence VAR_SURNAME:(NSString *)_var_surname ;


-(NSString *) UpdateByID:(int)_id NUM_AMOUNT:(double)_num_amount NUM_CREATED_BY:(double)_num_created_by NUM_MODIFIED_BY:(double)_num_modified_by NUM_SEQUENCE:(double)_num_sequence ;

-(NSString *) UpdateByID:(NSMutableArray*)accounts CurrentDate:(NSDate**)currentDate LoginID:(long)loginID Amount:(double)amount Fee:(double)fee RecordNo:(int*)recordNo;
@end
