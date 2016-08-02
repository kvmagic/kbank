
#import "t_transaction.h"
#import "Util.h"
#import <sqlite3.h>
#import "Vars.h"
@implementation t_transaction
@synthesize ID, DTM_CREATED, NUM_CREATED_BY, VAR_FROM_AC_NO, VAR_TO_AC_NO, NUM_AMOUNT, CHAR_TYPE, NUM_FEE, VAR_LOCATION;
-(id)initWithID:(int)_id DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by VAR_FROM_AC_NO:(NSString *)_var_from_ac_no VAR_TO_AC_NO:(NSString *)_var_to_ac_no NUM_AMOUNT:(double)_num_amount CHAR_TYPE:(NSString *)_char_type NUM_FEE:(double)_num_fee VAR_LOCATION:(NSString *)_var_location 
{
	self = [super init];
	if(self)
	{
		self.ID= _id;
		self.DTM_CREATED= _dtm_created;
		self.NUM_CREATED_BY= _num_created_by;
		self.VAR_FROM_AC_NO= _var_from_ac_no;
		self.VAR_TO_AC_NO= _var_to_ac_no;
		self.NUM_AMOUNT= _num_amount;
		self.CHAR_TYPE= _char_type;
		self.NUM_FEE= _num_fee;
		self.VAR_LOCATION= _var_location;

	}
	return self;
}
-(NSMutableArray *)Select{
	NSMutableArray *datas = [[NSMutableArray alloc]init];
	NSString *file = [Util getWritableDBPath:[Vars GetDBName]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:file];
	if(!success)
	{
		[Util createEditableCopyOfDatabaseIfNeeded:[Vars GetDBName]];
	}
	const char *dbpath = [file UTF8String];
	sqlite3_stmt    *statement;
	sqlite3 *database = NULL;
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat:@"select * from t_transaction order by ID"];
		const char *query_stmt = [querySQL UTF8String];
		if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(statement) == SQLITE_ROW)
			{
				t_transaction  *data = [[t_transaction alloc]init];
				data.ID  = sqlite3_column_int(statement, 0);
NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
[dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				data.DTM_CREATED  = [dateFormat1 dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
				data.NUM_CREATED_BY  = sqlite3_column_double(statement, 2);
				char *temp3 = (char *)sqlite3_column_text(statement, 3);
				if (temp3 ==NULL)
					data.VAR_FROM_AC_NO = @"";
				else
					data.VAR_FROM_AC_NO = [NSString stringWithUTF8String: temp3];
				char *temp4 = (char *)sqlite3_column_text(statement, 4);
				if (temp4 ==NULL)
					data.VAR_TO_AC_NO = @"";
				else
					data.VAR_TO_AC_NO = [NSString stringWithUTF8String: temp4];
				data.NUM_AMOUNT  = sqlite3_column_double(statement, 5);
				char *temp6 = (char *)sqlite3_column_text(statement, 6);
				if (temp6 ==NULL)
					data.CHAR_TYPE = @"";
				else
					data.CHAR_TYPE = [NSString stringWithUTF8String: temp6];
				data.NUM_FEE  = sqlite3_column_double(statement, 7);
				char *temp8 = (char *)sqlite3_column_text(statement, 8);
				if (temp8 ==NULL)
					data.VAR_LOCATION = @"";
				else
					data.VAR_LOCATION = [NSString stringWithUTF8String: temp8];
				[datas addObject:data];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(database);
	}
	return datas;
}
-(t_transaction *)SelectByID:(int)_id {
	t_transaction * data =NULL;
	NSString *file = [Util getWritableDBPath:[Vars GetDBName]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:file];
	if(!success) {
		[Util createEditableCopyOfDatabaseIfNeeded:[Vars GetDBName] IsDocument:NO];
	}
	const char *dbpath = [file UTF8String];
	sqlite3_stmt    *statement;
	sqlite3 *database = NULL;
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat:@"select * from t_transaction WHERE ID = %d",_id];
		const char *query_stmt = [querySQL UTF8String];
		if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
				data = [[t_transaction alloc]init];
				data.ID = sqlite3_column_int(statement, 0); 
NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
[dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				data.DTM_CREATED  = [dateFormat1 dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
				data.NUM_CREATED_BY = sqlite3_column_double(statement, 2); 
				char *temp3 = (char *)sqlite3_column_text(statement, 3);
				if (temp3 ==NULL)
					data.VAR_FROM_AC_NO = @"";
				else
					data.VAR_FROM_AC_NO = [NSString stringWithUTF8String: temp3];
				char *temp4 = (char *)sqlite3_column_text(statement, 4);
				if (temp4 ==NULL)
					data.VAR_TO_AC_NO = @"";
				else
					data.VAR_TO_AC_NO = [NSString stringWithUTF8String: temp4];
				data.NUM_AMOUNT = sqlite3_column_double(statement, 5); 
				char *temp6 = (char *)sqlite3_column_text(statement, 6);
				if (temp6 ==NULL)
					data.CHAR_TYPE = @"";
				else
					data.CHAR_TYPE = [NSString stringWithUTF8String: temp6];
				data.NUM_FEE = sqlite3_column_double(statement, 7); 
				char *temp8 = (char *)sqlite3_column_text(statement, 8);
				if (temp8 ==NULL)
					data.VAR_LOCATION = @"";
				else
					data.VAR_LOCATION = [NSString stringWithUTF8String: temp8];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(database);
	}
	return data;
}
-(NSString *)DeleteByID:(int)_id {
	NSString *errorText = [[NSString alloc]init];
	NSString *file = [Util getWritableDBPath:[Vars GetDBName] ];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:file];
	if(!success) {
		[Util createEditableCopyOfDatabaseIfNeeded:[Vars GetDBName]];
	}
	const char *filePath = [file UTF8String];
	sqlite3 *database = NULL;
	if(sqlite3_open(filePath, &database) == SQLITE_OK)
	{
		NSString *temp = [NSString stringWithFormat:@"delete from t_transaction WHERE ID = %d",_id];
		const char *sqlStatement =[temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE )
		{
			errorText =[[NSString alloc]initWithString:[NSString stringWithFormat: @"Delete Error: %s", sqlite3_errmsg(database) ]];
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	return errorText;
}
-(NSString *)InsertDTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by VAR_FROM_AC_NO:(NSString *)_var_from_ac_no VAR_TO_AC_NO:(NSString *)_var_to_ac_no NUM_AMOUNT:(double)_num_amount CHAR_TYPE:(NSString *)_char_type NUM_FEE:(double)_num_fee VAR_LOCATION:(NSString *)_var_location {
	NSString *errorText = [[NSString alloc]init];
	NSString *file = [Util getWritableDBPath:[Vars GetDBName]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:file];
	if(!success) {
		[Util createEditableCopyOfDatabaseIfNeeded:[Vars GetDBName]];
	}
	const char *filePath = [file UTF8String];
	sqlite3 *database = NULL;
	if(sqlite3_open(filePath, &database) == SQLITE_OK)
	{
		NSString *temp = [NSString stringWithFormat:@"insert into t_transaction(DTM_CREATED, NUM_CREATED_BY, VAR_FROM_AC_NO, VAR_TO_AC_NO, NUM_AMOUNT, CHAR_TYPE, NUM_FEE, VAR_LOCATION) VALUES (\"%@\", %f, \"%@\", \"%@\", %f, \"%@\", %f, \"%@\" )",_dtm_created,_num_created_by,_var_from_ac_no,_var_to_ac_no,_num_amount,_char_type,_num_fee,_var_location ];
		const char *sqlStatement =[temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
			errorText =[[NSString alloc]initWithString:[NSString stringWithFormat:  @"Insert Error: %s", sqlite3_errmsg(database) ]];
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	return errorText;
}
-(NSString *)UpdateByID:(int)_id DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by VAR_FROM_AC_NO:(NSString *)_var_from_ac_no VAR_TO_AC_NO:(NSString *)_var_to_ac_no NUM_AMOUNT:(double)_num_amount CHAR_TYPE:(NSString *)_char_type NUM_FEE:(double)_num_fee VAR_LOCATION:(NSString *)_var_location {
	NSString *errorText = [[NSString alloc]init];
	NSString *file = [Util getWritableDBPath:[Vars GetDBName]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:file];
	if(!success) {
		[Util createEditableCopyOfDatabaseIfNeeded:[Vars GetDBName]];
	}
	const char *filePath = [file UTF8String];
	sqlite3 *database = NULL;
	if(sqlite3_open(filePath, &database) == SQLITE_OK)
	{
		NSString *temp = [NSString stringWithFormat:@"UPDATE t_transaction set DTM_CREATED=\"%@\", NUM_CREATED_BY=%f, VAR_FROM_AC_NO=\"%@\", VAR_TO_AC_NO=\"%@\", NUM_AMOUNT=%f, CHAR_TYPE=\"%@\", NUM_FEE=%f, VAR_LOCATION=\"%@\" where ID=%d" ,_dtm_created,_num_created_by,_var_from_ac_no,_var_to_ac_no,_num_amount,_char_type,_num_fee,_var_location,_id];
		const char *sqlStatement =[temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
			errorText =[[NSString alloc]initWithString:[NSString stringWithFormat:  @"Update Error: %s", sqlite3_errmsg(database) ]];
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	return errorText;
}
@end
