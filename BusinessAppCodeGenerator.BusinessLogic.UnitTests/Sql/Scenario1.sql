
GO
CREATE TABLE [dbo].[Applications] (
    [Id]                             INT           IDENTITY (1, 1) NOT NULL,
    [ClientId]                       VARCHAR (36)  NOT NULL,
    [ApplicationName]                VARCHAR (150) NOT NULL,
    [ApplicationRedirectUrl]         VARCHAR (300) NOT NULL,
    [ApplicationOffBoardingUrl]      VARCHAR (300) NOT NULL,
    [ApplicationSignUpUrl]           VARCHAR (300) NOT NULL,
    [ApplicationEmployeeRedirectUrl] VARCHAR(300)  NOT NULL,
    [InvitationExpirationTimeInHours] INT          NOT NULL Default (72),
    [BrandingId]                     INT           NOT NULL,
    [IsDesktopApplication]			 BIT		   NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[Applications].[UIX_Applications_ClientId]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UIX_Applications_ClientId]
    ON [dbo].[Applications]([ClientId] ASC);


GO
PRINT N'Creating Table [dbo].[Brandings]...';


GO
CREATE TABLE [dbo].[Brandings] (
    [Id]                                   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                                 VARCHAR (100)  NOT NULL,
    [InvitationEmailSubject]               NVARCHAR (255) NOT NULL,
    [InvitationEmailBody]                  NVARCHAR (MAX) NOT NULL,
    [InvitationEmailForEagleIdUserSubject] NVARCHAR (255) NOT NULL,
    [InvitationEmailForEagleIdUserBody]    NVARCHAR (MAX) NOT NULL,
    [EmployeeAuthorizedSubject]            NVARCHAR (255) NOT NULL,
    [EmployeeAuthorizedBody]               NVARCHAR (MAX) NOT NULL,
    [DesktopEmployeeAuthorizedBody]        NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Invitations]...';


GO
CREATE TABLE [dbo].[Invitations] (
    [Id]                              INT              IDENTITY (1, 1) NOT NULL,
    [InvitationalToken]               UNIQUEIDENTIFIER NOT NULL,
    [ApplicationId]                   INT              NOT NULL,
    [InvitationalTokenExpirationDate] DATETIME         NOT NULL,
    [EmailAddress]                    VARCHAR (50)     NOT NULL,
    [FirstName]                       VARCHAR (50)     NOT NULL,
    [LastName]                        VARCHAR (50)     NOT NULL,
    [IndividualId]                    VARCHAR (50)     NOT NULL,
    [Completed]                       BIT              NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[Invitations].[UIX_Invitations_InvitationalToken]...';


GO
CREATE UNIQUE CLUSTERED INDEX [UIX_Invitations_InvitationalToken]
    ON [dbo].[Invitations]([InvitationalToken] ASC);


GO
PRINT N'Creating Table [dbo].[UserConnections]...';


GO
CREATE TABLE [dbo].[UserConnections] (
    [Id]            INT          IDENTITY (1, 1) NOT NULL,
    [ApplicationId] INT          NOT NULL,
    [UserId]        INT          NOT NULL,
    [IndividualId]  VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Index [dbo].[UserConnections].[UIX_UserConnections_ApplicationId_UserId]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIX_UserConnections_ApplicationId_UserId]
    ON [dbo].[UserConnections]([ApplicationId] ASC, [UserId] ASC);


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
PRINT N'Creating Default Constraint unnamed constraint on [dbo].[Invitations]...';


GO
ALTER TABLE [dbo].[Invitations]
    ADD DEFAULT 0 FOR [Completed];


GO
PRINT N'Creating Foreign Key [dbo].[FK_Applications_ToBrandings]...';


GO
ALTER TABLE [dbo].[Applications]
    ADD CONSTRAINT [FK_Applications_ToBrandings] FOREIGN KEY ([BrandingId]) REFERENCES [dbo].[Brandings] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Invitations_ToApplications]...';


GO
ALTER TABLE [dbo].[Invitations]
    ADD CONSTRAINT [FK_Invitations_ToApplications] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[Applications] ([Id]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_UserConnections_ToApplications]...';


GO
ALTER TABLE [dbo].[UserConnections]
    ADD CONSTRAINT [FK_UserConnections_ToApplications] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[Applications] ([Id]);


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
