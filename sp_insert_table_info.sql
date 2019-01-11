/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: <Modifier Name>																						   			          
 Created Date:  <MM/DD/YYYY>																							   
 Modified Date: <MM/DD/YYYY>																							   
											       																	   
 Project: <Project Name>	
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: <Lorem ipsum dolor sit amet, legimus molestiae philosophia ex cum, omnium voluptua evertitur nec ea.     
	       Ut has tota ullamcorper, vis at aeque omnium. Est sint purto at, verear inimicus at has. Ad sed dicat       
	       iudicabit. Has ut eros tation theophrastus, et eam natum vocent detracto, purto impedit appellantur te	   
	       vis. His ad sonet probatus torquatos, ut vim tempor vidisse deleniti.>  									   
																													   												
***********************************************************************************************************************/
use metadatadb
go
--drop procedure dbo.sp_insert_table_info
create procedure dbo.sp_insert_table_info as
	insert into metadatadb.dbo.tbl_table_info(name, 
											  object__id,
											  schema__id,
											  create_date,
											  modify_date,
											  max_column_id_used,
											  uses_ansi_nulls)
		select name, 
			   object__id,
			   schema__id,
			   create_date,
			   modify_date,
			   max_column_id_used,
			   uses_ansi_nulls
		from (select name, 
					 object_id as object__id,
					 schema_id as schema__id,
					 create_date,
					 modify_date,
					 max_column_id_used,
					 uses_ansi_nulls
			  from dwh.sys.tables 
			  /*Exclude all geodatabase related items*/
			  where lower(name) not like 'gdb%' and
					lower(name) not like 'sde%' and
					lower(name) not like '[ida][0-9]%'
			  except
			  select name, 
					 object__id,
					 schema__id,
					 create_date,
					 modify_date,
					 max_column_id_used,
					 uses_ansi_nulls
			  from metadatadb.dbo.tbl_table_info) as t;
