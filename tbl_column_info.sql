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
--drop table metadatadb.dbo.tbl_column_info
create table metadatadb.dbo.tbl_column_info(object__id int not null,
											name nvarchar(128) not null,
											column_id int not null,	
											system_type__id tinyint not null,
											user_type__id int not null,									
											max_length smallint not null,
											precision tinyint not null,
											scale tinyint not null,
											collation_name nvarchar(128) null,
											is_nullable bit not null,
											is_ansi_padded bit not null,
											is_identity bit not null,
											is_computed bit not null);

alter table metadatadb.dbo.tbl_column_info
	add constraint pk_md_column_info primary key (object__id, name);

alter table metadatadb.dbo.tbl_column_info
	add constraint fk_md_column_info foreign key (system_type__id, user_type__id) references metadatadb.dbo.tbl_ref_dtypes (system_type__id, user_type__id);

alter table metadatadb.dbo.tbl_column_info
	--drop constraint fk_md_column_info2
	add constraint fk_md_column_info2 foreign key (object__id) references metadatadb.dbo.tbl_table_info (object__id) on delete cascade on update cascade;
