USE [Config2]
-- Migration Config DB Script
-- vars
:setvar CortexDBUser "sotonlab\ctx_cerberusdb"
:setvar DatabaseFilePath "C:\Cortex Databases\"
:setvar DatabaseLogPath "C:\Cortex Databases\"
:setvar Distribution_DataPath "C:\Cortex Databases\distribution" 
:setvar Distribution_LogPath "C:\Cortex Databases\distribution"
:setvar InstanceName "v-ctxappdb19"
:setvar MachineName "v-ctxappdb19"
:setvar REPL_Admin_User "sotonlab\ctx_sql_admin"
:setvar REPL_Working_Directory "C:\Cortex Databases\"
:setvar ResilientInstanceName "v-ctxappdb20"
:setvar DatabaseName "Config2"
:setvar DefaultFilePrefix "Config2"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END



/*
Rename old database tables
*/
PRINT 'Starting old database tables renaming...'
GO
PRINT '***Renaming Config_Values to Config_Values-v1...'
exec sp_rename 'Config_Values','Config_Values-v1'

GO
PRINT '***Renaming Config_Parameters to Config_Parameters-v1...'
exec sp_rename 'Config_Parameters','Config_Parameters-v1'

GO
PRINT '***Renaming Config_Mapping to Config_Mapping-v1...'
exec sp_rename 'Config_Mapping','Config_Mapping-v1'

GO
PRINT '***Renaming Cust_Area_Mapped to Cust_Area_Mapped-v1...'
exec sp_rename 'Cust_Area_Mapped','Cust_Area_Mapped-v1'

GO
PRINT '***Renaming Areas to Areas-v1...'
exec sp_rename 'Areas','Areas-v1'

GO
PRINT '***Renaming Customers to Customers-v1...'
exec sp_rename 'Customers','Customers-v1'


GO
PRINT '***Renaming Environments to Environments-v1...'
exec sp_rename 'Environments','Environments-v1'

GO
PRINT '***Renaming DeleteTransactions to DeleteTransactions-v1...'
exec sp_rename 'DeleteTransactions','DeleteTransactions-v1'
/*
Deploy new database tables
*/
PRINT 'Creating Cortex Configuration v2 database objects...'
/****** Object:  Table [dbo].[Areas]    Script Date: 23/05/2019 10:55:58 ******/
PRINT '***Creating table [dbo].[Areas]...'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[ID] [int] NOT NULL,
	[Area] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Areas-v2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Area_Unique] UNIQUE NONCLUSTERED 
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 23/05/2019 10:55:58 ******/
PRINT '***Creating Table [dbo].[Customers]...'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[ID] [int]  NOT NULL,
	[Customer] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Customers-v2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Cust_Unique] UNIQUE NONCLUSTERED 
(
	[Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Environments]    Script Date: 23/05/2019 10:55:58 ******/
PRINT '***Creating Table [dbo].[Environments]...'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Environments](
	[ID] [int]  NOT NULL,
	[Environment] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Environments-v2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Env_Unique] UNIQUE NONCLUSTERED 
(
	[Environment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
PRINT '***Creating Table [dbo].[Param_Name]...'
/****** Object:  Table [dbo].[Param_Name]    Script Date: 23/05/2019 10:55:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Param_Name](
	[ID] [int]  NOT NULL,
	[Param_Name] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Param_Name-v2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Prm_Unique] UNIQUE NONCLUSTERED 
(
	[Param_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
PRINT '***Creating Table [dbo].[Param_Values]...'
/****** Object:  Table [dbo].[Param_Values]    Script Date: 23/05/2019 10:55:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Param_Values](
	[ID] [int]  NOT NULL,
	[AreaID] [int] NOT NULL,
	[CustomerID] [int] NULL,
	[EnvironmentID] [int] NULL,
	[Param_NameID] [int] NOT NULL,
	[Param_Value] [varchar](max) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Param_Values-v2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [unique_prm] UNIQUE NONCLUSTERED 
(
	[AreaID] ASC,
	[CustomerID] ASC,
	[EnvironmentID] ASC,
	[Param_NameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

PRINT '***Creating View [dbo].[CGF_All_Permutations]...'
/****** Object:  View [dbo].[CGF_All_Permutations]    Script Date: 23/05/2019 10:55:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CGF_All_Permutations] AS
SELECT T.Area
	 , T.Customer
	 , T.Environment
	 , T.Param_Name
	 , PV.ID
	 , PV.Param_Value
FROM
(SELECT A.ID AS AreaID
	  , A.Area
	  , C.ID AS CustomerID
	  , C.Customer
	  , E.ID AS EnvironmentID
	  , E.Environment
	  , PN.ID AS ParamID
	  , PN.Param_Name
FROM Param_Name PN
CROSS JOIN Areas A
CROSS JOIN Customers C
CROSS JOIN Environments E
UNION
SELECT A.ID AS AreaID
	 , A.Area
	 , C.ID AS CustomerID
	 , C.Customer
	 , NULL AS EnvironmentID
	 , NULL Environment
	 , PN.ID AS ParamID
	 , PN.Param_Name
FROM Param_Name PN
CROSS JOIN Areas A
CROSS JOIN Customers C
UNION
SELECT A.ID AS AreaID
	 , A.Area
	 , NULL AS CustomerID
	 , NULL AS Customer
	 , E.ID AS EnvironmentID
	 , E.Environment
	 , PN.ID AS ParamID
	 , PN.Param_Name
FROM Param_Name PN
CROSS JOIN Areas A
CROSS JOIN Environments E
UNION
SELECT A.ID AS AreaID
	 , A.Area
	 , NULL AS CustomerID
	 , NULL AS Customer
	 , NULL AS EnvironmentID
	 , NULL AS Environment
	 , PN.ID AS ParamID
	 , PN.Param_Name
FROM Param_Name PN
CROSS JOIN Areas A) T
LEFT OUTER JOIN Param_Values PV
	ON ISNULL(PV.Param_NameID,-1) = ISNULL(T.ParamID,-1)
	AND ISNULL(PV.AreaID,-1) = ISNULL(T.AreaID,-1)
	AND ISNULL(PV.CustomerID,-1) = ISNULL(T.CustomerID,-1)
	AND ISNULL(PV.EnvironmentID,-1) = ISNULL(T.EnvironmentID,-1)


GO
/****** Object:  Table [dbo].[DeleteTransactions]    Script Date: 23/05/2019 10:55:58 ******/
PRINT '***Creating Table [dbo].[DeleteTransactions]...'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeleteTransactions](
	[ID] [int]  NOT NULL,
	[DeletedTable] [varchar](30) NOT NULL,
	[DeletedValue] [varchar](max) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[RestoreQuery] [varchar](max) NOT NULL,
 CONSTRAINT [PK_DeleteTransactions-v2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
-- Added this - needs to be tested - JL
CREATE TRIGGER [dbo].[TRG_InsteadOfInsert_DeleteTransactions]
   ON  [dbo].[DeleteTransactions]
   INSTEAD OF INSERT NOT FOR REPLICATION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE  @DelID int = (SELECT dbo.udf_GetSequenceNumber('DeleteTransactions','ID'));

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO DeleteTranDeleteTransactions(ID
							,DeletedTable
							,DeletedValue
							,Timestamp
							,RestoreQuery)
			SELECT @DelID
				  ,inserted.DeletedTable
				  ,inserted.DeletedValue
				  ,inserted.Timestamp
				  ,inserted.RestoreQuery
			FROM  inserted

			UPDATE SYS_Sequence
			SET    SequenceNumber = @DelID + 1
			WHERE  TableName = 'DeleteTransactions'
			AND    ColumnName = 'ID'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
	END CATCH
END

GO
ALTER TABLE [dbo].[Param_Values]  WITH CHECK ADD  CONSTRAINT [FK_Param_Values_Areas] FOREIGN KEY([AreaID])
REFERENCES [dbo].[Areas] ([ID])
GO
ALTER TABLE [dbo].[Param_Values] CHECK CONSTRAINT [FK_Param_Values_Areas]
GO
ALTER TABLE [dbo].[Param_Values]  WITH CHECK ADD  CONSTRAINT [FK_Param_Values_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([ID])
GO
ALTER TABLE [dbo].[Param_Values] CHECK CONSTRAINT [FK_Param_Values_Customers]
GO
ALTER TABLE [dbo].[Param_Values]  WITH CHECK ADD  CONSTRAINT [FK_Param_Values_Environments] FOREIGN KEY([EnvironmentID])
REFERENCES [dbo].[Environments] ([ID])
GO
ALTER TABLE [dbo].[Param_Values] CHECK CONSTRAINT [FK_Param_Values_Environments]
GO
ALTER TABLE [dbo].[Param_Values]  WITH CHECK ADD  CONSTRAINT [FK_Param_Values_Param_Name] FOREIGN KEY([Param_NameID])
REFERENCES [dbo].[Param_Name] ([ID])
GO
ALTER TABLE [dbo].[Param_Values] CHECK CONSTRAINT [FK_Param_Values_Param_Name]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdate_ParamValues]    Script Date: 23/05/2019 10:55:58 ******/
PRINT '***Creating StoredProcedure [dbo].[usp_InsertUpdate_ParamValues]...'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro Nogueira
-- Create date: 21/04/2019
-- Description:	Insert/Update parameters into ParamValues table
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertUpdate_ParamValues] 
	-- Add the parameters for the stored procedure here
		@i_sAreaName varchar(50),
		@i_sParamName varchar(50),
		@i_sCustomerName varchar(50) = NULL,
		@i_sEnvironmentName varchar(50) = NULL,
		@i_sParamValue varchar(max)
AS
BEGIN


	DECLARE @nAreaID INT = (SELECT ID
							FROM Areas
							WHERE Area = @i_sAreaName)
		  , @nCustomerID INT = (SELECT ID
								FROM Customers
								WHERE Customer = @i_sCustomerName)
		  , @nEnvironmentID INT = (SELECT ID
								   FROM Environments
								   WHERE Environment = @i_sEnvironmentName)
		  , @nParamID INT = (SELECT ID
							 FROM Param_Name
						 	 WHERE Param_Name = @i_sParamName)


	IF NOT EXISTS(SELECT 1 
				  FROM Param_Values 
				  WHERE AreaID = @nAreaID
				  AND Param_NameID = @nParamID
				  AND ISNULL(EnvironmentID,-1) = ISNULL(@nEnvironmentID,-1)
				  AND ISNULL(CustomerID,-1) = ISNULL(@nCustomerID,-1))
	BEGIN
		INSERT INTO [dbo].[Param_Values]
			   ([AreaID]
			   ,[CustomerID]
			   ,[EnvironmentID]
			   ,[Param_nameID]
			   ,[Param_Value])
		 VALUES
			   (@nAreaID
			  , @nCustomerID
			  , @nEnvironmentID
			  , @nParamID
			  , @i_sParamValue)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[Param_Values]
		SET Param_Value = @i_sParamValue
		WHERE AreaID = @nAreaID
		AND Param_nameID = @nParamID
		AND ISNULL(EnvironmentID,-1) = ISNULL(@nEnvironmentID,-1)
		AND ISNULL(CustomerID,-1) = ISNULL(@nCustomerID,-1)
	END

END

-- JL: Add required v1.1 objects

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO

IF EXISTS (SELECT srv.name 
		   FROM   sys.servers srv 
	   	   WHERE  srv.server_id != 0 
		   AND srv.name = N'REPL-$(ResilientInstanceName)')
	EXEC sp_dropserver 'REPL-$(ResilientInstanceName)','droplogins'

EXEC master.dbo.sp_addlinkedserver @server = N'REPL-$(ResilientInstanceName)', @srvproduct='', @provider='SQLOLEDB', @datasrc=N'$(ResilientInstanceName)'

EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'REPL-$(ResilientInstanceName)',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'collation compatible', @optvalue=N'false'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'data access', @optvalue=N'true'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'dist', @optvalue=N'false'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'pub', @optvalue=N'false'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'rpc', @optvalue=N'true'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'rpc out', @optvalue=N'true'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'sub', @optvalue=N'false'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'connect timeout', @optvalue=N'0'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'collation name', @optvalue=null

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'lazy schema validation', @optvalue=N'false'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'query timeout', @optvalue=N'0'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'use remote collation', @optvalue=N'true'

EXEC master.dbo.sp_serveroption @server=N'REPL-$(ResilientInstanceName)', @optname=N'remote proc transaction promotion', @optvalue=N'true'

GO


PRINT N'Creating [dbo].[SYS_Sequence]...';


GO
CREATE TABLE [dbo].[SYS_Sequence] (
    [TableName]      VARCHAR (100) NOT NULL,
    [ColumnName]     VARCHAR (100) NOT NULL,
    [SequenceNumber] BIGINT        NOT NULL,
    CONSTRAINT [PK_SYS_Sequence] PRIMARY KEY CLUSTERED ([TableName] ASC)
);


GO
PRINT N'Creating [dbo].[SYS_SETTINGS]...';


GO
CREATE TABLE [dbo].[SYS_SETTINGS] (
    [KEY]         VARCHAR (32)  NOT NULL,
    [VALUE]       VARCHAR (MAX) NOT NULL,
    [DESCRIPTION] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_SYS_SETTINGS] PRIMARY KEY CLUSTERED ([KEY] ASC)
);


GO



PRINT N'Creating [dbo].[udf_Get_Parameter_Value]...';


GO

CREATE FUNCTION [dbo].[udf_Get_Parameter_Value](@pi_Param_Name varchar(200))  
RETURNS varchar(200) AS
BEGIN 
  declare  @return_value   varchar(200)

  select @return_value = [VALUE]
  from   SYS_SETTINGS
  where  [KEY] = @pi_Param_Name

  return @return_value
END
GO
PRINT N'Creating [dbo].[udf_GetSequenceNumber]...';


GO
CREATE FUNCTION [dbo].[udf_GetSequenceNumber]
(
	@i_sTableName	VARCHAR(100)
  , @i_sColumnName	VARCHAR(100)
)
RETURNS BIGINT 
AS
BEGIN 
  DECLARE  @nSequenceNumber BIGINT

  SELECT @nSequenceNumber = [SequenceNumber]
  FROM   SYS_Sequence
  WHERE  [TableName] = @i_sTableName
  AND    [ColumnName] = @i_sColumnName

  RETURN @nSequenceNumber
END
GO

GO
PRINT N'Creating [dbo].[CFG_View]...';


GO
CREATE VIEW [dbo].[CFG_View]
AS
	SELECT TOP 100 PERCENT A.Area,
					       C.Customer,
					       E.Environment,
					       PN.Param_name,
						   PV.Description,
					       PV.Param_value
	FROM   dbo.param_values AS PV
	INNER JOIN dbo.param_name AS PN
			ON PV.param_nameid = PN.id
	INNER JOIN dbo.areas AS A
			ON PV.areaid = A.id
	LEFT OUTER JOIN dbo.environments AS E
				ON PV.environmentid = E.id
	LEFT OUTER JOIN dbo.customers AS C
				ON PV.customerid = C.id
	ORDER BY A.Area,
			 C.Customer,
		     E.Environment,
		     PN.Param_name
GO

PRINT N'Creating [dbo].[usp_Get_Job_Status]...';


GO
CREATE PROCEDURE [dbo].[usp_Get_Job_Status]
   @job_name  SYSNAME
AS
SET NOCOUNT ON

DECLARE @job_id          UNIQUEIDENTIFIER
DECLARE @is_idle         INT
declare @status          int

--Check name exists
IF NOT EXISTS(SELECT 1
              FROM   msdb.dbo.sysjobs (nolock)
              where  name=@job_name)
BEGIN
  RAISERROR('The job name specified does not exist',16,1)
  RETURN 1
END

--Temp table to store results of xp_sqlagent_enum_jobs
create table #xp_results (job_id                UNIQUEIDENTIFIER NOT NULL,
                          last_run_date         INT              NOT NULL,
                          last_run_time         INT              NOT NULL,
                          next_run_date         INT              NOT NULL,
                          next_run_time         INT              NOT NULL,
                          next_run_schedule_id  INT              NOT NULL,
                          requested_to_run      INT              NOT NULL,
                          request_source        INT              NOT NULL,
                          request_source_id     sysname          COLLATE database_default NULL,
                          running               INT              NOT NULL,
                          current_step          INT              NOT NULL,
                          current_retry_attempt INT              NOT NULL,
                          job_state             INT              NOT NULL)

