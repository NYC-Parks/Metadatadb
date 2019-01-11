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

alter table metadatadb.dbo.tbl_column_info
	drop constraint fk_md_column_info


alter table metadatadb.dbo.tbl_column_info
	drop constraint fk_md_column_info2

alter table metadatadb.dbo.tbl_column_desc
	drop constraint fk_md_column_desc

alter table metadatadb.dbo.tbl_column_info
	drop constraint pk_md_column_info

drop table metadatadb.dbo.tbl_ref_dtypes
drop table metadatadb.dbo.tbl_column_desc
drop table metadatadb.dbo.tbl_column_info