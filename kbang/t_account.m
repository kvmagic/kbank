
#import "t_account.h"
#import "Util.h"
#import <sqlite3.h>
#import "Vars.h"
@implementation t_account
@synthesize ID, VAR_NAME, VAR_AC_NO, VAR_BANK, VAR_BRANCH, NUM_AMOUNT, CHAR_STATUS, DTM_CREATED, NUM_CREATED_BY, DTM_MODIFIED, NUM_MODIFIED_BY, VAR_DESCRIPTION, IS_OWNER, NUM_SEQUENCE, VAR_SURNAME;
-(id)initWithID:(int)_id VAR_NAME:(NSString *)_var_name VAR_AC_NO:(NSString *)_var_ac_no VAR_BANK:(NSString *)_var_bank VAR_BRANCH:(NSString *)_var_branch NUM_AMOUNT:(double)_num_amount CHAR_STATUS:(NSString *)_char_status DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by DTM_MODIFIED:(NSDate *)_dtm_modified NUM_MODIFIED_BY:(double)_num_modified_by VAR_DESCRIPTION:(NSString *)_var_description IS_OWNER:(bool)_is_owner NUM_SEQUENCE:(double)_num_sequence VAR_SURNAME:(NSString *)_var_surname 
{
	self = [super init];
	if(self)
	{
		self.ID= _id;
		self.VAR_NAME= _var_name;
		self.VAR_AC_NO= _var_ac_no;
		self.VAR_BANK= _var_bank;
		self.VAR_BRANCH= _var_branch;
		self.NUM_AMOUNT= _num_amount;
		self.CHAR_STATUS= _char_status;
		self.DTM_CREATED= _dtm_created;
		self.NUM_CREATED_BY= _num_created_by;
		self.DTM_MODIFIED= _dtm_modified;
		self.NUM_MODIFIED_BY= _num_modified_by;
		self.VAR_DESCRIPTION= _var_description;
		self.IS_OWNER= _is_owner;
		self.NUM_SEQUENCE= _num_sequence;
		self.VAR_SURNAME= _var_surname;

	}
	return self;
}
-(NSMutableArray *)Select:(int)_isowner{
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
        NSString *isowner = @"true";
        if (_isowner==0) {
            isowner = @"false";
        }
		NSString *querySQL = [NSString stringWithFormat:@"select * from t_account where IS_OWNER = '%@' and char_status ='A' order by ID desc",isowner];
		const char *query_stmt = [querySQL UTF8String];
		if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(statement) == SQLITE_ROW)
			{
				t_account  *data = [[t_account alloc]init];
				data.ID  = sqlite3_column_int(statement, 0);
				char *temp1 = (char *)sqlite3_column_text(statement, 1);
				if (temp1 ==NULL)
					data.VAR_NAME = @"";
				else
					data.VAR_NAME = [NSString stringWithUTF8String: temp1];
				char *temp2 = (char *)sqlite3_column_text(statement, 2);
				if (temp2 ==NULL)
                {
                    data.VAR_AC_NO = @"";
                    data.VAR_AC_NO_ORG = @"";
                }
				else
                {
                    data.VAR_AC_NO_ORG = [NSString stringWithUTF8String: temp2];
                    NSMutableString *mu = [NSMutableString stringWithString:[NSString stringWithUTF8String: temp2]];
                    [mu insertString:@"-" atIndex:9];
                    [mu insertString:@"-" atIndex:4];
                    [mu insertString:@"-" atIndex:3];
					data.VAR_AC_NO = [NSString stringWithString:mu];
                }
				char *temp3 = (char *)sqlite3_column_text(statement, 3);
				if (temp3 ==NULL)
					data.VAR_BANK = @"";
				else
					data.VAR_BANK = [NSString stringWithUTF8String: temp3];
				char *temp4 = (char *)sqlite3_column_text(statement, 4);
				if (temp4 ==NULL)
					data.VAR_BRANCH = @"";
				else
					data.VAR_BRANCH = [NSString stringWithUTF8String: temp4];
				data.NUM_AMOUNT  = sqlite3_column_double(statement, 5);
				char *temp6 = (char *)sqlite3_column_text(statement, 6);
				if (temp6 ==NULL)
					data.CHAR_STATUS = @"";
				else
					data.CHAR_STATUS = [NSString stringWithUTF8String: temp6];
NSDateFormatter *dateFormat7 = [[NSDateFormatter alloc] init];
[dateFormat7 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				data.DTM_CREATED  = [dateFormat7 dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]];
				data.NUM_CREATED_BY  = sqlite3_column_double(statement, 8);
NSDateFormatter *dateFormat9 = [[NSDateFormatter alloc] init];
[dateFormat9 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				data.DTM_MODIFIED  = [dateFormat9 dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)]];
				data.NUM_MODIFIED_BY  = sqlite3_column_double(statement, 10);
				char *temp11 = (char *)sqlite3_column_text(statement, 11);
				if (temp11 ==NULL)
					data.VAR_DESCRIPTION = @"";
				else
					data.VAR_DESCRIPTION = [NSString stringWithUTF8String: temp11];
				data.IS_OWNER  =  (sqlite3_column_int(statement,  12) == 1);
				data.NUM_SEQUENCE  = sqlite3_column_double(statement, 13);
				char *temp14 = (char *)sqlite3_column_text(statement, 14);
				if (temp14 ==NULL)
					data.VAR_SURNAME = @"";
				else
					data.VAR_SURNAME = [NSString stringWithUTF8String: temp14];
				[datas addObject:data];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(database);
	}
	return datas;
}
-(t_account *)SelectByID:(int)_id {
	t_account * data =NULL;
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
		NSString *querySQL = [NSString stringWithFormat:@"select * from t_account WHERE ID = %d",_id];
		const char *query_stmt = [querySQL UTF8String];
		if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
				data = [[t_account alloc]init];
				data.ID = sqlite3_column_int(statement, 0); 
				char *temp1 = (char *)sqlite3_column_text(statement, 1);
				if (temp1 ==NULL)
					data.VAR_NAME = @"";
				else
					data.VAR_NAME = [NSString stringWithUTF8String: temp1];
				char *temp2 = (char *)sqlite3_column_text(statement, 2);
                if (temp2 ==NULL)
                {
                    data.VAR_AC_NO = @"";
                    data.VAR_AC_NO_ORG = @"";
                }
                else
                {
                    data.VAR_AC_NO_ORG = [NSString stringWithUTF8String: temp2];
                    NSMutableString *mu = [NSMutableString stringWithString:[NSString stringWithUTF8String: temp2]];
                    [mu insertString:@"-" atIndex:9];
                    [mu insertString:@"-" atIndex:4];
                    [mu insertString:@"-" atIndex:3];
                    data.VAR_AC_NO = [NSString stringWithString:mu];
                }				char *temp3 = (char *)sqlite3_column_text(statement, 3);
				if (temp3 ==NULL)
					data.VAR_BANK = @"";
				else
					data.VAR_BANK = [NSString stringWithUTF8String: temp3];
				char *temp4 = (char *)sqlite3_column_text(statement, 4);
				if (temp4 ==NULL)
					data.VAR_BRANCH = @"";
				else
					data.VAR_BRANCH = [NSString stringWithUTF8String: temp4];
				data.NUM_AMOUNT = sqlite3_column_double(statement, 5); 
				char *temp6 = (char *)sqlite3_column_text(statement, 6);
				if (temp6 ==NULL)
					data.CHAR_STATUS = @"";
				else
					data.CHAR_STATUS = [NSString stringWithUTF8String: temp6];
NSDateFormatter *dateFormat7 = [[NSDateFormatter alloc] init];
[dateFormat7 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				data.DTM_CREATED  = [dateFormat7 dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]];
				data.NUM_CREATED_BY = sqlite3_column_double(statement, 8); 
NSDateFormatter *dateFormat9 = [[NSDateFormatter alloc] init];
[dateFormat9 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				data.DTM_MODIFIED  = [dateFormat9 dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)]];
				data.NUM_MODIFIED_BY = sqlite3_column_double(statement, 10); 
				char *temp11 = (char *)sqlite3_column_text(statement, 11);
				if (temp11 ==NULL)
					data.VAR_DESCRIPTION = @"";
				else
					data.VAR_DESCRIPTION = [NSString stringWithUTF8String: temp11];
				data.IS_OWNER  =  (sqlite3_column_int(statement, 12) == 1);
				data.NUM_SEQUENCE = sqlite3_column_double(statement, 13); 
				char *temp14 = (char *)sqlite3_column_text(statement, 14);
				if (temp14 ==NULL)
					data.VAR_SURNAME = @"";
				else
					data.VAR_SURNAME = [NSString stringWithUTF8String: temp14];
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
		NSString *temp = [NSString stringWithFormat:@"delete from t_account WHERE ID = %d",_id];
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
-(NSString *)InsertVAR_NAME:(NSString *)_var_name VAR_AC_NO:(NSString *)_var_ac_no VAR_BANK:(NSString *)_var_bank VAR_BRANCH:(NSString *)_var_branch NUM_AMOUNT:(double)_num_amount CHAR_STATUS:(NSString *)_char_status DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by DTM_MODIFIED:(NSDate *)_dtm_modified NUM_MODIFIED_BY:(double)_num_modified_by VAR_DESCRIPTION:(NSString *)_var_description IS_OWNER:(bool)_is_owner NUM_SEQUENCE:(double)_num_sequence VAR_SURNAME:(NSString *)_var_surname {
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
		NSString *temp = [NSString stringWithFormat:@"insert into t_account(VAR_NAME, VAR_AC_NO, VAR_BANK, VAR_BRANCH, NUM_AMOUNT, CHAR_STATUS, DTM_CREATED, NUM_CREATED_BY, DTM_MODIFIED, NUM_MODIFIED_BY, VAR_DESCRIPTION, IS_OWNER, NUM_SEQUENCE, VAR_SURNAME) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %f, \"%@\", \"%@\", %f, \"%@\", %f, \"%@\", %d, %f, \"%@\" )",_var_name,_var_ac_no,_var_bank,_var_branch,_num_amount,_char_status,_dtm_created,_num_created_by,_dtm_modified,_num_modified_by,_var_description,_is_owner,_num_sequence,_var_surname ];
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
-(NSString *)UpdateByID:(int)_id VAR_NAME:(NSString *)_var_name VAR_AC_NO:(NSString *)_var_ac_no VAR_BANK:(NSString *)_var_bank VAR_BRANCH:(NSString *)_var_branch NUM_AMOUNT:(double)_num_amount CHAR_STATUS:(NSString *)_char_status DTM_CREATED:(NSDate *)_dtm_created NUM_CREATED_BY:(double)_num_created_by DTM_MODIFIED:(NSDate *)_dtm_modified NUM_MODIFIED_BY:(double)_num_modified_by VAR_DESCRIPTION:(NSString *)_var_description IS_OWNER:(bool)_is_owner NUM_SEQUENCE:(double)_num_sequence VAR_SURNAME:(NSString *)_var_surname {
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
		NSString *temp = [NSString stringWithFormat:@"UPDATE t_account set VAR_NAME=\"%@\", VAR_AC_NO=\"%@\", VAR_BANK=\"%@\", VAR_BRANCH=\"%@\", NUM_AMOUNT=%f, CHAR_STATUS=\"%@\", DTM_CREATED=\"%@\", NUM_CREATED_BY=%f, DTM_MODIFIED=\"%@\", NUM_MODIFIED_BY=%f, VAR_DESCRIPTION=\"%@\", IS_OWNER=%d, NUM_SEQUENCE=%f, VAR_SURNAME=\"%@\" where ID=%d" ,_var_name,_var_ac_no,_var_bank,_var_branch,_num_amount,_char_status,_dtm_created,_num_created_by,_dtm_modified,_num_modified_by,_var_description,_is_owner,_num_sequence,_var_surname,_id];
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

-(NSString *) UpdateByID:(int)_id NUM_AMOUNT:(double)_num_amount NUM_CREATED_BY:(double)_num_created_by NUM_MODIFIED_BY:(double)_num_modified_by NUM_SEQUENCE:(double)_num_sequence {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[dateFormat stringFromDate:[NSDate date]];
    
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
        NSString *temp = [NSString stringWithFormat:@"UPDATE t_account set NUM_AMOUNT=%f, DTM_CREATED=\"%@\", NUM_CREATED_BY=%f, DTM_MODIFIED=\"%@\", NUM_MODIFIED_BY=%f, NUM_SEQUENCE=%f where ID=%d" ,_num_amount,dateString,_num_created_by,dateString,_num_modified_by,_num_sequence,_id];
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


-(NSString *) UpdateByID:(NSMutableArray*)accounts CurrentDate:(NSDate**)currentDate LoginID:(long)loginID Amount:(double)amount Fee:(double)fee RecordNo:(int*)recordNo
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    *currentDate=[NSDate date];
    NSString *dateString=[dateFormat stringFromDate:*currentDate];
    
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
        sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION", 0, 0, 0);
        
        sqlite3_stmt *compiledStatement = NULL;
        
        for (t_account* account in accounts) {
            NSString *temp = [NSString stringWithFormat:@"UPDATE t_account set NUM_AMOUNT=%f, DTM_MODIFIED=\"%@\", NUM_MODIFIED_BY=%ld, NUM_SEQUENCE=%f where ID=%d" ,account.NUM_AMOUNT,dateString,loginID,account.NUM_SEQUENCE+1,account.ID];
            const char *sqlStatement =[temp UTF8String];
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){}
            if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
                errorText =[[NSString alloc]initWithString:[NSString stringWithFormat:  @"Update Error: %s", sqlite3_errmsg(database) ]];
            }
            sqlite3_reset(compiledStatement);
        }
        t_account* fromAccount = [accounts objectAtIndex:0];
        t_account* toAccount = [accounts objectAtIndex:1];
        
        NSString * temp = [NSString stringWithFormat:@"insert into t_transaction(DTM_CREATED, NUM_CREATED_BY, VAR_FROM_AC_NO, VAR_TO_AC_NO, NUM_AMOUNT, CHAR_TYPE, NUM_FEE) VALUES (\"%@\", %ld, \"%@\", \"%@\", %f, \"%@\", %f )",dateString,loginID,fromAccount.VAR_AC_NO_ORG,toAccount.VAR_AC_NO_ORG,amount,@"T",fee ];
        const char *sqlStatement =[temp UTF8String];
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){}
        if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            errorText =[[NSString alloc]initWithString:[NSString stringWithFormat:  @"Insert Error: %s", sqlite3_errmsg(database) ]];
        }
        
        NSString *querySQL = [NSString stringWithFormat:@"select MAX(ID) from t_transaction"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                *recordNo = sqlite3_column_int(compiledStatement, 0);
            }
        }
        
        
        if (sqlite3_exec(database, "COMMIT TRANSACTION", 0, 0, 0) != SQLITE_OK)
        {
            errorText =[[NSString alloc]initWithString:[NSString stringWithFormat:  @"Update Error: %s", sqlite3_errmsg(database) ]];
        }
        
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return errorText;
}
@end
