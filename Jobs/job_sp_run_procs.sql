/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: <Modifier Name>																						   			          
 Created Date:  08/16/2019																							   
 Modified Date: <MM/DD/YYYY>																							   
											       																	   
 Project: MetadataDB	
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: Create the job that populates and updates MetadataDB.>  									   
																													   												
***********************************************************************************************************************/
set ansi_nulls on;
go

set quoted_identifier on;
go

use msdb ;  
go  

/*If the job already exists, delete it.*/
if exists(select * from msdb.dbo.sysjobs where name = 'job_sp_run_procs_metadatadb')
	begin	
		exec sp_delete_job @job_name = N'job_sp_run_procs_metadatadb';  
	end;
go


/*If the schedule doesn't exist, create it.*/
if not exists(select * from msdb.dbo.sysschedules where name = 'Once_Hourly')
	begin	
		exec dbo.sp_add_schedule  
			@schedule_name = N'Once_Hourly',  
			@freq_type = 4,  
			@freq_interval = 1,
			@freq_subday_type = 0x8,
			@freq_subday_interval = 1,
			@active_start_time = 000100;  
	end;
go

declare @job_id uniqueidentifier;
declare @owner sysname;
exec master.dbo.sp_sql_owner @file_path = 'D:\Projects', @result = @owner output;


/*Create the job*/
exec dbo.sp_add_job @job_name = N'job_sp_run_procs_metadatadb', 
					@enabled = 1,
					@description = N'Insert and update records in the metadatadb tables.',
					@owner_login_name = @owner,
					@job_id = @job_id output;

exec sp_add_jobserver  
   @job_id = @job_id,  
   @server_name = N'(LOCAL)';  

/*exec dbo.sp_add_job  
    @job_name = N'Create or insert records into the comfort station table 3.', 
	@owner_login_name = 'NYCDPR\py_services',
	Only notify if the job fails to run
	@notify_level_eventlog = 2;  */


exec dbo.sp_add_jobstep  
    @job_id = @job_id,  
    @step_name = N'sp_run_procs',  
    @subsystem = N'TSQL',  
    @command = N'exec metadatadb.dbo.sp_run_procs',
	@on_success_action = 1,
	@on_fail_action = 2;/*,   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  */
 
 
exec sp_attach_schedule  
   @job_id = @job_id,  
   @schedule_name = N'Once_Hourly';  