--Get the Job ID
EXECUTE  msdb.dbo.sp_verify_job_identifiers  '@job_name', '@job_id', @job_name OUTPUT, @job_id OUTPUT

--Get Job Details
INSERT INTO #xp_results
EXECUTE master.dbo.xp_sqlagent_enum_jobs 1, 'sa', @job_id -- SQLCMD?

--Get Job Status
/*
        1 Executing.
        2 Waiting for thread.
        3 Between retries.
        4 Idle.
        5 Suspended.
        7 Performing completion actions.
*/
SELECT @status=job_state
FROM #xp_results

DROP TABLE #xp_results

return @status
GO


PRINT N'Creating [dbo].[usp_REPL_Add_Article]...';


GO

-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  19th October 2011
-- Description:  This procedure adds an article to a Publication and has replaced
--               the original procedures usp_REPL_Add_Merge_Article and
--               usp_REPL_TXN_Add_Article.
-- =================================================================================
-- Calls:        None
-- Called By:    usp_REPL_Create_Publication_Live_Transactional
--               usp_REPL_Create_Publication_CFG_Transactional
--               usp_REPL_Create_Publication_CFG_Merge
--               usp_REPL_Recreate_Publication_Live_Transactional
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  3rd September 2012
-- Description:  1) Added code for a new Partitioning publication.  This replicates
--                  the partitioning call on the remote site rather than performing 
--                  all changes on the live site and replicating the changes.  This
--                  involves a large number of deletes and takes a lot of resources
--                  unnecessarily in live environments.
--               2) Tidied and used new SQL 2008 functionality where applicable.
--               3) Updated the merge schema options to avoid incompatible property
--                  warnings on install.
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Add_Article] 
   @i_sPubName         sysname
 , @i_sPubType         varchar(15)
 , @i_sArticleName     sysname
 , @i_sArticleType     varchar(50)
AS
DECLARE @nSchemaOption   binary(8)
      , @sType           varchar(16)
      , @sPreCreationCmd varchar(16)
SET NOCOUNT ON

IF @i_sPubType = 'Transactional'
BEGIN
	IF @i_sArticleType = 'table' 
	BEGIN
		SET @nSchemaOption = 0x0000000048045DDD
		SET @sType = 'logbased'
		SET @sPreCreationCmd = 'delete'
	END
	ELSE 
	BEGIN
		SET @nSchemaOption = 0x0000000008000001
		SET @sPreCreationCmd = 'none'
		IF (@i_sArticleType = 'procedure')
		BEGIN
			SET @sType = 'proc exec'
		END
		ELSE
		BEGIN
			SET @sType = @i_sArticleType + ' schema only'
		END
	END

	-- Add the article
	EXEC sp_addarticle @publication = @i_sPubName
					 , @article = @i_sArticleName
					 , @source_owner = N'dbo'
					 , @source_object = @i_sArticleName
					 , @destination_table = @i_sArticleName
					 , @type = @sType
					 , @description = null
					 , @pre_creation_cmd = @sPreCreationCmd
					 , @schema_option = @nSchemaOption
					 , @status = 16
					 , @vertical_partition = N'false'
					 , @filter = null
					 , @sync_object = null
END
ELSE --(@i_sPubType = 'Merge')
BEGIN
	SET @sPreCreationCmd = 'DROP'

    IF @i_sArticleType = 'table' 
	BEGIN
		SET @nSchemaOption = 0x000000B20C034FD1
		SET @sType = 'table'
	END
	ELSE
	BEGIN
		SET @nSchemaOption = 0x0000000008000001
		SET @sType = @i_sArticleType + ' schema only'
	END

	-- Add the merge articles for the retreived function
	EXEC sp_addmergearticle @publication = @i_sPubName
						  , @article = @i_sArticleName
						  , @source_owner = N'dbo'
						  , @source_object = @i_sArticleName
						  , @type = @sType
						  , @description = null
						  , @pre_creation_cmd = @sPreCreationCmd
						  , @creation_script = null
						  , @schema_option = @nSchemaOption
						  , @destination_owner = N'dbo'
						  , @force_reinit_subscription = 1
						  , @column_tracking = N'false'
						  , @vertical_partition = N'false'
						  , @verify_resolver_signature = 1
						  , @allow_interactive_resolver = N'false'
						  , @fast_multicol_updateproc = N'true'
						  , @subset_filterclause = null
						  , @destination_object = @i_sArticleName
						  , @check_permissions = 0
						  , @subscriber_upload_options = 0                          
						  , @force_invalidate_snapshot = 1
						  , @delete_tracking = N'true'
						  , @compensate_for_errors = N'false'
						  , @stream_blob_columns = N'false'
						  , @partition_options = 0

END
GO
PRINT N'Creating [dbo].[usp_REPL_Create_LogReader_Job]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  27th August 2010
-- Description:  This procedure Creates the Log Reader Job for a Transactional 
--               Publication
-- =================================================================================
-- Calls:        None.
-- Called By:    usp_REPL_Setup_Replication.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Renamed the procedure 
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Create_LogReader_Job]
   @i_sJobName     sysname
 , @i_sPublisher   sysname
 , @i_sDistributor sysname
 
AS
  set nocount on
  
  -- get replication details
  declare @sReplUser   varchar(100)
        , @sSchedName  varchar(100)
        , @nJobID      binary(16)  
        , @nReturnCode int    
        , @nAgentId    int
        , @sCommand    nvarchar(max)

  
  set @sReplUser   = dbo.udf_Get_Parameter_Value('REPL_Admin_User')
  set @sSchedName  = 'Replication agent schedule - ' + @i_sJobName
  set @nAgentId    = ident_current('distribution..MSlogReader_agents') + 1
  set @nReturnCode = 0

  if @nAgentId is null 
    set @nAgentId = 1
  
  -- create the REPL-Merge category if it doesn't exist
  if not exists (SELECT 1
                 FROM   msdb.dbo.syscategories
                 WHERE  name = N'REPL-LogReader')
    exec msdb.dbo.sp_add_category @name = N'REPL-LogReader'

  -- Delete the job with the same name (if it exists)
  SELECT @nJobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE  name = @i_sJobName

  if @nJobID is not null begin
    -- Delete the [local] job 
    exec msdb.dbo.sp_delete_job @job_name = @i_sJobName
    select @nJobID = NULL
  end 

  -- Add the job
  exec @nReturnCode = msdb.dbo.sp_add_job @job_id = @nJobID OUTPUT
                                        , @job_name = @i_sJobName
		                                , @owner_login_name = @sReplUser
		                                , @description = N'No description available.'
		                                , @category_name = N'REPL-LogReader'
		                                , @enabled = 1
		                                , @notify_level_email = 0
		                                , @notify_level_page = 0
                       	                , @notify_level_netsend = 0
		                                , @notify_level_eventlog = 0
		                                , @delete_level = 0 


  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job steps
  set @sCommand = 'sp_MSadd_LogReader_history @perfmon_increment = 0, ' +
                  '@agent_id = ' + convert(varchar, @nAgentId) + ', ' +
                  '@runstatus = 1, @comments = ''Starting agent.'''

  exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                            , @step_id = 1
                                            , @step_name = N'Distribution Agent startup message.'
                                            , @command = @sCommand
                                            , @database_name = N'distribution'
                                            , @server = @i_sPublisher
                                            , @subsystem = N'TSQL'
                                            , @cmdexec_success_code = 0
                                            , @flags = 0
                                            , @retry_attempts = 0
                                            , @retry_interval = 0
                                            , @on_success_step_id = 0
                                            , @on_success_action = 3
                                            , @on_fail_step_id = 0
                                            , @on_fail_action = 3
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
 
  set @sCommand = '-Publisher [' + @i_sPublisher + '] ' +
                  '-PublisherDB [$(DatabaseName)] ' +
                  '-Distributor [' + @i_sDistributor + '] ' +
                  '-DistributorSecurityMode 1 ' +
                  '-Continuous'

  exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                            , @step_id = 2
                                            , @step_name = N'Run agent.'
                                            , @command = @sCommand
                                            , @database_name = N'distribution'
                                            , @server = @i_sPublisher
                                            , @subsystem = N'LogReader'
                                            , @cmdexec_success_code = 0
                                            , @flags = 0
                                            , @retry_attempts = 10
                                            , @retry_interval = 1
                                            , @on_success_step_id = 0
                                            , @on_success_action = 1
                                            , @on_fail_step_id = 0
                                            , @on_fail_action = 3
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  set @sCommand = 'sp_MSdetect_nonlogged_shutdown @subsystem = ''LogReader'', ' +
                  '@agent_id = ' + convert(varchar, @nAgentId)
  exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                            , @step_id = 3
                                            , @step_name = N'Detect nonlogged agent shutdown.'
                                            , @command = @sCommand
                                            , @database_name = N'distribution'
                                            , @server = @i_sPublisher
                                            , @subsystem = N'TSQL'
                                            , @cmdexec_success_code = 0
                                            , @flags = 0
                                            , @retry_attempts = 0
                                            , @retry_interval = 0
                                            , @on_success_step_id = 0
                                            , @on_success_action = 2
                                            , @on_fail_step_id = 0
                                            , @on_fail_action = 2
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
 
  exec @nReturnCode = msdb.dbo.sp_update_job @job_id = @nJobID
                                           , @start_step_id = 1 
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job schedules (job is to run every 5 minutes!)
  EXECUTE @nReturnCode = msdb.dbo.sp_add_schedule @schedule_name = @sSchedName
                                                , @enabled = 1
                                                , @freq_type = 64
                                                , @active_start_date = 20000101
                                                , @active_start_time = 0
                                                , @freq_interval = 0
                                                , @freq_subday_type = 0
                                                , @freq_subday_interval = 0
                                                , @freq_relative_interval = 0
                                                , @freq_recurrence_factor = 0
                                                , @active_end_date = 99991231
                                                , @active_end_time = 235900
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  exec msdb.dbo.sp_attach_schedule @job_name = @i_sJobName,
                                   @schedule_name = @sSchedName



  -- Add the Target Servers
  EXECUTE @nReturnCode = msdb.dbo.sp_add_jobserver @job_id = @nJobID
                                                 , @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  GOTO   EndSave              

QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 

EndSave:
GO
PRINT N'Creating [dbo].[usp_REPL_Create_QueueReader_Job]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  27th August 2010
-- Description:  This procedure Creates the Queue Reader Job for a Transactional 
--               Publication
-- =================================================================================
-- Calls:        none
-- Called By:    usp_REPL_Setup_Replication.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Renamed the procedure 
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Create_QueueReader_Job]
   @i_sJobName     sysname
 , @i_sPublisher   sysname
 , @i_sDistributor sysname
AS
  set nocount on
  
  -- get replication details
  declare @sReplUser   varchar(100)
        , @sSchedName  varchar(100)
        , @nAgentId    int
        , @nJobID      binary(16)  
        , @nReturnCode int    
        , @sCommand    nvarchar(max)
  
  set @sReplUser   = dbo.udf_Get_Parameter_Value('REPL_Admin_User')
  set @sSchedName  = 'Replication agent schedule - ' + @i_sJobName
  set @nAgentId    = ident_current('distribution..MSqReader_agents') + 1
  set @nReturnCode = 0


  
  if @nAgentId is null 
    set @nAgentId = 1
  
  -- create the REPL-Merge category if it doesn't exist
  if not exists (SELECT 1
                 FROM   msdb.dbo.syscategories
                 WHERE  name = N'REPL-QueueReader')
    exec msdb.dbo.sp_add_category @name = N'REPL-QueueReader'

  -- Delete the job with the same name (if it exists)
  SELECT @nJobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE  name = @i_sJobName

  if @nJobID is not null
  begin
    -- Delete the [local] job 
    exec msdb.dbo.sp_delete_job @job_name = @i_sJobName
    select @nJobID = NULL
  end 

  -- Add the job
  exec @nReturnCode = msdb.dbo.sp_add_job @job_id = @nJobID OUTPUT
                                        , @job_name = @i_sJobName
		                                , @owner_login_name = @sReplUser
		                                , @description = N'Reads queues for Queued updating subscriptions.'
		                                , @category_name = N'REPL-QueueReader'
		                                , @enabled = 1
		                                , @notify_level_email = 0
		                                , @notify_level_page = 0
                       	                , @notify_level_netsend = 0
		                                , @notify_level_eventlog = 0
		                                , @delete_level = 0 

  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job steps
  set @sCommand = 'sp_MSadd_qReader_history @perfmon_increment = 0, ' +
                  '@agent_id = ' + convert(varchar, @nAgentId) + ', ' +
                  '@runstatus = 1, @comments = ''Starting agent.'''

  exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                            , @step_id = 1
                                            , @step_name = N'Distribution Agent startup message.'
                                            , @command = @sCommand
                                            , @database_name = N'distribution'
                                            , @server = @i_sPublisher
                                            , @subsystem = N'TSQL'
                                            , @cmdexec_success_code = 0
                                            , @flags = 0
                                            , @retry_attempts = 0
                                            , @retry_interval = 0
                                            , @on_success_step_id = 0
                                            , @on_success_action = 3
                                            , @on_fail_step_id = 0
                                            , @on_fail_action = 3
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
 
  set @sCommand = '-Distributor [' + @i_sDistributor + '] ' +
                  '-DistributionDB [Distribution]' +
                  '-DistributorSecurityMode 1 ' +
                  '-Continuous'

  exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                            , @step_id = 2
                                            , @step_name = N'Run agent.'
                                            , @command = @sCommand
                                            , @database_name = N'distribution'
                                            , @server = @i_sPublisher
                                            , @subsystem = N'QueueReader'
                                            , @cmdexec_success_code = 0
                                            , @flags = 0
                                            , @retry_attempts = 10
                                            , @retry_interval = 1
                                            , @on_success_step_id = 0
                                            , @on_success_action = 1
                                            , @on_fail_step_id = 0
                                            , @on_fail_action = 3
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  set @sCommand = 'sp_MSdetect_nonlogged_shutdown @subsystem = ''QueueReader'', ' +
                  '@agent_id = ' + convert(varchar, @nAgentId)

  exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                            , @step_id = 3
                                            , @step_name = N'Detect nonlogged agent shutdown.'
                                            , @command = @sCommand
                                            , @database_name = N'distribution'
                                            , @server = @i_sPublisher
                                            , @subsystem = N'TSQL'
                                            , @cmdexec_success_code = 0
                                            , @flags = 0
                                            , @retry_attempts = 0
                                            , @retry_interval = 0
                                            , @on_success_step_id = 0
                                            , @on_success_action = 2
                                            , @on_fail_step_id = 0
                                            , @on_fail_action = 2
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
 
  exec @nReturnCode = msdb.dbo.sp_update_job @job_id = @nJobID
                                           , @start_step_id = 1 
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job schedules (job is to run every 5 minutes!)
  EXECUTE @nReturnCode = msdb.dbo.sp_add_schedule @schedule_name = @sSchedName
                                                , @enabled = 1
                                                , @freq_type = 64
                                                , @active_start_date = 20000101
                                                , @active_start_time = 0
                                                , @freq_interval = 0
                                                , @freq_subday_type = 0
                                                , @freq_subday_interval = 0
                                                , @freq_relative_interval = 0
                                                , @freq_recurrence_factor = 0
                                                , @active_end_date = 99991231
                                                , @active_end_time = 235900
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  exec msdb.dbo.sp_attach_schedule @job_name = @i_sJobName
                                 , @schedule_name = @sSchedName



  -- Add the Target Servers
  EXECUTE @nReturnCode = msdb.dbo.sp_add_jobserver @job_id = @nJobID
                                                 , @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

  GOTO   EndSave              

QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 

EndSave:
GO
PRINT N'Creating [dbo].[usp_REPL_Create_Replicate_Job]...';


GO
-- =================================================================================
-- Author:       ?
-- Create Date:  ?
-- Description:  This creates a Merge Job for a Merge Publication
-- =================================================================================
-- Calls:        none.
-- Called By:    usp_REPL_Add_Merge_Subscription.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  27th August 2010
-- Description:  Procedure altered so that the schedule is set up differently
--               depending on whether it is for CFG or CFG_TRACK tables
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Procedure altered to combine the Merge and Transactional versions
--               and renamed the procedure as 'Merge' was not appropriate for 
--               other methods of replication
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  19th January 2012
-- Description:  Amended Procedure to run on a 5 minute cycle rather than 10 minutes
--               when it is not set to run continuously
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th July 2012
-- Description:  Amended Procedure as there is no longer a distinction between the 
--               Replicate Jobs for Transactional Live and Transactional Config
--               publications
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  4th September 2012
-- Description:  1) Added code for a new Partitioning publication.  This replicates
--                  the partitioning call on the remote site rather than performing 
--                  all changes on the live site and replicating the changes.  This
--                  involves a large number of deletes and takes a lot of resources
--                  unnecessarily in live environments.
--               2) Tidied and used new SQL 2008 functionality where applicable. 
--               3) Removed the job schedule for transactional replication jobs.
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  11th September 2012
-- Description:  Added a job schedule for the partitioning publication.  This stops
--               the distribution database getting too big due to the way that the 
--               distribution cleanup job works.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  28th May 2013
-- Description:  Removed the check for the Replication type for the job schedule 
--               creation as this is now required for all jobs.
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Create_Replicate_Job]
   @i_sPubName     sysname
 , @i_sPubType     varchar(15)
 , @i_sJobName     sysname
 , @i_sPublisher   sysname
 , @i_sDistributor sysname
 , @i_sSubscriber  sysname
 , @i_sReplUser    sysname
AS
DECLARE @sSchedName  varchar(100) = 'Replication agent schedule - ' + @i_sJobName
      , @nAgentId    int
      , @nJobID      binary(16)  
      , @nReturnCode int = 0 
      , @sCommand    nvarchar(500)
      , @sCategory   varchar(20)
      , @sSubSystem  varchar(20)
	  , @sDatabaseName varchar(50) = ''

SET NOCOUNT ON
  
IF @i_sPubType = 'Merge'
BEGIN
    set @nAgentId = ident_current('distribution..MSmerge_agents') + 1
    set @sCategory = N'REPL-Merge'
    set @sSubSystem = 'Merge'

	if not exists (SELECT 1
				   FROM   msdb.dbo.syscategories
				   WHERE  name = N'REPL-Merge')
		exec msdb.dbo.sp_add_category @name = N'REPL-Merge'  
END
  
IF @i_sPubType = 'Transactional'
BEGIN
    set @nAgentId = ident_current('distribution..MSdistribution_agents') + 1
    set @sCategory = N'REPL-Distribution'
    set @sSubSystem = 'Distribution'

	if not exists (SELECT 1
				   FROM   msdb.dbo.syscategories
				   WHERE  name = N'REPL-Distribution')
		exec msdb.dbo.sp_add_category @name = N'REPL-Distribution'
END
  
if @nAgentId is null set @nAgentId = 1

-- Delete the job with the same name (if it exists)
SELECT @nJobID = job_id     
FROM   msdb.dbo.sysjobs    
WHERE  name = @i_sJobName

if @nJobID is not null 
begin
	-- Delete the [local] job 
	exec msdb.dbo.sp_delete_job @job_name = @i_sJobName
	select @nJobID = NULL
end 

-- Add the job
exec @nReturnCode = msdb.dbo.sp_add_job @job_id = @nJobID OUTPUT
                                      , @job_name = @i_sJobName
                                      , @owner_login_name = @i_sReplUser
                                      , @description = N'No description available.'
                                      , @category_name = @sCategory
                                      , @enabled = 1
                                      , @notify_level_email = 0
                                      , @notify_level_page = 0
                                      , @notify_level_netsend = 0
                                      , @notify_level_eventlog = 2
                                      , @delete_level= 0
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

-- Add the job steps
IF @i_sPubType = 'Merge'
	set @sCommand = 'sp_MSadd_merge_history @perfmon_increment = 0, ' +
					'@agent_id = ' + convert(varchar, @nAgentId) + ', ' +
					'@runstatus = 1, @comments = ''Starting agent.'''

IF @i_sPubType = 'Transactional'
	set @sCommand = 'sp_MSadd_distribution_history @perfmon_increment = 0, ' +
					'@agent_id = ' + convert(varchar, @nAgentId) + ', ' +
					'@runstatus = 1, @comments = ''Starting agent.'''

exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                          , @step_id = 1
                                          , @step_name = N'Agent startup message.'
                                          , @command = @sCommand
                                          , @database_name = N'distribution'
                                          , @server = @i_sPublisher
                                          , @database_user_name = N''
                                          , @subsystem = N'TSQL'
                                          , @cmdexec_success_code = 0
                                          , @flags = 0
                                          , @retry_attempts = 0
                                          , @retry_interval = 0
                                          , @on_success_step_id = 0
                                          , @on_success_action = 3
                                          , @on_fail_step_id = 0
                                          , @on_fail_action = 3
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
 
set @sCommand = '-Publisher [' + @i_sPublisher + '] ' +
                '-PublisherDB [$(DatabaseName)] ' +
                '-Publication [' + @i_sPubName + '] ' +
                '-Subscriber [' + @i_sSubscriber + '] ' +
                '-SubscriberDB [$(DatabaseName)] ' +
                '-Distributor [' + @i_sDistributor + '] ' +
                '-DistributorSecurityMode 1 '

IF (@i_sPubType = 'Transactional' AND @i_sPubName != 'Partitioning')
    SET @sCommand = @sCommand + '-Continuous'

exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                          , @step_id = 2
                                          , @step_name = N'Run agent.'
                                          , @command = @sCommand
                                          , @database_name = N'distribution'
                                          , @server = @i_sPublisher
                                          , @database_user_name = N''
                                          , @subsystem = @sSubSystem
                                          , @cmdexec_success_code = 0
                                          , @flags = 0
                                          , @retry_attempts = 10
                                          , @retry_interval = 1
                                          , @on_success_step_id = 0
                                          , @on_success_action = 1
                                          , @on_fail_step_id = 0
                                          , @on_fail_action = 3
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

set @sCommand = 'sp_MSdetect_nonlogged_shutdown @subsystem = ''' + @sSubSystem + ''', ' +
                '@agent_id = ' + convert(varchar, @nAgentId)
                 
exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                          , @step_id = 3
                                          , @step_name = N'Detect nonlogged agent shutdown.'
                                          , @command = @sCommand
                                          , @database_name = N'distribution'
                                          , @server = @i_sPublisher
                                          , @database_user_name = N''
                                          , @subsystem = N'TSQL'
                                          , @cmdexec_success_code = 0
                                          , @flags = 0
                                          , @retry_attempts = 0
                                          , @retry_interval = 0
                                          , @on_success_step_id = 0
                                          , @on_success_action = 2
                                          , @on_fail_step_id = 0
                                          , @on_fail_action = 2
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
 
exec @nReturnCode = msdb.dbo.sp_update_job @job_id = @nJobID 
                                        , @start_step_id = 1 
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

-- Add the job schedules (job is to run every 5 minutes!)
EXECUTE @nReturnCode = msdb.dbo.sp_add_schedule @schedule_name = @sSchedName
												, @enabled = 1
												, @freq_type = 4
												, @active_start_date = 20000101
												, @active_start_time = 000
												, @freq_interval = 1
												, @freq_subday_type = 4
												, @freq_subday_interval = 5
												, @freq_relative_interval = 2
												, @freq_recurrence_factor = 0
												, @active_end_date = 99991231
												, @active_end_time = 235900
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 


exec msdb.dbo.sp_attach_schedule @job_name = @i_sJobName
		                        , @schedule_name = @sSchedName

-- Add the Target Servers
EXECUTE @sCommand = msdb.dbo.sp_add_jobserver @job_id = @nJobID
                                            , @server_name = N'(local)' 
IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 

GOTO   EndSave              

QuitWithRollback:
IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 

EndSave:
GO
PRINT N'Creating [dbo].[usp_REPL_Create_Snapshot_Job]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  27th August 2010
-- Description:  This procedure Creates the Snapshot Job for a Transactional 
--               Publication
-- =================================================================================
-- Calls:        none
-- Called By:    usp_REPL_TXN_Add_Publication.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Procedure altered to combine the Merge and Transactional versions
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Create_Snapshot_Job]
   @i_sPubName     sysname
 , @i_sPubType     varchar(15)
 , @i_sJobName     sysname
 , @i_sPublisher   sysname
 , @i_sDistributor sysname
 , @i_sReplUser    sysname
AS
  set nocount on
  
  declare @nAgentId  int
        , @nJobID      BINARY(16)  
        , @nReturnCode INT    
        , @sCommand    nvarchar(400)
  
  -- get the next avaiable agent ID for the job
  set @nAgentId = ident_current('distribution..MSsnapshot_agents') + 1
  set @nReturnCode = 0     
  
  if @nAgentId is null 
      set @nAgentId = 1
  
  -- now create the job itself
  BEGIN TRANSACTION
  
  -- check that the REPL_Snapshot category exists
  IF not exists (SELECT 1
                 FROM   msdb.dbo.syscategories
                 WHERE  name = N'REPL-Snapshot')
    EXECUTE msdb.dbo.sp_add_category @name = N'REPL-Snapshot'
  
  -- Delete the job with the same name (if it exists)
  SELECT @nJobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE (name = @i_sJobName)
  
  IF (@nJobID IS NOT NULL)  
  BEGIN  
    exec msdb.dbo.sp_delete_job @job_name = @i_sJobName 

    SELECT @nJobID = NULL
  END 
  
  BEGIN
    -- Add the job
    EXECUTE @nReturnCode = msdb.dbo.sp_add_job @job_id = @nJobID OUTPUT
                                             , @job_name = @i_sJobName
                                             , @owner_login_name = @i_sReplUser
                                             , @description = N'No description available.'
                                             , @category_name = N'REPL-Snapshot'
                                             , @enabled = 1
                                             , @notify_level_email = 0
                                             , @notify_level_page = 0
                                             , @notify_level_netsend = 0
                                             , @notify_level_eventlog = 0
                                             , @delete_level= 0
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
  
    -- Add the job steps
    set @sCommand = 'sp_MSadd_snapshot_history @perfmon_increment = 0,' +
                    ' @agent_id = ' + convert(varchar, @nAgentId) + ',' +
                    ' @runstatus = 1,' +
                    ' @comments = ''Starting agent.'''
  
    exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                              , @step_id = 1
                                              , @step_name = N'Snapshot Agent startup message.'
                                              , @command = @sCommand
                                              , @database_name = N'distribution'
                                              , @server = @i_sPublisher
                                              , @database_user_name = N''
                                              , @subsystem = N'TSQL'
                                              , @cmdexec_success_code = 0
                                              , @flags = 0, @retry_attempts = 0
                                              , @retry_interval = 0
                                              , @output_file_name = N''
                                              , @on_success_step_id = 0
                                              , @on_success_action = 3
                                              , @on_fail_step_id = 0
                                              , @on_fail_action = 3
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 
  
    IF @i_sPubType = 'Merge'
        set @sCommand = N'-Publisher [' + @i_sPublisher + '] -PublisherDB [$(DatabaseName)] ' +
                         '-Distributor [' + @i_sDistributor + '] -Publication [' + @i_sPubName + '] ' +
                         '-ReplicationType 2 -DistributorSecurityMode 1 '

    IF @i_sPubType = 'Transactional'
	    set @sCommand = N'-Publisher [' + @i_sPublisher + '] -PublisherDB [$(DatabaseName)] ' +
		                 '-Distributor [' + @i_sDistributor + '] -Publication [' + @i_sPubName + '] ' +
			             '-DistributorSecurityMode 1 '

    exec @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                              , @step_id = 2
                                              , @step_name = N'Run agent.'
                                              , @command = @sCommand
                                              , @database_name = N'distribution'
                                              , @server = @i_sPublisher
                                              , @database_user_name = N''
                                              , @subsystem = N'Snapshot'
                                              , @cmdexec_success_code = 0
                                              , @flags = 0
                                              , @retry_attempts = 10
                                              , @retry_interval = 1
                                              , @output_file_name = N''
                                              , @on_success_step_id = 0
                                              , @on_success_action = 1
                                              , @on_fail_step_id = 0
                                              , @on_fail_action = 3
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 
  
    set @sCommand = N'sp_MSdetect_nonlogged_shutdown @subsystem = ''Snapshot'',' +
                     ' @agent_id = ' + convert(varchar, @nAgentId)

    EXECUTE @nReturnCode = msdb.dbo.sp_add_jobstep @job_id = @nJobID
                                                 , @step_id = 3
                                                 , @step_name = N'Detect nonlogged agent shutdown.'
                                                 , @command = @sCommand
                                                 , @database_name = N'distribution'
                                                 , @server = @i_sPublisher
                                                 , @database_user_name = N''
                                                 , @subsystem = N'TSQL'
                                                 , @cmdexec_success_code = 0
                                                 , @flags = 0
                                                 , @retry_attempts = 0
                                                 , @retry_interval = 0
                                                 , @output_file_name = N''
                                                 , @on_success_step_id = 0
                                                 , @on_success_action = 2
                                                 , @on_fail_step_id = 0
                                                 , @on_fail_action = 2
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 
  
    EXECUTE @nReturnCode = msdb.dbo.sp_update_job @job_id = @nJobID
                                                , @start_step_id = 1 
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
  
    -- Add the job schedules
    EXECUTE @nReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @nJobID
                                                     , @name = N'Replication agent schedule.'
                                                     , @enabled = 1
                                                     , @freq_type = 1
                                                     , @active_start_date = 20050218
                                                     , @active_start_time = 500
                                                     , @freq_interval = 1
                                                     , @freq_subday_type = 1
                                                     , @freq_subday_interval = 5
                                                     , @freq_relative_interval = 1
                                                     , @freq_recurrence_factor = 0
                                                     , @active_end_date = 99991231
                                                     , @active_end_time = 235959
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback
  
    -- Add the Target Servers
    EXECUTE @nReturnCode = msdb.dbo.sp_add_jobserver @job_id = @nJobID
	                                               , @server_name = N'(local)' 
    IF (@@ERROR <> 0 OR @nReturnCode <> 0) GOTO QuitWithRollback 
  
  END

  COMMIT TRANSACTION
  GOTO EndSave

QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave:
GO
PRINT N'Creating [dbo].[usp_REPL_CreateDefaultData]...';


GO
CREATE PROCEDURE [dbo].[usp_REPL_CreateDefaultData]
AS
BEGIN TRY
    
	IF NOT EXISTS (SELECT 1
	               FROM   SYS_SETTINGS
				   WHERE  [Key] = 'REPL_Enabled')
	BEGIN
		
		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_Enabled'
			  , 'False'
			  , 'The Flag to Specify whether Replication has been implemented')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_Admin_User'
			  , '$(REPL_Admin_User)' -- SQLCMD?
			  , 'The SQL Administrator Windows Account used for Replication')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_DB_Datafile_Location' -- SQLCMD?
			  , '$(Distribution_DataPath)\Distribution\Datafile'
			  , 'The Location for the Distribution Database Datafile')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_DB_Logfile_Location' -- SQLCMD?
			  , '$(Distribution_LogPath)\Distribution\Logfile'
			  , 'The Location for the Distribution Database Logfile')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_Distributor'
			  , '$(InstanceName)' -- SQLCMD?
			  , 'The Local Machine Instance Name (The Distributor)')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_Publisher'
			  , '$(InstanceName)' -- SQLCMD?
			  , 'The Local Machine Instance Name (The Publisher)')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_Subscriber'
			  , '$(ResilientInstanceName)' -- SQLCMD?
			  , 'The Resilient Machine Instance Name (The Subscriber)')

		INSERT INTO [dbo].[SYS_SETTINGS] ( [KEY]
										 , VALUE
										 , [DESCRIPTION] )
		VALUES ('REPL_Working_Directory'
			  , '\\$(MachineName)\Replication Data' -- SQLCMD? (could use SQLCMD for primary for first part
			  , 'The unc Directory for Replication Data')
	END
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE()

	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
END CATCH
GO
PRINT N'Creating [dbo].[usp_REPL_Drop_Publication]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  19th October 2011
-- Description:  This procedure Drops a Publication. It has replaced the original
--               procedures usp_REPL_Drop_Merge_Publication and 
--               usp_REPL_TXN_Drop_Publication.
-- =================================================================================
-- Calls:        None.
-- Called By:    None.
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  17th January 2012
-- Description:  Amended Procedure to use new Linked Server as the implementation
--               of Replication was causing the Linked Server to not allow remote 
--               Procedure calls for other DBs
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Drop_Publication]
  @i_sPubName    sysname
