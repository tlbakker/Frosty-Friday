-- s3://frostyfridaychallenges/challenge_1/

// Frosty Friday challenge Week 1


// Create database
CREATE IF NOT EXISTS DATABASE TIMB_DB 
Comment = 'Comment';


// Create schema
CREATE SCHEMA CHALLENGES
COMMENT = 'Schema for SQL Challenges';


// Create Warehouse
CREATE WAREHOUSE SNOWFLAKE_WH
WITH
  WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  STATEMENT_QUEUED_TIMEOUT_IN_SECONDS = 300
  STATEMENT_TIMEOUT_IN_SECONDS = 600;


// Setup environment
USE WAREHOUSE COMPUTE_WH;
USE DATABASE TIMB_DB;
USE SCHEMA CHALLENGES;


// Create or replace file format to read file
CREATE OR REPLACE FILE FORMAT csv_format
    type = 'CSV'
--    field_delimiter = ','
--    skip_header = 1
;


//Create a stage object to reference data files stored in a s3 bucket
CREATE OR REPLACE STAGE frosty_stage
    //file_format = csv_format
    url = 's3://frostyfridaychallenges/challenge_1/';

list @frosty_stage;


//What do we have in here? 
SELECT metadata$filename
,      metadata$file_row_number
,      $1
FROM @frosty_stage(file_format => 'csv_format')
ORDER BY metadata$filename, metadata$file_row_number;


--Create a table 
CREATE OR REPLACE TABLE FF1_Table(
    Field1 VARCHAR)
    ;


--Move data from stage to table
COPY INTO FF1_Table
FROM @frosty_stage;


-- Check results
SELECT * FROM FF1_Table;