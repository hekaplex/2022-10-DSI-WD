IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'users_2022dsidatalake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [users_2022dsidatalake_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://users@2022dsidatalake.dfs.core.windows.net' 
	)
GO

DROP EXTERNAL TABLE loaded_capture_twitter_10M 

CREATE EXTERNAL TABLE loaded_capture_twitter_10M (
	[received_ts] nvarchar(4000),
	[id] nvarchar(4000),
	[text] nvarchar(4000),
	[created_at] nvarchar(4000),
	[source] nvarchar(4000),
	[lang] nvarchar(4000),
	[retweeted_status_id] nvarchar(4000),
	[truncated] nvarchar(4000),
	[favorited] nvarchar(4000),
	[retweeted] nvarchar(4000),
	[possibly_sensitive] nvarchar(4000),
	[favorite_count] nvarchar(4000),
	[retweet_count] nvarchar(4000),
	[in_reply_to_status_id] nvarchar(4000),
	[in_reply_to_user_id] nvarchar(4000),
	[in_reply_to_screen_name] nvarchar(4000),
	[latitude] nvarchar(4000),
	[longitude] nvarchar(4000),
	[user_id] nvarchar(4000),
	[user_name] nvarchar(4000),
	[user_screen_name] nvarchar(4000),
	[user_description] nvarchar(4000),
	[user_lang] nvarchar(4000),
	[user_location] nvarchar(4000),
	[user_geo_enabled] nvarchar(4000),
	[user_followers_count] nvarchar(4000),
	[user_friends_count] nvarchar(4000),
	[user_favorites_count] nvarchar(4000),
	[user_statuses_count] nvarchar(4000),
	[user_listed_count] nvarchar(4000),
	[user_created_at] nvarchar(4000),
	[user_time_zone] nvarchar(4000),
	[tweet_day] nvarchar(4000),
	[tweet_hour] nvarchar(4000),
	[tweet_minute] nvarchar(4000)
	)
	WITH (
	LOCATION = 'synapse/workspaces/2022-dsi-synapse-ws/warehouse/model_sample/loaded_capture_twitter_10M_parquet/**',
	DATA_SOURCE = [users_2022dsidatalake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.loaded_capture_twitter_10M
GO



RENAME OBJECT sample.dbo.loaded_capture_twitter_10M COLUMN ubix_received_ts TO [received_ts];
RENAME OBJECT sample.dbo.loaded_capture_twitter_10M COLUMN ubix_day TO [day];
RENAME OBJECT sample.dbo.loaded_capture_twitter_10M COLUMN ubix_hour TO [hour];
RENAME OBJECT sample.dbo.loaded_capture_twitter_10M COLUMN ubix_minute TO [minute];
