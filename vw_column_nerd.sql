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
--drop view dbo.vw_column_nerd
create view dbo.vw_column_nerd as
	select l.object__id,
		   r2.name as table_name,
		   l.name,
		   r.column_desc,
		   r.column_notes,
		   l.column_id,
		   l.system_type__id,
		   l.user_type__id,
		   l.max_length,
		   l.precision,
		   l.scale,
		   l.collation_name,
		   l.is_nullable,
		   l.is_ansi_padded,
		   l.is_identity
	from metadatadb.dbo.tbl_column_info as l
	left join
		 metadatadb.dbo.tbl_column_desc as r
	on l.object__id = r.object__id and
	   l.name = r.name
	left join
		 metadatadb.dbo.tbl_table_info as r2
	on l.object__id = r2.object__id
		 