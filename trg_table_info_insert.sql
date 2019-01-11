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

--drop trigger dbo.trg_table_info_insert
create trigger dbo.trg_table_info_insert
on dbo.tbl_table_info
after insert as

insert into tbl_table_desc(object__id, name)
	select object__id, name
	from inserted;

/*Insert the new tables columns information into corresponding rows of the column info table*/
insert into dbo.tbl_column_info(object__id,
								name,
								column_id,
								system_type__id,
								user_type__id,
								max_length,
								precision,
								scale,
								collation_name,
								is_nullable,
								is_ansi_padded,
								is_identity,
								is_computed)
	select r.*
	from inserted as l
	left join
		 (select object_id as object__id,
				 name,
				 column_id,
				 system_type_id as system_type__id,
				 user_type_id as user_type__id,
				 max_length,
				 precision,
				 scale,
				 collation_name,
				 is_nullable,
				 is_ansi_padded,
				 is_identity,
				 is_computed
		  from dwh.sys.columns) as r
	on l.object__id = r.object__id;