AS
  declare @sSubscriber    sysname
        , @sPublisher     sysname
        , @sJobName       sysname
        , @nPublications  int
        , @sQReader       sysname
        , @sLogReader     sysname
        , @sPubType       varchar(15)
        
  set @sPublisher  = dbo.udf_Get_Parameter_Value('REPL_Publisher')
  set @sSubscriber = dbo.udf_Get_Parameter_Value('REPL_Subscriber')

  SELECT @sPubType = CASE WHEN publication_type = 0 THEN 'Transactional'
                          WHEN publication_type = 2 THEN 'Merge'
                     END
  FROM   distribution.dbo.MSpublications
  WHERE  publication = @i_sPubName

   
  IF @sPubType = 'Transactional'
  BEGIN
	  SELECT @nPublications = COUNT(*)
	  FROM   distribution.dbo.MSpublications
	  WHERE  publication_type = 0

	  IF @nPublications = 1
		BEGIN
		  set @sQReader    = '$(DatabaseName) Replication - Transaction Queue Reader'
		  set @sLogReader  = '$(DatabaseName) Replication - Transaction Log Reader'

		  print 'Stopping the Log Reader and Queue Reader Jobs'

		  exec msdb.dbo.sp_stop_job @sLogReader
		  exec msdb.dbo.sp_stop_job @sQReader
		END

	  -- drop the subscription
	  exec sp_dropsubscription @publication = @i_sPubName
							 , @article = 'all'
							 , @subscriber = @sSubscriber
							 , @destination_db = N'$(DatabaseName)'

	  -- cleanup the subscriber
	  exec [REPL-$(ResilientInstanceName)].[$(DatabaseName)].dbo.sp_subscription_cleanup @publisher = @sPublisher -- Need to change the exec statement too
															 , @publisher_db = N'$(DatabaseName)'
															 , @publication = @i_sPubName

	  -- drop the publication
	  exec sp_droppublication @publication = @i_sPubName

  END
  
  if exists (SELECT 1
             FROM   msdb.dbo.sysjobs
             WHERE  name = '$(DatabaseName) Replication - Snapshot ' + @i_sPubName)
  BEGIN
    set @sJobName = '$(DatabaseName) Replication - Snapshot ' + @i_sPubName
    exec msdb.dbo.sp_delete_job @job_name = @sJobName
  END

  if exists (SELECT 1
             FROM   msdb.dbo.sysjobs
             WHERE  name = '$(DatabaseName) Replication - ' + @i_sPubName)
  BEGIN
    set @sJobName = '$(DatabaseName) Replication - ' + @i_sPubName
    exec msdb.dbo.sp_delete_job @job_name = @sJobName
  END
GO
PRINT N'Creating [dbo].[usp_REPL_Remove_Replication]...';


GO
-- =================================================================================
-- Author:       ?
-- Create Date:  ?
-- Description:  This procedure Removes Replication
-- =================================================================================
-- Calls:        None.
-- Called By:    None.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  27th August 2010
-- Description:  Procedure altered as Transactional Replication is used now for 
--               multiple publications so only remove log reader and queue reader at 
--               this stage rather than the drop publication stage. Also tidied the 
--               procedure so that only values required are declared and set.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Amended to use new Job Names that confirm to naming conventions
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th January 2012
-- Description:  Added some checks in to check whether all publications have been
--               dropped before attempting to remove the DB's Replication and also
--               to check whether other DBs are still published for replication
--               before dropping the Distribution DB.
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Remove_Replication]
AS
  set nocount on
  
  -- get replication details
  declare @sSQLStmt     nvarchar(256)
  declare @sSubscriber  sysname
  declare @sPublisher   sysname
  declare @sJobName     sysname
  declare @bRemove      bit
  declare @nPubExists   TINYINT
  declare @nReplDBs     TINYINT

  set @sSubscriber = dbo.udf_Get_Parameter_Value('REPL_Subscriber')
  set @sPublisher  = dbo.udf_Get_Parameter_Value('REPL_Publisher')

  SET @sSQLStmt = 'SELECT @nPubExists = 1'
	 + CHAR(13) + 'FROM   distribution.dbo.MSpublications'
	 + CHAR(13) + 'WHERE  publisher_db = ''$(DatabaseName)'''

  EXECUTE sp_executesql @sSQLStmt, @params = N'@nPubExists TINYINT OUTPUT', @nPubExists = @nPubExists OUTPUT

  IF @nPubExists IS NULL
      SET @bRemove = 'True'
  ELSE 
      SET @bRemove = 'False'
	  
  IF @bRemove = 'True'
  BEGIN 
	  if exists (SELECT 1
				 FROM   msdb.dbo.sysjobs
				 WHERE  name = '$(DatabaseName) Replication - Transaction Log Reader')
	  BEGIN
		set @sJobName = '$(DatabaseName) Replication - Transaction Log Reader'
		exec msdb.dbo.sp_delete_job @job_name = @sJobName
	  END

	  if exists (SELECT 1
				 FROM   msdb.dbo.sysjobs
				 WHERE  name = '$(DatabaseName) Replication - Transaction Queue Reader')
	  BEGIN
		set @sJobName = '$(DatabaseName) Replication - Transaction Queue Reader'
		exec msdb.dbo.sp_delete_job @job_name = @sJobName
	  END

	  -- Remove the merge replication option from the database
	  exec sp_replicationdboption @dbname = N'$(DatabaseName)'
								, @optname = N'merge publish'
								, @value = N'false'

	  exec sp_replicationdboption @dbname = N'$(DatabaseName)'
								, @optname = N'Publish'
								, @value = N'false'

	  -- update SYS_Settings
	  update SYS_SETTINGS
	  set value = 'false'
	  where [KEY] = 'REPL_Enabled'

	  SET @sSQLStmt = 'SELECT @nREPLDBs = 1'
		 + CHAR(13) + 'FROM   sys.Databases'
		 + CHAR(13) + 'WHERE  is_published = ''True'''
		 + CHAR(13) + 'OR     is_merge_published = ''True'''

	  EXECUTE sp_executesql @sSQLStmt, @params = N'@nREPLDBs TINYINT OUTPUT', @nREPLDBs = @nREPLDBs OUTPUT

	  IF @nREPLDBs IS NULL
		  SET @bRemove = 'True'
	  ELSE 
		  SET @bRemove = 'False'
	  
	  IF @bRemove = 'True'
	  BEGIN 
		  -- Unregister the Subscriber
		  exec sp_dropsubscriber @subscriber = @sSubscriber,
								 @reserved = N'drop_subscriptions'

		  -- now drop the distribution database
		  exec sp_dropdistpublisher @publisher = @sPublisher
								  , @no_checks = 1
		  exec sp_dropdistributiondb @database = 'distribution'
		  exec sp_dropdistributor @no_checks = 1
	  END
	  ELSE
		  PRINT 'Cannot completely remove replication as databases are still published for replication'

  END
  ELSE
      PRINT 'Publications Still Exist for Reactor therefore Replication cannot be removed'
GO
PRINT N'Creating [dbo].[usp_REPL_Setup_Replication]...';


GO
-- =================================================================================
-- Author:       ?
-- Create Date:  ?
-- Description:  This procedure Sets up Replication so that it can be implemented
-- =================================================================================
-- Calls:        usp_REPL_CreateDefaultData
--				
-- Called By:    None.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  11th January 2010
-- Description:  Procedure amended so that Transactional Replication is enabled as
--               well as Merge Replication
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  27th August 2010
-- Description:  Procedure altered as Transactional Replication is used now for 
--               multiple publications and also tidied the procedure so that only
--               values required are declared and set.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  23rd August 2011
-- Description:  Removed the Hardcoded Distributor_Admin password as a) this should 
--               not be set in the scripts and b) this should not be needed as only
--               needs to be set for remote distributors
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  19th October 2011
-- Description:  Amended Procedure to rename the Log and Queue Reader Jobs and
--               to create default Replication Data if not present at initialisation
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  25th October 2011
-- Description:  Added the configuration of the maximum replication text size as  
--               this was set too small to cope with varchar(max) columns
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th January 2012
-- Description:  Added a check to see if the Distrubution Database has already been 
--               defined on this server.  If it has then it does not attempt to 
--               redefine it.  Also reordered the procedure to carry out the tasks
--               in a sensible order.
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Update Date:  13th June 2012
-- Description:  Amended Procedure to use a SQLCMD Variable for the Distribution 
--               Database Size as the default sizes are so small that it causes
--               disk fragmentation
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Setup_Replication]
AS

set nocount on

  -- get replication details
  declare @sDistributor        sysname
  declare @sPublisher          sysname
  declare @sSubscriber         sysname
  declare @sLogreader          varchar(100)
  declare @sQreader            varchar(100)
  declare @sDatafileLocation   varchar(500)
  declare @sLogfileLocation    varchar(500)
  declare @sWorkingDir         varchar(500)
  
  EXEC usp_REPL_CreateDefaultData

  exec sp_configure 'max text repl size', 2147483647
  RECONFIGURE

  set @sDistributor       = dbo.udf_Get_Parameter_Value('REPL_Distributor')
  set @sPublisher         = dbo.udf_Get_Parameter_Value('REPL_Publisher')
  set @sSubscriber        = dbo.udf_Get_Parameter_Value('REPL_Subscriber')
  set @sDatafileLocation  = dbo.udf_Get_Parameter_Value('REPL_DB_Datafile_Location')
  set @sLogfileLocation   = dbo.udf_Get_Parameter_Value('REPL_DB_Logfile_Location')
  set @sWorkingDir        = dbo.udf_Get_Parameter_Value('REPL_Working_Directory')

  IF NOT EXISTS (SELECT 1
                 FROM   sys.databases
                 WHERE  name = 'Distribution')
  BEGIN
	  -- create the distributor_admin user, password as specified
	  exec master.dbo.sp_adddistributor  @distributor = @sDistributor

	  -- Updating the agent profile defaults
	  exec sp_MSupdate_agenttype_default @profile_id = 1
	  exec sp_MSupdate_agenttype_default @profile_id = 2
	  exec sp_MSupdate_agenttype_default @profile_id = 4
	  exec sp_MSupdate_agenttype_default @profile_id = 6
	  exec sp_MSupdate_agenttype_default @profile_id = 11
  
	  -- Adding the distribution database
	  exec sp_adddistributiondb @database = N'distribution',
								@data_folder = @sDatafileLocation, 
								@data_file = N'distribution.MDF', 
								@data_file_size = '5120',
								@log_folder = @sLogfileLocation, 
								@log_file = N'distribution.LDF', 
								@log_file_size = '5120', 
								@min_distretention = 0, 
								@max_distretention = 72, 
								@history_retention = 48, 
								@security_mode = 1

	   -- Adding the distribution publisher
	  exec sp_adddistpublisher  @publisher = @sPublisher,
								@distribution_db = N'distribution', 
								@security_mode = 1,
								@working_directory = @sWorkingDir, 
								@trusted = N'false', 
								@thirdparty_flag = 0,
								@publisher_type = N'MSSQLSERVER'
  END
  

   -- Enable Replication on the database
  exec sp_replicationdboption @dbname = N'$(DatabaseName)', -- SQLCMD for Config DB Name?
                              @optname = N'publish',
                              @value = N'true'

  exec sp_replicationdboption @dbname = N'$(DatabaseName)', -- SQLCMD for Config DB Name?
                              @optname = N'merge publish',
                              @value = N'true'

  -- update SYS_Settings
  update SYS_Settings
  set [Value] = 'true'
  where [Key] = 'REPL_Enabled'

  set  @sLogreader = '$(DatabaseName) Replication - Transaction Log Reader' -- SQLCMD
  set  @sQreader = '$(DatabaseName) Replication - Transaction Queue Reader'  -- SQLCMD

  if not exists (SELECT 1
                 FROM   msdb.dbo.sysjobs
                 WHERE  name = '$(DatabaseName) Replication - Transaction Log Reader') -- SQLCMD
      -- Create the Log Reacer job for this distributor.
      exec usp_REPL_Create_LogReader_Job @i_sJobName     = @sLogreader
                                       , @i_sPublisher   = @sPublisher
                                       , @i_sDistributor = @sDistributor

  if not exists (SELECT 1
                 FROM   msdb.dbo.sysjobs
                 WHERE  name = '$(DatabaseName) Replication - Transaction Queue Reader') -- SQLCMD
	  -- Create the Queue Reader job for this distributor.
	  exec usp_REPL_Create_QueueReader_Job @i_sJobName   = @sQreader
										 , @i_sPublisher   = @sPublisher
										 , @i_sDistributor = @sDistributor

  -- now create the Log Reader Agent
  exec sp_addlogreader_agent @job_name = @sLogreader,
                             @job_login = null,
                             @job_password = null,
                             @publisher_security_mode = 1

  exec msdb.dbo.sp_start_job @sLogreader

  -- now create the Queue Reader Agent
  exec sp_addqreader_agent @job_name = @sQreader,
                           @job_login = null, 
                           @job_password = null, 
                           @frompublisher = 1

  exec msdb.dbo.sp_start_job @sQreader
