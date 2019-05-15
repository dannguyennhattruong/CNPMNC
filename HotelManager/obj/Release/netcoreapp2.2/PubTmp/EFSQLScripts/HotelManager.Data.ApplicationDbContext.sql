IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetRoles] (
        [Id] nvarchar(450) NOT NULL,
        [Name] nvarchar(256) NULL,
        [NormalizedName] nvarchar(256) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetUsers] (
        [Id] nvarchar(450) NOT NULL,
        [UserName] nvarchar(256) NULL,
        [NormalizedUserName] nvarchar(256) NULL,
        [Email] nvarchar(256) NULL,
        [NormalizedEmail] nvarchar(256) NULL,
        [EmailConfirmed] bit NOT NULL,
        [PasswordHash] nvarchar(max) NULL,
        [SecurityStamp] nvarchar(max) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        [PhoneNumber] nvarchar(max) NULL,
        [PhoneNumberConfirmed] bit NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEnd] datetimeoffset NULL,
        [LockoutEnabled] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        [FullName] nvarchar(max) NULL,
        [Address] nvarchar(max) NULL,
        [City] nvarchar(max) NULL,
        [ProfilePic] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [Features] (
        [ID] nvarchar(450) NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [Icon] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Features] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [RoomTypes] (
        [ID] nvarchar(450) NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [BasePrice] decimal(18,2) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_RoomTypes] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetRoleClaims] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetUserClaims] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetUserLogins] (
        [LoginProvider] nvarchar(450) NOT NULL,
        [ProviderKey] nvarchar(450) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [AspNetUserTokens] (
        [UserId] nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(450) NOT NULL,
        [Name] nvarchar(450) NOT NULL,
        [Value] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [Rooms] (
        [ID] nvarchar(450) NOT NULL,
        [Number] int NOT NULL,
        [RoomTypeID] nvarchar(450) NULL,
        [Price] decimal(18,2) NOT NULL,
        [Available] bit NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [MaximumGuests] int NOT NULL,
        CONSTRAINT [PK_Rooms] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Rooms_RoomTypes_RoomTypeID] FOREIGN KEY ([RoomTypeID]) REFERENCES [RoomTypes] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [Bookings] (
        [ID] nvarchar(450) NOT NULL,
        [RoomID] nvarchar(450) NULL,
        [DateCreated] datetime2 NOT NULL,
        [CheckIn] datetime2 NOT NULL,
        [CheckOut] datetime2 NOT NULL,
        [Guests] int NOT NULL,
        [TotalFee] decimal(18,2) NOT NULL,
        [Paid] bit NOT NULL,
        [Completed] bit NOT NULL,
        [ApplicationUserId] nvarchar(max) NULL,
        [ApplicationId] nvarchar(450) NULL,
        [CustomerName] nvarchar(max) NOT NULL,
        [CustomerEmail] nvarchar(max) NOT NULL,
        [CustomerPhone] nvarchar(max) NOT NULL,
        [CustomerAddress] nvarchar(max) NOT NULL,
        [CustomerCity] nvarchar(max) NOT NULL,
        [OtherRequests] nvarchar(max) NULL,
        CONSTRAINT [PK_Bookings] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Bookings_AspNetUsers_ApplicationId] FOREIGN KEY ([ApplicationId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Bookings_Rooms_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Rooms] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [Images] (
        [ID] nvarchar(450) NOT NULL,
        [Name] nvarchar(max) NULL,
        [Size] nvarchar(max) NULL,
        [ImageUrl] nvarchar(max) NULL,
        [FilePath] nvarchar(max) NULL,
        [RoomID] nvarchar(450) NULL,
        CONSTRAINT [PK_Images] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Images_Rooms_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Rooms] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [Reviews] (
        [ID] nvarchar(450) NOT NULL,
        [RoomID] nvarchar(450) NULL,
        [ReviewerName] nvarchar(max) NULL,
        [ReviewerEmail] nvarchar(max) NULL,
        [Description] nvarchar(max) NULL,
        CONSTRAINT [PK_Reviews] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Reviews_Rooms_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Rooms] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [RoomFeatureRelationships] (
        [RoomID] nvarchar(450) NOT NULL,
        [FeatureID] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_RoomFeatureRelationships] PRIMARY KEY ([RoomID], [FeatureID]),
        CONSTRAINT [FK_RoomFeatureRelationships_Features_FeatureID] FOREIGN KEY ([FeatureID]) REFERENCES [Features] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_RoomFeatureRelationships_Rooms_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Rooms] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE TABLE [ItemImageRelationships] (
        [ImageID] nvarchar(450) NOT NULL,
        [ItemID] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_ItemImageRelationships] PRIMARY KEY ([ItemID], [ImageID]),
        CONSTRAINT [FK_ItemImageRelationships_Images_ImageID] FOREIGN KEY ([ImageID]) REFERENCES [Images] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_Bookings_ApplicationId] ON [Bookings] ([ApplicationId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_Bookings_RoomID] ON [Bookings] ([RoomID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_Images_RoomID] ON [Images] ([RoomID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_ItemImageRelationships_ImageID] ON [ItemImageRelationships] ([ImageID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_Reviews_RoomID] ON [Reviews] ([RoomID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_RoomFeatureRelationships_FeatureID] ON [RoomFeatureRelationships] ([FeatureID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    CREATE INDEX [IX_Rooms_RoomTypeID] ON [Rooms] ([RoomTypeID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190509122529_first')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190509122529_first', N'2.2.2-servicing-10034');
END;

GO

