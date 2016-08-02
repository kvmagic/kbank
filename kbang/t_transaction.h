#import <Foundation/Foundation.h>
@import UIKit;
@interface t_transaction : NSObject
@property int ID;
@property (retain,nonatomic) NSDate * DTM_CREATED;
@property double NUM_CREATED_BY;
@property (retain,nonatomic) NSString * VAR_FROM_AC_NO;
@property (retain,nonatomic) NSString * VAR_TO_AC_NO;
@property double NUM_AMOUNT;
@property (retain,nonatomic) NSString * CHAR_TYPE;
@property double NUM_FEE;
@property (retain,nonatomic) NSString * VAR_LOCATION;
-(id)initWithID:(int)_id DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by VAR_FROM_AC_NO:(NSString *)_var_from_ac_no VAR_TO_AC_NO:(NSString *)_var_to_ac_no NUM_AMOUNT:(double)_num_amount CHAR_TYPE:(NSString *)_char_type NUM_FEE:(double)_num_fee VAR_LOCATION:(NSString *)_var_location ;
-(NSMutableArray*)Select;
-(t_transaction *) SelectByID:(int)_id ;
-(NSString *) DeleteByID:(int)_id ;
-(NSString *) InsertDTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by VAR_FROM_AC_NO:(NSString *)_var_from_ac_no VAR_TO_AC_NO:(NSString *)_var_to_ac_no NUM_AMOUNT:(double)_num_amount CHAR_TYPE:(NSString *)_char_type NUM_FEE:(double)_num_fee VAR_LOCATION:(NSString *)_var_location ;
-(NSString *) UpdateByID:(int)_id DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by VAR_FROM_AC_NO:(NSString *)_var_from_ac_no VAR_TO_AC_NO:(NSString *)_var_to_ac_no NUM_AMOUNT:(double)_num_amount CHAR_TYPE:(NSString *)_char_type NUM_FEE:(double)_num_fee VAR_LOCATION:(NSString *)_var_location ;
@end
