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
--drop table metadatadb.dbo.tbl_table_desc;
create table metadatadb.dbo.tbl_table_desc(name nvarchar(128) not null,
										   object__id int not null,
										   table_desc nvarchar(255),
										   table_notes nvarchar(255));

alter table metadatadb.dbo.tbl_table_desc
	--drop constraint fk_md_table_desc
	add constraint fk_md_table_desc foreign key (object__id) references metadatadb.dbo.tbl_table_info(object__id) on delete cascade on update cascade;

alter table metadatadb.dbo.tbl_table_desc
	--drop constraint unq_md_table_desc
	add constraint unq_md_table_desc unique (object__id, name);