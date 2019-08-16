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

create procedure dbo.sp_run_procs as
begin
	/*Insert any new data types, these will almost never or never will change*/
	exec metadatadb.dbo.sp_insert_ref_dtypes;
	/*Update the table info table for any table that currently exist, but had some attribute (other than name) change.*/
	exec metadatadb.dbo.sp_update_table_info;
	/*Insert any new tables into table info. These changes will be reflected in the related tables with triggers*/
	exec metadatadb.dbo.sp_insert_table_info;
	/*Update the column info table to reflect any changes in attributes (other than object__id) or name*/
	exec metadatadb.dbo.sp_update_column_info;
end;

