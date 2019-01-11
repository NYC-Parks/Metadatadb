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
--drop table metadatadb.dbo.tbl_table_tags
create table metadatadb.dbo.tbl_table_tags(tag__id int identity(1,1),
										   object__id int not null,
										   name nvarchar(128) not null,
										   tag nvarchar(50) null);

alter table metadatadb.dbo.tbl_table_tags
	add constraint pk_md_table_tags primary key (tag__id);

alter table metadatadb.dbo.tbl_table_tags
	add constraint fk_md_table_tags foreign key (object__id) references metadatadb.dbo.tbl_table_info (object__id);