GO
PRINT N'Creating [dbo].[usp_REPL_Start_Job]...';


GO
-- =================================================================================
-- Author:       ?
-- Create Date:  ?
-- Description:  This procedure starts a job based on the passed in job name and
--               waits for the job to finish if @i_nWaitForFinish is set to True
--               before returning to the calling procedure
-- =================================================================================
-- Calls:        None.
-- Called By:    usp_REPL_Setup_Replication
--               usp_REPL_TXN_Create_Live_Publication
--               usp_REPL_Create_CFG_Merge_Publication
--               usp_REPL_TXN_Create_Programmability_Publication
--               usp_REPL_TXN_Create_CFG_Publication
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  25th August 2011
-- Description:  Modified to not loop every second waiting for the job to start as
--               this causes problems with jobs that start and finish before the
--               first check.  We now just wait 5 seconds before checking whether
--               job has finished.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th January 2012
-- Description:  Amended Procedure to accept an input parameter of step name and
--               start the job at the specified step if not NULL
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Start_Job]
  @i_sJobName         sysname,
  @i_nWaitForFinish   varchar(5) = 'true',
  @i_sStepName        sysname = NULL
AS
  set nocount on

  declare @JobId  binary(16)
  declare @JobName   varchar(80)
  declare @JobStatus int

  set @JobName = @i_sJobName

  select @JobId = job_id
  from msdb.dbo.sysjobs
  where name = @jobname

  -- manually start the job
  exec msdb.dbo.sp_start_job @Job_Id = @JobId, @step_name=@i_sStepName

  -- now wait for job to start
  WAITFOR DELAY '00:00:05'

  if @i_nWaitForFinish = 'true' begin
    -- then for it to finish
    WAITFOR DELAY '00:00:02'
  
    while 1=1 begin
      EXEC @JobStatus = usp_get_job_status @JobName
      IF @JobStatus = 4 BREAK
  
      WAITFOR DELAY '00:00:02'
    end
  end
GO
PRINT N'Creating [dbo].[usp_REPL_Add_Publication]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  19th October 2011
-- Description:  This procedure creates a Publication and it's associated snapshot 
--               job if necessary. It has replaced the original procedures
--               usp_REPL_Add_Merge_Publication and usp_REPL_TXN_Add_Publication.
-- =================================================================================
-- Calls:        usp_REPL_Create_Snapshot_Job
-- Called By:    usp_REPL_Create_Publication_Live_Transactional
--               usp_REPL_Create_Publication_CFG_Transactional
--               usp_REPL_Create_Publication_CFG_Merge
--               usp_REPL_Recreate_Publication_Live_Transactional
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th July 2012
-- Description:  Amended Procedure as there is no longer a distinction between the 
--               Replicate Jobs for Transactional Live and Transactional Config
--               publications
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  3rd September 2012
-- Description:  1) Altered to set @immediate_sync to false for transactional 
--                  replication.  This stops with distribution holding a full 
--                  history of all data for the retention period.  Now it only holds   
--                  everything that has not been synchronised.
--               2) Added code for a new Partitioning publication.  This replicates
--                  the partitioning call on the remote site rather than performing 
--                  all changes on the live site and replicating the changes.  This
--                  involves a large number of deletes and takes a lot of resources
--                  unnecessarily in live environments.
--               3) Set live table publications not to replicate ddl changes.  These
--                  are now managed by the new Partitioning publication.
--               4) Tidied and used new SQL 2008 functionality where applicable. 
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Add_Publication] 
   @i_sPubName     sysname
 , @i_sPubType     VARCHAR(15)
 , @i_sJobName     sysname = NULL
 , @i_sPublisher   sysname 
 , @i_sDistributor sysname
 , @i_sReplUser    sysname
 , @i_bSyncPub     bit
AS
DECLARE @sLogreader   sysname = '$(DatabaseName) Replication - Transaction Log Reader' --SQLCMD?
      , @sQreader     sysname = '$(DatabaseName) Replication - Transaction Queue Reader' --SQLCMD?
      , @sDescription varchar(100) = N'$(DatabaseName) ' + @i_sPubType + ' publication of ' + @i_sPubName --SQLCMD?

SET NOCOUNT ON

IF @i_bSyncPub = 'True'
BEGIN
	-- Create the snapshot job for this publication.
	EXEC usp_REPL_Create_Snapshot_Job @i_sPubName = @i_sPubName
		                            , @i_sPubType = @i_sPubType
		  			     			, @i_sJobName = @i_sJobName
									, @i_sPublisher = @i_sPublisher
									, @i_sDistributor = @i_sDistributor
									, @i_sReplUser = @i_sReplUser

END

if @i_sPubType = 'Transactional'
BEGIN
	-- now create the publication
	IF (@i_sPubName = 'Partitioning')
	BEGIN
		EXEC sp_addpublication @publication = @i_sPubName
							 , @restricted = N'false'
							 , @sync_method = N'concurrent'
							 , @repl_freq = N'continuous'
							 , @description = @sDescription
							 , @status = N'active'
							 , @allow_push = N'true'
							 , @allow_pull = N'true'
							 , @allow_anonymous = N'false'
							 , @enabled_for_internet = N'false'
							 , @independent_agent = N'true'
							 , @immediate_sync = N'false'
							 , @allow_sync_tran = N'false'
							 , @replicate_ddl = 1 
							 , @logreader_job_name = @sLogReader
							 , @qreader_job_name = @sQreader
	END
	ELSE
	BEGIN
		EXEC sp_addpublication @publication = @i_sPubName
							 , @restricted = N'false'
							 , @sync_method = N'concurrent'
							 , @repl_freq = N'continuous'
							 , @description = @sDescription
							 , @status = N'active'
							 , @allow_push = N'true'
							 , @allow_pull = N'true'
							 , @allow_anonymous = N'false'
							 , @enabled_for_internet = N'false'
							 , @independent_agent = N'true'
							 , @immediate_sync = N'false'
							 , @allow_sync_tran = N'false'
							 , @autogen_sync_procs = N'false'
							 , @replicate_ddl = 0 
							 , @logreader_job_name = @sLogReader
							 , @qreader_job_name = @sQreader
	END
END
  

  
-- todo, expand to include ALL current log ins
EXEC sp_grant_publication_access @publication = @i_sPubName
	                           , @login = @i_sReplUser
EXEC sp_grant_publication_access @publication = @i_sPubName
	                           , @login = N'sa' -- JL: change this to be SQLCMD var?
EXEC sp_grant_publication_access @publication = @i_sPubName
	                           , @login = N'distributor_admin'

IF @i_bSyncPub = 'True'
BEGIN
	IF (@i_sPubName = 'Partitioning')
	BEGIN
		EXEC sp_addpublication_snapshot @publication = @i_sPubName
                                      , @frequency_type = 1
                                      , @frequency_interval = 1
                                      , @frequency_relative_interval = 1
                                      , @frequency_recurrence_factor = 0
                                      , @frequency_subday = 8
                                      , @frequency_subday_interval = 1
                                      , @active_start_time_of_day = 0
                                      , @active_end_time_of_day = 235959
                                      , @active_start_date = 0
                                      , @active_end_date = 0
                                      , @job_login = null
                                      , @job_password = null
                                      , @publisher_security_mode = 1
	END
	ELSE
	BEGIN
		EXEC sp_addpublication_snapshot @publication = @i_sPubName
		    						  , @frequency_type = 8
									  , @frequency_interval = 64
									  , @frequency_relative_interval = 0
									  , @frequency_recurrence_factor = 1
									  , @frequency_subday = 1
									  , @frequency_subday_interval = 0
									  , @active_start_date = 0
									  , @active_end_date = 0
									  , @active_start_time_of_day = 5200
									  , @active_end_time_of_day = 0
									  , @snapshot_job_name = @i_sJobName
									  , @job_login = null
									  , @job_password = null
									  , @publisher_security_mode = 1
	END
END
GO
PRINT N'Creating [dbo].[usp_REPL_Add_Subscription]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  19th October 2011
-- Description:  This procedure creates a Subscription to a publication and creates 
--               the replication job. It has replaced the original procedures
--               usp_REPL_Add_Merge_Subscription and usp_REPL_TXN_Add_Subscription.
-- =================================================================================
-- Calls:        usp_REPL_Create_Replicate_Job
-- Called By:    usp_REPL_Create_Publication_Live_Transactional
--               usp_REPL_Create_Publication_CFG_Transactional
--               usp_REPL_Create_Publication_CFG_Merge
--               usp_REPL_Recreate_Publication_Live_Transactional
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th July 2012
-- Description:  Amended Procedure as there is no longer a distinction between the 
--               Replicate Jobs for Transactional Live and Transactional Config
--               publications
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  3rd September 2012
-- Description:  1) Added code for a new Partitioning publication.  This replicates
--                  the partitioning call on the remote site rather than performing 
--                  all changes on the live site and replicating the changes.  This
--                  involves a large number of deletes and takes a lot of resources
--                  unnecessarily in live environments.
--               2) Tidied and used new SQL 2008 functionality where applicable. 
-- =================================================================================
-- Update Author:Chris Jenkins
-- Date:         13th September 2012
-- Description:  Altered to remove the automatic synchronisation of the Partitioning
--               publication.  This now uses the same synchronisation as the live 
--               table publications.
-- *Note:        The 'none' @sync_type is deprecated.  We should be using 
--               the 'replication support only' option.  However this will need 
--               testing and is outside of the scope of the current work.
--               http://msdn.microsoft.com/en-us/library/ms181702.aspx
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Add_Subscription]
   @i_sPubName     sysname
 , @i_sPubType     varchar(15)
 , @i_sJobName     sysname
 , @i_sPublisher   sysname
 , @i_sDistributor sysname
 , @i_sSubscriber  sysname
 , @i_sReplUser    sysname
 , @i_bSyncPub     bit 
AS
SET NOCOUNT ON

DECLARE @sDescription varchar(100) = N'$(DatabaseName) ' + @i_sPubType + ' publication of ' + @i_sPubName
       ,@nFrequency   tinyint = 1 --Once

IF (@i_sPubType = 'Transactional' AND @i_sPubName != 'Partitioning')
	SET @nFrequency = 64 -- Autostart

-- manually add the merge job otherwise a system name is defaulted
EXEC usp_REPL_Create_Replicate_Job @i_sPubName = @i_sPubName
                                 , @i_sJobName = @i_sJobName
                                 , @i_sPublisher = @i_sPublisher
                                 , @i_sDistributor = @i_sDistributor
                                 , @i_sSubscriber = @i_sSubscriber
                                 , @i_sReplUser = @i_sReplUser
                                 , @i_sPubType = @i_sPubType

