CREATE TABLE user_account (
  user_account_id BIGINT,
  username TEXT UNIQUE, 
  password TEXT,
  email TEXT UNIQUE,

  PRIMARY KEY (user_account_id)
);
