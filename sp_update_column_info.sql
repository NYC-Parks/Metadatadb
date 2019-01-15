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
--drop procedure dbo.sp_update_column_info
create procedure dbo.sp_update_column_info as
	declare @i int = 1, @n int, @tabobj int,
			@object__id int, @name nvarchar(128), @column_id int,	
			@system_type__id tinyint, @user_type__id int, @max_length smallint,
			@precision tinyint, @scale tinyint, @collation_name nvarchar(128),
			@is_nullable bit, @is_ansi_padded bit, @is_identity bit, @is_computed bit;

	declare @upcols table (rowid int identity(1,1) not null,
						   object__id int not null,
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
		with cols as(
		select *
		from metadatadb.dbo.vw_column_info)

			/*Insert the differences between the current metadata table and the current information in the system table*/
		insert into @upcols (object__id,
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
			select *
			from cols
			except
			select *
			from metadatadb.dbo.tbl_column_info

		set @n = (select max(rowid) from @upcols);

		while @i <= @n
			begin
				/*Push the values that need to be updated into parameters*/
				set @name = (select name from @upcols where rowid = @i);
				set @column_id = (select column_id from @upcols where rowid = @i);	
				set @system_type__id = (select system_type__id from @upcols where rowid = @i);
				set @user_type__id = (select user_type__id from @upcols where rowid = @i);
				set @max_length = (select max_length from @upcols where rowid = @i);
				set @precision = (select precision from @upcols where rowid = @i);
				set @scale = (select scale from @upcols where rowid = @i);
				set @collation_name = (select collation_name from @upcols where rowid = @i);
				set @is_nullable = (select is_nullable from @upcols where rowid = @i);
				set @is_ansi_padded = (select is_ansi_padded from @upcols where rowid = @i);
				set @is_identity = (select is_identity from @upcols where rowid = @i);
				set @is_computed = (select is_computed from @upcols where rowid = @i);

				/*Update tbl_table_info with the parameter values that did or may have changed.*/
				update metadatadb.dbo.tbl_column_info
				set name = @name, 
					column_id = @column_id, 
					system_type__id = @system_type__id,
					user_type__id = @user_type__id,	
					max_length = @max_length,
					precision = @precision,
					scale = @scale,
					collation_name = @collation_name,
					is_nullable = @is_nullable,
					is_ansi_padded = @is_ansi_padded,
					is_identity = @is_identity,
					is_computed = @is_computed
				where object__id = @tabobj;

				set @i = @i + 1;
			end;