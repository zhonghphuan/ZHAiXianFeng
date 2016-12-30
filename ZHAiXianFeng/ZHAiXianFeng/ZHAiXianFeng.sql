CREATE TABLE IF NOT EXISTS T_Status (
statusId INTEGER PRIMARY KEY NOT NULL,
status TEXT,
userId TEXT,
create_date TEXT DEFAULT (datetime('now','localtime'))
);
