create schema investpro
set search_path to investpro

CREATE TABLE Users (
    User_ID CHAR(10) PRIMARY KEY,
    Pan_No CHAR(10) UNIQUE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Name CHAR(30) NOT NULL,
    Contect_No CHAR(10) UNIQUE NOT NULL,
    Available_Balance DECIMAL(10,2) 
);

CREATE TABLE Account(
    Account_No VARCHAR(16) PRIMARY KEY,
    IFSC CHAR(11) UNIQUE NOT NULL,
    User_ID CHAR(10) ,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE 
);

create table Bank_info(
	IFSC CHAR(11) PRIMARY KEY REFERENCES account(IFSC)
	ON UPDATE CASCADE,
	bank_name VARCHAR(30) NOT NULL,
    PRIMARY KEY(IFSC)
);


CREATE TABLE Transactions (
    Transaction_ID CHAR(12) PRIMARY KEY,
    Transaction_Time TIMESTAMP,
    User_ID CHAR(10) ,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE 
);

CREATE TABLE Bank_Wallet (
    Transaction_ID CHAR(12) REFERENCES Transactions(Transaction_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    Bank_Acc_No VARCHAR(16) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Transaction_Type VARCHAR(20) NOT NULL,
    PRIMARY KEY(Transaction_ID)
);

CREATE TABLE Wallet_Stock(
    Transaction_ID CHAR(12) ,
    Stock_Symbol VARCHAR(30) ,
    Order_Type VARCHAR(15) NOT NULL,
    Qty VARCHAR(10) NOT NULL,
    Buy_Price DECIMAL(10,2) NOT NULL,
    Order_ID CHAR(10) ,
    PRIMARY KEY(Transaction_ID),
    FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID)
    ON UPDATE CASCADE,
    FOREIGN KEY(Transaction_ID) REFERENCES Transactions(Transaction_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY(Stock_Symbol) REFERENCES Stocks(Stock_Symbol)
    ON UPDATE CASCADE
);

CREATE TABLE Watchlist (
    User_ID CHAR(10) ,
    Stock_Symbol VARCHAR(30) ,
    PRIMARY KEY (User_ID,Stock_Symbol),
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(Stock_Symbol) REFERENCES Stocks(Stock_Symbol)
    ON UPDATE CASCADE
);

CREATE TABLE Holdings (
    User_ID CHAR(10) ,
    Stock_Symbol VARCHAR(30),
    Purchase_Time TIMESTAMP,
    Buy_Price DECIMAL(10,2) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY(User_ID,Stock_Symbol,Purchase_Time),

    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

     FOREIGN KEY(Stock_Symbol) REFERENCES Stocks(Stock_Symbol)
     ON UPDATE CASCADE
     ON DELETE CASCADE
);

CREATE TABLE Holding_History (
    User_ID CHAR(10) ,
    Transaction_ID CHAR(12),
    Purchase_time_stamp TIMESTAMP NOT NULL,
    Sold_time_stamp TIMESTAMP NOT NULL,
    Sold_Price DECIMAL(10,2) NOT NULL,
    Bought_Price DECIMAL(10,2) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (Transaction_ID),
    
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY(Transaction_ID) REFERENCES Wallet_Stock(Transaction_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Stocks (
    Stock_Symbol VARCHAR(30) PRIMARY KEY,
    Sname VARCHAR(60) UNIQUE NOT NULL,
    Stype VARCHAR(20) , 
    Highest DECIMAL(10,2),
    Lowest DECIMAL(10,2),
    Exchange VARCHAR(20) NOT NULL,
    CIN CHAR(21),
    FOREIGN KEY(CIN) REFERENCES Company(CIN)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Stock_History (
    Time_Stamp TIMESTAMP NOT NULL,
    Stock_Symbol VARCHAR(30),
    Inc_Dec DECIMAL(10,2) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Open_Price DECIMAL(10,2) NOT NULL,
    Previous_Close DECIMAL(10,2) NOT NULL,
    Volume VARCHAR(15) NOT NULL,
    PRIMARY KEY(Time_Stamp,Stock_Symbol),
    FOREIGN KEY(Stock_Symbol) REFERENCES Stocks(Stock_Symbol)
    ON UPDATE CASCADE
);

CREATE TABLE Member_of (
    Stock_Symbol VARCHAR(30),
    Group_symbol VARCHAR(30),
    PRIMARY KEY(Stock_Symbol,Group_Name),
    FOREIGN KEY(Stock_Symbol) REFERENCES Stocks(Stock_Symbol)
    ON UPDATE CASCADE,
    FOREIGN KEY(Group_symbol) REFERENCES Stock_Group(Group_symbol)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Stock_Group (
    Group_Name VARCHAR(60),
    Group_symbol VARCHAR(30) PRIMARY KEY,
    Lowest DECIMAL(10,2) NOT NULL,
    Highest DECIMAL(10,2) NOT NULL,
    Stock_Exchange VARCHAR(10) NOT NULL
);


CREATE TABLE Stock_Group_History (
    Time_Stamp TIMESTAMP NOT NULL,
    Group_symbol VARCHAR(30) NOT NULL,
    Inc_Dec DECIMAL(10,2) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Open_Price DECIMAL(10,2) NOT NULL,
    Close_Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(Time_Stamp,Group_symbol),
    FOREIGN KEY(Group_symbol) REFERENCES Stock_Group(Group_symbol)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Company (
    CIN CHAR(21) PRIMARY KEY,
    Cname VARCHAR(50) NOT NULL,
    CEO VARCHAR(50),
    Market_Capital VARCHAR(30),
    Revenue VARCHAR(30)
);

CREATE TABLE Sector(
    Sector_Name VARCHAR(30),
    CIN  CHAR(21),
    PRIMARY KEY(Sector_Name,CIN),
    FOREIGN KEY(CIN) REFERENCES Company(CIN)
    ON UPDATE CASCADE
    ON DELETE CASCADE

);

CREATE TABLE Orders (
    Order_ID CHAR(10) PRIMARY KEY,
    Order_time TIMESTAMP NOT NULL,
    User_ID CHAR(10) NOT NULL,
    Stock_Symbol VARCHAR(30),
    Trading_type VARCHAR(10) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Qty INT NOT NULL,
    Status CHAR(1) NOT NULL,
    Order_type VARCHAR(10) NOT NULL,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(Stock_Symbol) REFERENCES Stocks(Stock_Symbol)
    ON UPDATE CASCADE
);

CREATE TABLE News (
    CIN CHAR(21),
    Title TEXT,
    Description TEXT,
    PRIMARY KEY (CIN,Title),
    FOREIGN KEY(CIN) REFERENCES Company(CIN)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IPO (
    IPO_Name VARCHAR(50),
    Open_Date date,
    CIN CHAR(21),
    Issue_Price VARCHAR(20) NOT  NULL,
    Close_Date DATE NOT NULL,
    Lot_Size INT NOT NULL,
    Issue_Size VARCHAR(20),
    Minimum_Invest DECIMAL(10,2) NOT NULL,
    Listing_Date date,
    PRIMARY KEY(IPO_Name),
    FOREIGN KEY(CIN) REFERENCES Company(CIN)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);