IF @i_sPubType = 'Merge'
BEGIN
	EXEC sp_addmergesubscription @publication = @i_sPubName
							   , @subscriber = @i_sSubscriber
							   , @subscriber_db = N'$(DatabaseName)' --SQLCMD?
							   , @subscription_type = N'push'
							   , @sync_type = N'automatic'
							   , @subscriber_type = N'Global'
							   , @subscription_priority = 75
							   , @description = null
							   , @use_interactive_resolver = N'false'
							   , @merge_job_name = @i_sJobName

	EXEC sp_addmergepushsubscription_agent @publication = @i_sPubName
										 , @subscriber = @i_sSubscriber
										 , @subscriber_db = N'$(DatabaseName)' --SQLCMD?
										 , @job_login = null
										 , @job_password = null
										 , @job_name = @i_sJobName
										 , @subscriber_security_mode = 1
										 , @publisher_security_mode = 1
										 , @frequency_type = 1
										 , @frequency_interval = 0
										 , @frequency_relative_interval = 0
										 , @frequency_recurrence_factor = 0
										 , @frequency_subday = 0
										 , @frequency_subday_interval = 0
										 , @active_start_time_of_day = 0
										 , @active_end_time_of_day = 0
										 , @active_start_date = 0
										 , @active_end_date = 19950101
										 , @enabled_for_syncmgr = N'False'
END
  
IF @i_sPubType = 'Transactional'
BEGIN
	-- now add the push subscription
	EXEC sp_addsubscription @publication = @i_sPubName
						  , @subscriber = @i_sSubscriber
						  , @destination_db = N'$(DatabaseName)' --SQLCMD?
						  , @sync_type = N'none'
						  , @article = N'all'
						  , @update_mode = N'read only'
						  , @loopback_detection = 'true'

	EXEC sp_addpushsubscription_agent @publication = @i_sPubName
									, @subscriber = @i_sSubscriber
									, @subscriber_db = N'$(DatabaseName)' --SQLCMD?
									, @job_login = null
									, @job_password = null
									, @job_name = @i_sJobName
									, @subscriber_security_mode = 1
									, @frequency_type = @nFrequency
									, @frequency_interval = 0
									, @frequency_relative_interval = 0
									, @frequency_recurrence_factor = 0
									, @frequency_subday = 0
									, @frequency_subday_interval = 0
									, @active_start_time_of_day = 0
									, @active_end_time_of_day = 0
									, @active_start_date = 0
									, @active_end_date = 19950101
									, @enabled_for_syncmgr = N'False'
END
GO
PRINT N'Creating [dbo].[usp_REPL_Create_Publication_CFG_Merge]...';


GO

-- =================================================================================
-- Author:       ?
-- Create Date:  ?
-- Description:  This creates a Merge Publication for CFG tables
-- =================================================================================
-- Calls:        usp_REPL_Add_Article
--               usp_REPL_Add_Publication
--               usp_REPL_Add_Subscription
--               usp_REPL_Start_Job
-- Called By:    None.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  27th August 2010
-- Description:  Procedure altered as we need to include the OM_OPEN_TROUBLE_TICKETS
--               table and also the SYS_PART_* tables
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Renamed the procedure and amended to call new combined procedures
--               also amended to create Job Names that confirm to naming conventions
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  8th November 2011
-- Description:  Amended the procedure to include APP_ Tables 
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  23rd May 2012
-- Description:  Altered the c_get_tabs cursor to find ATM_DNSAliasRequest and 
--               remove checks for track tables that no longer exist.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  9th July 2012
-- Description:  Amended call to usp_REPL_Start_Job for the Merge Job to wait for it 
--               to finish before continuing
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th July 2012
-- Description:  Amended Procedure to remove unnecessary parameters and add new ones 
--               to cater for the amendment to the Replication process to allow for 
--               all Transactional publications to replicate in the same way and
--               also for the partitioned live table publications to not generate
--               snapshots
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  3rd September 2012
-- Description:  Altered to remove replication of SYS_PART% tables.  These are no
--               longer replicated because this can conflict with the replication
--               of the partitioning procedure call.  Any manual changes to these
--               tables will need to be performed on both sites.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  18th March 2013
-- Description:  Amended Procedure to remove OM_OPEN_TROUBLE_TICKETS from the cursor 
--               for obtaining the tables to use as articles as this now forms part 
--               of the small live publication.
-- =================================================================================
-- Update Author:Chris Jenkins
-- Update Date:  12th June 2013
-- Description:  Added the PARSED_ tables to the publication.
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Create_Publication_CFG_Merge]
AS
  -- local variables
  declare @sJobName          sysname
        , @sPubName          sysname
        , @sTable            sysname
        , @sPublisher        sysname
        , @sDistributor      sysname
        , @sSubscriber       sysname
        , @sReplUser         varchar(100)
		, @sPubType          varchar(15)
        , @bSyncPub          bit

  -- initial initialization
  set @sPublisher   = dbo.udf_Get_Parameter_Value('REPL_Publisher')
  set @sDistributor = dbo.udf_Get_Parameter_Value('REPL_Distributor')
  set @sSubscriber  = dbo.udf_Get_Parameter_Value('REPL_Subscriber')
  set @sReplUser    = dbo.udf_Get_Parameter_Value('REPL_Admin_User')
  set @sPubName     = 'ALL CFG Tables' -- rename this appropriately
  set @sPubType     = 'Merge'
  set @bSyncPub     = 'True'
  
  set @sJobName = '$(DatabaseName) Replication - Snapshot ' + @sPubName

  -- Add the merge publication
  exec usp_REPL_Add_Publication @i_sPubName = @sPubName
	                          , @i_sPubType = @sPubType
                              , @i_sJobName = @sJobName
                              , @i_sPublisher = @sPublisher
                              , @i_sDistributor = @sDistributor
                              , @i_sReplUser = @sReplUser
							  , @i_bSyncPub = @bSyncPub

  -- Adding the merge articles
  declare c_get_tabs cursor for
	select a.name
    from sysobjects a 
    where ObjectProperty(a.id, 'IsUserTable') = 1
    and   ObjectProperty(a.id, 'IsSystemTable') = 0
    and   ObjectProperty(a.id, 'IsMSShipped') = 0
    and  name in ('Areas', 'Customers', 'Environments', 'Param_Name', 'Param_Values')
    order by a.name
  
  open c_get_tabs
  
  while 1=1 begin
    fetch next from c_get_tabs into @sTable
  
    if @@fetch_status <> 0 break
  
    -- Add the merge articles for the retreived function
    exec usp_REPL_Add_Article @i_sPubName = @sPubName
	                        , @i_sPubType = @sPubType
                            , @i_sArticleName = @sTable
                            , @i_sArticleType = 'table'
  end
  
  close c_get_tabs
  deallocate c_get_tabs

  -- manually kick off the snapshot job (and wait for it to finish)
  exec usp_REPL_Start_Job @i_sJobName = @sJobName
	                    , @i_nWaitForFinish = 'True'
  
  -- create the merge job on the publisher (push to the subscriber)
  set @sJobName = '$(DatabaseName) Replication - ' + @sPubName
  exec usp_REPL_Add_Subscription @i_sPubName = @sPubName
                               , @i_sJobName = @sJobName
                               , @i_sPublisher = @sPublisher
                               , @i_sDistributor = @sDistributor
                               , @i_sSubscriber = @sSubscriber
                               , @i_sReplUser = @sReplUser
                               , @i_sPubType = @sPubType
                               , @i_bSyncPub = @bSyncPub

  -- manually kick off the merge job
  exec usp_REPL_Start_Job @i_sJobName = @sJobName
	                    , @i_nWaitForFinish = 'True'
GO
PRINT N'Creating [dbo].[usp_REPL_Create_Publication_CFG_Transactional]...';


GO
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  19th April 2011
-- Description:  This procedure Implements Transactional Replication for 
--               Specified Config Tables to allow continuous Replication
-- =================================================================================
-- Calls:        usp_REPL_Start_Job
--             , usp_REPL_Add_Publication
--             , usp_REPL_Add_Subscription
--             , usp_REPL_Add_Article
-- Called By:    None.
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th October 2011
-- Description:  Renamed the procedure and amended to call new combined procedures
--               also amended to create Job Names that confirm to naming conventions
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  31st October 2011
-- Description:  Amended Procedure to reflect change of Linked Server from Machine
--               Name to Instance Name
-- =================================================================================
-- Author:       Donna-Marie Dimmer
-- Create Date:  17th January 2012
-- Description:  Amended Procedure to use new Linked Server as the implementation
--               of Replication was causing the Linked Server to not allow remote 
--               Procedure calls for other DBs
-- =================================================================================
-- Update Author:Donna-Marie Dimmer
-- Update Date:  20th July 2012
-- Description:  Amended Procedure to remove unnecessary parameters and add new ones 
--               to cater for the amendment to the Replication process to allow for 
--               all Transactional publications to replicate in the same way and
--               also for the partitioned live table publications to not generate
--               snapshots
-- =================================================================================
-- Update Author:Joe Lees
-- Update Date:  5th August 2015
-- Description:  Added 'OM_SNMP_GET_DETAILS' to the list of table to replicate.
-- =================================================================================
CREATE PROCEDURE [dbo].[usp_REPL_Create_Publication_CFG_Transactional] AS
  declare @sJobname          sysname
        , @sPubName          sysname
        , @sTable            sysname
        , @sPublisher        sysname
        , @sDistributor      sysname
        , @sSubscriber       sysname
        , @sReplUser         varchar(100)
        , @sViewLike         varchar(50)
        , @sType             varchar(5)
        , @sPublicationFound int
        , @bReplicated       bit
		, @sPubType          varchar(15)
		, @sSQLStmt          nvarchar(256)
		, @nPubExists        TINYINT
		, @bSyncPub          bit -- syncPub?

  set @sPublisher   = dbo.udf_Get_Parameter_Value('REPL_Publisher')
  set @sDistributor = dbo.udf_Get_Parameter_Value('REPL_Distributor')
  set @sSubscriber  = dbo.udf_Get_Parameter_Value('REPL_Subscriber')
  set @sReplUser    = dbo.udf_Get_Parameter_Value('REPL_Admin_User')
  set @bSyncPub     = 'True' -- syncPub?
  set @sPubType     = 'Transactional'
  set @sPubName = 'All Tables' -- Should change PubName

  SELECT @bReplicated = is_published
  FROM   [REPL-$(ResilientInstanceName)].master.sys.databases -- SQLCMD vars needed here: $(REPL_Publisher)
  WHERE  name = '$(DatabaseName)' 

    -- check if the publication exists
  exec sp_helppublication @sPubName
                        , @sPublicationFound output

  if @sPublicationFound <> 0 
      goto finish

  /* REMOVE ALL THIS?
  IF @bReplicated = 'True'
  BEGIN
	  SET @sSQLStmt = 'SELECT @nPubExists = 1'
		 + CHAR(13) + 'FROM   [REPL-V-VFDB1].distribution.dbo.MSpublications' -- We need to replace with SQLCMD here...
		 + CHAR(13) + 'WHERE  publication = ''' + @sPubName + ''''
		 + CHAR(13) + 'AND    publisher_db = ''Reactor'''

	  EXECUTE sp_executesql @sSQLStmt, @params = N'@nPubExists TINYINT OUTPUT', @nPubExists = @nPubExists OUTPUT

	  IF @nPubExists IS NOT NULL
		  set @bSyncPub = 'False'
  END
  */

  set @sJobName = '$(DatabaseName) Replication - Snapshot ' + @sPubName
  


    -- Add the Transactional publication
  exec usp_REPL_Add_Publication @i_sPubName = @sPubName
	                          , @i_sPubType = @sPubType
                              , @i_sJobName = @sJobName
                              , @i_sPublisher = @sPublisher
                              , @i_sDistributor = @sDistributor
                              , @i_sReplUser = @sReplUser
                              , @i_bSyncPub = @bSyncPub -- syncPub?


  declare c_get_tabs cursor for
    select a.name
    from   sysobjects a 
    where  ObjectProperty(id, 'IsUserTable') = 1
    and    ObjectProperty(id, 'IsSystemTable') = 0
    and    ObjectProperty(id, 'IsMSShipped') = 0
	and  name <> 'sys_settings'
	--in ('Areas', 'Customers', 'Environments', 'Cust_Area_Mapped', 'Config_Parameters', 'Config_Mapping', 'Config_Values', 'DeleteTransactions')
	-- not = sys_settings

    open c_get_tabs
  
    while 1 = 1 begin
      fetch next from c_get_tabs into @sTable
      if @@fetch_status <> 0 break
  
      exec usp_REPL_Add_Article @i_sPubName = @sPubName
	                          , @i_sPubType = @sPubType -- pubType?
                              , @i_sArticleName = @sTable
                              , @i_sArticleType = 'table'
      end
  
    close c_get_tabs
    deallocate c_get_tabs

    -- create the merge job on the publisher (push to the subscriber)
    set @sJobName = '$(DatabaseName) Replication - ' + @sPubName
    exec usp_REPL_Add_Subscription @i_sPubName = @sPubName
                                 , @i_sPubType = @sPubType
                                 , @i_sJobName = @sJobName
                                 , @i_sPublisher = @sPublisher
                                 , @i_sDistributor = @sDistributor
                                 , @i_sSubscriber = @sSubscriber
                                 , @i_sReplUser = @sReplUser
                                 , @i_bSyncPub = @bSyncPub
	set @sJobname = '$(DatabaseName) Replication - ' + @sPubName  
    exec usp_REPL_Start_Job @i_sJobName = @sJobName
	                      , @i_nWaitForFinish = 'False'
