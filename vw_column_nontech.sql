/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: <Modifier Name>																						   			          
 Created Date:  02/20/2019																							   
 Modified Date: <MM/DD/YYYY>																							   
											       																	   
 Project: <Project Name>	
 																							   
 Tables Used: metadatadb.dbo.tbl_column_info																							   
 			  metadatadb.dbo.tbl_column_desc																								   
 			  metadatadb.dbo.tbl_ref_dtypes
			  metadatadb.dbo.tbl_table_desc				
			  																				   
 Description: <Lorem ipsum dolor sit amet, legimus molestiae philosophia ex cum, omnium voluptua evertitur nec ea.     
	       Ut has tota ullamcorper, vis at aeque omnium. Est sint purto at, verear inimicus at has. Ad sed dicat       
	       iudicabit. Has ut eros tation theophrastus, et eam natum vocent detracto, purto impedit appellantur te	   
	       vis. His ad sonet probatus torquatos, ut vim tempor vidisse deleniti.>  									   
																													   												
***********************************************************************************************************************/
use metadatadb
go
--drop view dbo.vw_column_nontech
create view dbo.vw_column_nontech as
	select top 100 percent r3.name as table_name,
		   l.name as column_name,
		   r.column_desc,
		   r.column_notes,
		   r2.common_type,
		   isnull(r.row__id, -99) as row__id
	from metadatadb.dbo.tbl_column_info as l
	left join
		 metadatadb.dbo.tbl_column_desc as r
	on l.object__id = r.object__id and
	   l.name = r.name
	left join
		 metadatadb.dbo.tbl_ref_dtypes as r2
	on l.system_type__id = r2.system_type__id and
	   l.user_type__id = r2.user_type__id
	left join
		 metadatadb.dbo.tbl_table_desc as r3
	on l.object__id = r3.object__id
	order by l.object__id, l.column_id
