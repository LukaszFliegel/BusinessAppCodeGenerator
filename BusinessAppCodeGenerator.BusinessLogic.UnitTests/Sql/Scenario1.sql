
GO
CREATE TABLE [dbo].[Programs] (
    [Id]                             INT           IDENTITY (1, 1) NOT NULL,
    [ClientId]                       VARCHAR (36)  NOT NULL,
    [ProgramName]                VARCHAR (150) NOT NULL,
    [ProgramRedirectUrl]         VARCHAR (300) NOT NULL,
    [ProgramOffBoardingUrl]      VARCHAR (300) NOT NULL,
    [ProgramSignUpUrl]           VARCHAR (300) NOT NULL,
    [ProgramEmployeeRedirectUrl] VARCHAR(300)  NOT NULL,
    [NotificationExpirationTimeInHours] INT          NOT NULL Default (72),
    [MarkingId]                     INT           NOT NULL,
    [IsModernProgram]			 BIT		   NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[Programs].[UIX_Programs_ClientId]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UIX_Programs_ClientId]
    ON [dbo].[Programs]([ClientId] ASC);


GO
PRINT N'Creating Table [dbo].[Markings]...';


GO
CREATE TABLE [dbo].[Markings] (
    [Id]                                   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                                 VARCHAR (100)  NOT NULL,
    [NotificationEmailSubject]               NVARCHAR (255) NOT NULL,
    [NotificationEmailBody]                  NVARCHAR (MAX) NOT NULL,
    [NotificationEmailForEagleIdUserSubject] NVARCHAR (255) NOT NULL,
    [NotificationEmailForEagleIdUserBody]    NVARCHAR (MAX) NOT NULL,
    [EmployeeAuthorizedSubject]            NVARCHAR (255) NOT NULL,
    [EmployeeAuthorizedBody]               NVARCHAR (MAX) NOT NULL,
    [DesktopEmployeeAuthorizedBody]        NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Notifications]...';


GO
CREATE TABLE [dbo].[Notifications] (
    [Id]                              INT              IDENTITY (1, 1) NOT NULL,
    [NotificationalToken]               UNIQUEIDENTIFIER NOT NULL,
    [ProgramId]                   INT              NOT NULL,
    [NotificationalTokenExpirationDate] DATETIME         NOT NULL,
    [EmailAddress]                    VARCHAR (50)     NOT NULL,
    [FirstName]                       VARCHAR (50)     NOT NULL,
    [LastName]                        VARCHAR (50)     NOT NULL,
    [IndividualId]                    VARCHAR (50)     NOT NULL,
    [Completed]                       BIT              NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[Notifications].[UIX_Notifications_NotificationalToken]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UIX_Notifications_NotificationalToken]
    ON [dbo].[Notifications]([NotificationalToken] ASC);


GO
PRINT N'Creating Table [dbo].[UserConnections]...';


GO
CREATE TABLE [dbo].[UserConnections] (
    [Id]            INT          IDENTITY (1, 1) NOT NULL,
    [ProgramId] INT          NOT NULL,
    [UserId]        INT          NOT NULL,
    [IndividualId]  VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[UserConnections].[UIX_UserConnections_ProgramId_UserId]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIX_UserConnections_ProgramId_UserId]
    ON [dbo].[UserConnections]([ProgramId] ASC, [UserId] ASC);


GO
PRINT N'Creating Table [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [Id]            INT          IDENTITY (1, 1) NOT NULL,
    [EmailAddress]  VARCHAR (50) NOT NULL,
    [FirstName]     VARCHAR (50) NOT NULL,
    [LastName]      VARCHAR (50) NOT NULL,
    [AzureObjectId] VARCHAR (36) NOT NULL,
    [UserName]      VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[Users].[UIX_Users_UserName]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Users_UserName]
    ON [dbo].[Users]([UserName] ASC);


GO
PRINT N'Creating Index [dbo].[Users].[IX_Users_EmailAddress]...';


GO
CREATE NONCLUSTERED INDEX [IX_Users_EmailAddress]
    ON [dbo].[Users]([EmailAddress] ASC);


GO
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Notifications]...';


GO
ALTER TABLE [dbo].[Notifications]
    ADD DEFAULT 0 FOR [Completed];


GO
PRINT N'Creating Foreign Key [dbo].[FK_Programs_ToMarkings]...';


GO
ALTER TABLE [dbo].[Programs]
    ADD CONSTRAINT [FK_Programs_ToMarkings] FOREIGN KEY ([MarkingId]) REFERENCES [dbo].[Markings] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Notifications_ToPrograms]...';


GO
ALTER TABLE [dbo].[Notifications]
    ADD CONSTRAINT [FK_Notifications_ToPrograms] FOREIGN KEY ([ProgramId]) REFERENCES [dbo].[Programs] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_UserConnections_ToPrograms]...';


GO
ALTER TABLE [dbo].[UserConnections]
    ADD CONSTRAINT [FK_UserConnections_ToPrograms] FOREIGN KEY ([ProgramId]) REFERENCES [dbo].[Programs] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_UserConnections_ToUsers]...';


GO
ALTER TABLE [dbo].[UserConnections]
    ADD CONSTRAINT [FK_UserConnections_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]);


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