/*
    IF @bSyncPub = 'True' -- ???
      BEGIN
        set @sJobName = '$(DatabaseName) Replication - Snapshot ' + @sPubName
        exec usp_REPL_Start_Job @i_sJobName = @sJobName
	                      , @i_nWaitForFinish = 'True'
      END
      
    set @sJobname = '$(DatabaseName) Replication - ' + @sPubName  
    exec usp_REPL_Start_Job @i_sJobName = @sJobName
	                      , @i_nWaitForFinish = 'False'
  */

  finish:
  return 0
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

----Create roles
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_executor')
--	CREATE ROLE [db_executor] AUTHORIZATION [dbo]

----Grant privileges to roles
--GRANT EXECUTE TO [db_executor] AS [dbo]

----Add the users to the db and grant privileges where necessary
--IF EXISTS (SELECT * FROM sys.server_principals WHERE name = N'$(CortexDBUser)')
--BEGIN
--	IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'$(CortexDBUser)')
--		CREATE USER [$(CortexDBUser)] FOR LOGIN [$(CortexDBUser)];

--	GRANT CONNECT TO [$(CortexDBUser)] AS [dbo];
--	EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'$(CortexDBUser)'
--	EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'$(CortexDBUser)'
--	EXECUTE sp_addrolemember @rolename = N'db_executor', @membername = N'$(CortexDBUser)'
--END


USE [$(DatabaseName)]
GO

SET NOCOUNT ON;

BEGIN TRY
BEGIN TRANSACTION

	PRINT 'Merging into SYS_Sequence'

	MERGE [dbo].[SYS_Sequence] AS TARGET
	USING (VALUES ('Areas','ID', 1)
				, ('Customers','ID',1)
				, ('Environments','ID',1)
				, ('Param_Name','ID',1)
				, ('DeleteTransactions','ID',1)
				, ('Param_Values','ID',1))
		   AS SOURCE ([TableName]
					 ,[ColumnName]
					 ,[SequenceNumber])
	   ON TARGET.[TableName] = SOURCE.[TableName] AND TARGET.[ColumnName] = SOURCE.[ColumnName]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([TableName], [ColumnName], [SequenceNumber])
		VALUES ([TableName], [ColumnName], [SequenceNumber]);

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK TRANSACTION
	END

	DECLARE @sErrorMessage  NVARCHAR(4000)
		  , @nErrorSeverity INT
		  , @nErrorState    INT;

	SELECT @sErrorMessage  = ERROR_MESSAGE()
		 , @nErrorSeverity = ERROR_SEVERITY()
		 , @nErrorState    = ERROR_STATE();

	-- Use RAISERROR inside the CATCH block to return 
	-- error information about the original error that 
	-- caused execution to jump to the CATCH block.
	RAISERROR (@sErrorMessage  -- Message text.
			 , @nErrorSeverity -- Severity.
			 , @nErrorState);  -- State.
END CATCH

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
/*
Migrate data from old tables to new tables
*/	
GO
SET NOCOUNT ON

GO
PRINT 'Migrating data from Areas table...'

INSERT INTO [dbo].[Areas](ID,Area,Description)
SELECT [ID],[Name],[Description]
FROM [dbo].[Areas-v1]

GO
PRINT 'Migrating data from Customers table...'

INSERT INTO [dbo].[Customers](ID,Customer,Description)
SELECT [ID],[Name],[Description]
FROM [dbo].[Customers-v1]

GO
PRINT 'Migrating data from Environments table...'

INSERT INTO [dbo].[Environments](ID,Environment,Description)
SELECT [ID],[Name],[Description]
FROM [dbo].[Environments-v1]

GO
PRINT 'Migrating data from Parameters table...'

INSERT INTO [dbo].[Param_Name](ID,Param_Name,Description)
SELECT [ID],[Parameter_Name],[Description]
FROM [dbo].[Config_Parameters-v1]

GO
PRINT 'Migrating configuration values mapping...'
INSERT INTO [dbo].[Param_Values](ID,AreaID,CustomerID,EnvironmentID,Param_nameID,Param_Value,Description)
SELECT ROW_NUMBER() OVER(ORDER BY CAM.Area_ID, CAM.Cust_ID, CM.Env_ID, CP.id ASC)
	   , CAM.Area_ID
       , CAM.Cust_ID
       , CM.Env_ID
       , CP.id AS Param_ID
       , CV.Param_Value
	   , CV.Description
FROM [dbo].[Cust_Area_Mapped-v1] CAM
INNER JOIN [dbo].[Config_Mapping-v1] CM
       ON CM.Cust_Area_ID = CAM.ID
INNER JOIN [dbo].[Config_Values-v1] CV
       ON CV.Mapping_ID = CM.ID
INNER JOIN [dbo].[Config_Parameters-v1] CP
       ON CP.id = CV.Param_ID

PRINT 'Migration from Cortex Configuration module v1 to v2 finalised!'

PRINT N'Creating [dbo].[TRG_InsteadOfInsert_Areas]...';


GO

CREATE TRIGGER [dbo].[TRG_InsteadOfInsert_Areas]
   ON  [dbo].[Areas]
   INSTEAD OF INSERT NOT FOR REPLICATION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE  @AreaID int = (SELECT dbo.udf_GetSequenceNumber('Areas','ID'));

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO Areas (ID
							,Area
							,Description)
			SELECT @AreaID
				  ,inserted.Area
				  ,inserted.Description
			FROM  inserted

			UPDATE SYS_Sequence
			SET    SequenceNumber = @AreaID + 1
			WHERE  TableName = 'Areas'
			AND    ColumnName = 'ID'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
	END CATCH
END
GO
PRINT N'Creating [dbo].[TRG_InsteadOfInsert_Customers]...';


GO

CREATE TRIGGER [dbo].[TRG_InsteadOfInsert_Customers]
   ON  [dbo].[Customers]
   INSTEAD OF INSERT NOT FOR REPLICATION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE  @CustID int = (SELECT dbo.udf_GetSequenceNumber('Customers','ID'));

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO Customers (ID
							,Customer
							,Description)
			SELECT @CustID
				  ,inserted.Customer
				  ,inserted.Description
			FROM  inserted

			UPDATE SYS_Sequence
			SET    SequenceNumber = @CustID + 1
			WHERE  TableName = 'Customers'
			AND    ColumnName = 'ID'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
	END CATCH
END
GO
PRINT N'Creating [dbo].[TRG_InsteadOfInsert_Environments]...';


GO

CREATE TRIGGER [dbo].[TRG_InsteadOfInsert_Environments]
   ON  [dbo].[Environments]
   INSTEAD OF INSERT NOT FOR REPLICATION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE  @EnvID int = (SELECT dbo.udf_GetSequenceNumber('Environments','ID'));

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO Environments (ID
							,Environment
							,Description)
			SELECT @EnvID
				  ,inserted.Environment
				  ,inserted.Description
			FROM  inserted

			UPDATE SYS_Sequence
			SET    SequenceNumber = @EnvID + 1
			WHERE  TableName = 'Environments'
			AND    ColumnName = 'ID'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
	END CATCH
END
GO
PRINT N'Creating [dbo].[TRG_InsteadOfInsert_Param_Name]...';


GO

CREATE TRIGGER [dbo].[TRG_InsteadOfInsert_Param_Name]
   ON  [dbo].[Param_Name]
   INSTEAD OF INSERT NOT FOR REPLICATION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE  @PrmID int = (SELECT dbo.udf_GetSequenceNumber('Param_Name','ID'));

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO Param_Name (ID
							,Param_Name
							,Description)
			SELECT @PrmID
				  ,inserted.Param_Name
				  ,inserted.Description
			FROM  inserted

			UPDATE SYS_Sequence
			SET    SequenceNumber = @PrmID + 1
			WHERE  TableName = 'Param_Name'
			AND    ColumnName = 'ID'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
	END CATCH
END
GO
PRINT N'Creating [dbo].[TRG_InsteadOfInsert_Param_Values]...';


GO

CREATE TRIGGER [dbo].[TRG_InsteadOfInsert_Param_Values]
   ON  [dbo].[Param_Values]
   INSTEAD OF INSERT NOT FOR REPLICATION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE  @CfgValID int = (SELECT dbo.udf_GetSequenceNumber('Param_Values','ID'));

	BEGIN TRY
		BEGIN TRANSACTION

			INSERT INTO Param_Values (ID
							,AreaID
							,CustomerID
							,EnvironmentID
							,Param_NameID
							,Param_Value
							,Description)
							
			SELECT @CfgValID
				  ,inserted.AreaID
				  ,inserted.CustomerID
				  ,inserted.EnvironmentID
				  ,inserted.Param_NameID
				  ,inserted.Param_Value
				  ,inserted.Description
			FROM  inserted

			UPDATE SYS_Sequence
			SET    SequenceNumber = @CfgValID + 1
			WHERE  TableName = 'Param_Values'
			AND    ColumnName = 'ID'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		
		IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION
	END CATCH
END

-- JL: DELETE OLD v0.1 data
GO
PRINT 'Starting complete removal of Cortex Configuration v0.1 objects...'
GO
DROP TABLE [dbo].[Config_Values-v1]
GO
DROP TABLE  [dbo].[Config_Parameters-v1]
GO
DROP TABLE  [dbo].[Config_Mapping-v1]
GO
DROP TABLE  [dbo].[Cust_Area_Mapped-v1]
GO
DROP TABLE  [dbo].[Areas-v1]
GO
DROP TABLE  [dbo].[Customers-v1]
GO
DROP TABLE  [dbo].[Environments-v1]
GO
DROP TABLE  [dbo].[DeleteTransactions-v1]
GO
DROP VIEW [dbo].[ConfigMappingView]
GO
DROP PROCEDURE [dbo].[usp_InsertUpdate_ParamValues]

GO
PRINT 'Complete removal of Cortex Configuration v0.1  completed.'

--Resynchronise Areas
GO
UPDATE SYS_Sequence
SET    SequenceNumber = (SELECT ISNULL(MAX(ID) + 1,1)
	                        FROM   Areas)
WHERE  TableName = 'Areas'
AND    ColumnName = 'ID'

--Resynchronise Customers
GO
UPDATE SYS_Sequence
SET    SequenceNumber = (SELECT ISNULL(MAX(ID) + 1,1)
	                        FROM   Customers)
WHERE  TableName = 'Customers'
AND    ColumnName = 'ID'

--Resynchronise DeleteTransactions
GO
UPDATE SYS_Sequence
SET    SequenceNumber = (SELECT ISNULL(MAX(ID) + 1,1)
	                        FROM   DeleteTransactions)
WHERE  TableName = 'DeleteTransactions'
AND    ColumnName = 'ID'

--Resynchronise Environments
GO
UPDATE SYS_Sequence
SET    SequenceNumber = (SELECT ISNULL(MAX(ID) + 1,1)
	                        FROM   Environments)
WHERE  TableName = 'Environments'
AND    ColumnName = 'ID'

--Resynchronise Param_Name
GO
UPDATE SYS_Sequence
SET    SequenceNumber = (SELECT ISNULL(MAX(ID) + 1,1)
	                        FROM   Param_Name)
WHERE  TableName = 'Param_Name'
AND    ColumnName = 'ID'

--Resynchronise Param_Values
GO
UPDATE SYS_Sequence
SET    SequenceNumber = (SELECT ISNULL(MAX(ID) + 1,1)
	                        FROM   Param_Values)
WHERE  TableName = 'Param_Values'
AND    ColumnName = 'ID'