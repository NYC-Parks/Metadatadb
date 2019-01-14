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
--drop procedure dbo.sp_update_table_info
create procedure dbo.sp_update_table_info as
	declare @i int = 1, @n int, @tabname nvarchar(128),
		    @object__id int, @schema__id int, @create_date datetime, @modify_date datetime,
			@max_column_id_used int, @uses_ansi_nulls bit;

	declare @uptabs table (rowid int identity(1,1) not null,
						   name nvarchar(128) not null,
						   object__id int not null,
						   schema__id int not null,
						   create_date datetime not null,
						   modify_date datetime not null,
						   max_column_id_used int null,
						   uses_ansi_nulls bit null);

		with tabs as(
		select name, 
			   object_id as object__id,
			   schema_id as schema__id,
			   create_date,
			   modify_date,
			   max_column_id_used,
			   uses_ansi_nulls,
			   cast(cast(object_id as nvarchar(10)) + cast(schema_id as nvarchar(2)) + cast(create_date as nvarchar(24)) + cast(modify_date as nvarchar(24))+ cast(max_column_id_used as nvarchar(10))+ cast(uses_ansi_nulls as nvarchar(1)) as varbinary(max)) as bin_row
		from dwh.sys.tables 
		/*Exclude all geodatabase related items*/
		where lower(name) not like 'gdb%' and
			  lower(name) not like 'sde%' and
			  lower(name) not like '[ida][0-9]%'
		union all
		select name, 
			   object_id as object__id,
			   schema_id as schema__id,
			   create_date,
			   modify_date,
			   cast(null as int) as max_column_id_used,
			   cast(null as int) as uses_ansi_nulls,
			   cast(cast(object_id as nvarchar(10)) + cast(schema_id as nvarchar(2)) + cast(create_date as nvarchar(24)) + cast(modify_date as nvarchar(24))+ cast(cast(isnull(null, -1) as int) as nvarchar(10))+ cast(cast(isnull(null, 9) as int) as nvarchar(1)) as varbinary(max)) as bin_row
		from dwh.sys.views
		where lower(name) not like 'st%' and
			  lower(name) not like 'sde%' and
			  lower(name) not like 'dbtune')
		--select * from tabs
		insert into @uptabs (name,
							 object__id,
							 schema__id,
							 create_date,
							 modify_date,
							 max_column_id_used,
							 uses_ansi_nulls)
			select l.name,
				   l.object__id,
				   l.schema__id,
				   l.create_date,
				   l.modify_date,
				   l.max_column_id_used,
				   l.uses_ansi_nulls
			from tabs as l
			inner join
				(select *,
						cast(cast(object__id as nvarchar(10)) + cast(schema__id as nvarchar(2)) + cast(create_date as nvarchar(24)) + cast(modify_date as nvarchar(24))+ cast(cast(isnull(max_column_id_used, -1) as int) as nvarchar(10))+ cast(cast(isnull(uses_ansi_nulls, 9) as int) as nvarchar(1)) as varbinary(max)) as bin_row 
				 from metadatadb.dbo.tbl_table_info) as r
			on l.name = r.name
			where l.bin_row != r.bin_row;

		set @n = (select max(rowid) from @uptabs);

		while @i <= @n
			begin
				/*Push the values that need to be updated into parameters*/
				set @tabname = (select name from @uptabs where rowid = @i);
				set @object__id = (select object__id from @uptabs where rowid = @i);
				set @schema__id = (select schema__id from @uptabs where rowid = @i);
				set @create_date = (select create_date from @uptabs where rowid = @i);
				set @modify_date = (select modify_date from @uptabs where rowid = @i);
				set @max_column_id_used = (select max_column_id_used from @uptabs where rowid = @i);
				set @uses_ansi_nulls = (select uses_ansi_nulls from @uptabs where rowid = @i);

				/*Update tbl_table_info with the parameter values that did or may have changed.*/
				update metadatadb.dbo.tbl_table_info
				set object__id = @object__id , 
					schema__id = @schema__id, 
					create_date = @create_date,	
					modify_date = @modify_date,
					max_column_id_used = @max_column_id_used, 
					uses_ansi_nulls = @uses_ansi_nulls
				where name = @tabname;

				set @i = @i + 1;
			end;
	    
			 