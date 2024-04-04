CREATE TABLE Users (
    User_ID CHAR(10) PRIMARY KEY,
    Pan_No CHAR(10) UNIQUE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Name CHAR(50) NOT NULL,
    Contect_No CHAR(10) UNIQUE NOT NULL,
    Hold_Balance DECIMAL(10,2)
    Available_Balance DECIMAL(10,2) ,
    Blocked_Balance DECIMAL(10,2) 
);

CREATE TABLE Account(
    Account_No VARCHAR(16) PRIMARY KEY,
    Bank_Name VARCHAR(30) NOT NULL,
    IFSC CHAR(11) UNIQUE NOT NULL,
    User_ID CHAR(10) FOREIGN KEY REFERENCES User(User_ID)
);

CREATE TABLE Transactions (
    Transaction_ID CHAR(12) PRIMARY KEY,
    Transaction_Time TIMESTAMP,
    User_ID CHAR(10) FOREIGN KEY REFERENCES Users(User_ID),
);

CREATE TABLE Bank_Wallet (
    Transaction_ID CHAR(12) FOREIGN KEY REFERENCES Transactions(Transaction_ID),
    Bank_Acc_No VARCHAR(16) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Transaction_Type VARCHAR(20) NOT NULL,
    PRIMARY KEY(Transaction_ID)
);

CREATE TABLE Wallet_Stock(
    Transaction_ID CHAR(12) FOREIGN KEY REFERENCES Transactions(Transaction_ID),
    Stock_Symbol VARCHAR(10) FOREIGN KEY REFERENCES Stocks(Stock_Symbol),
    Order_Type VARCHAR(15) NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL,
    Qty VARCHAR(10) NOT NULL,
    Current_Price DECIMAL(10,2) NOT NULL,
    Order_ID CHAR(10) FOREIGN KEY REFERENCES Order(Order_ID),
    PRIMARY KEY(Transaction_ID)
);

CREATE TABLE Watchlist (
    User_ID CHAR(10) FOREIGN KEY REFERENCES Users(User_ID),
    Stock_Symbol VARCHAR(10) FOREIGN KEY REFERENCES Stocks(Stock_Symbol),
    PRIMARY KEY (User_ID,Stock_Symbol)
);

CREATE TABLE Holdings (
    User_ID CHAR(10) FOREIGN KEY REFERENCES Users(User_ID),
    Stock_Symbol VARCHAR(10) FOREIGN KEY REFERENCES Stocks(Stock_Symbol),
    Purchase_Time TIMESTAMP,
    Invested_Price DECIMAL(10,2) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY(User_ID,Stock_Symbol,Purchase_Time)
);

CREATE TABLE Holding_History (
    User_ID CHAR(10) FOREIGN KEY REFERENCES Users(User_ID),
    Transaction_ID CHAR(12) FOREIGN KEY REFERENCES Wallet_Stock(Transaction_ID),
    To_time_stamp TIMESTAMP NOT NULL,
    From_time_stamp TIMESTAMP NOT NULL,
    Sold_Price DECIMAL(10,2) NOT NULL,
    Bought_Price DECIMAL(10,2) NOT NULL,
    Profit_loss DECIMAL(10,2) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (User_ID,Transaction_ID)
);

CREATE TABLE Stocks (
    Stock_Symbol VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(30) UNIQUE NOT NULL,
    Type VARCHAR(20) , 
    Highest DECIMAL(10,2),
    Lowest DECIMAL(10,2),
    Exchange VARCHAR(50) NOT NULL,
    CIN CHAR(21) FOREIGN KEY REFERENCES Company(CIN)
);

CREATE TABLE Stock_History (
    Time_Stamp TIMESTAMP NOT NULL,
    Stock_Symbol VARCHAR(10) FOREIGN KEY REFERENCES Stocks(Stock_Symbol),
    Inc_Dec DECIMAL(10,2) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Open_Price DECIMAL(10,2) NOT NULL,
    Previous_Close DECIMAL(10,2) NOT NULL,
    Volume VARCHAR(15) NOT NULL,
    PRIMARY KEY(Time_Stamp,Stock_Symbol)
);

CREATE TABLE Member_of (
    Stock_Symbol VARCHAR(10) FOREIGN KEY REFERENCES Stocks(Stock_Symbol),
    Group_Name VARCHAR(30) FOREIGN KEY REFERENCES Stock_Group(Group_Name),
    PRIMARY KEY(Stock_Symbol,Group_Name)
);

CREATE TABLE Stock_Grup (
    Group_Name VARCHAR(30) PRIMARY KEY,
    Lowest DECIMAL(10,2) NOT NULL,
    Highest DECIMAL(10,2) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Open_Price DECIMAL(10,2) NOT NULL,
    Close_Price DECIMAL(10,2) NOT NULL,
    Stock_Exchange VARCHAR(10) NOT NULL
);

CREATE TABLE Stock_Group_History (
    Time_Stamp TIMESTAMP NOT NULL,
    Group_Name VARCHAR(30) NOT NULL FOREIGN KEY REFERENCES Stock_Group(Group_Name),
    Inc_Dec DECIMAL(10,2) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Open_Price DECIMAL(10,2) NOT NULL,
    Previous_Close DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(Time_Stamp,Group_Name)
);

CREATE TABLE Company (
    CIN CHAR(21) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    CEO VARCHAR(30),
    Market_Capital VARCHAR(15),
    Revenue VARCHAR(20)
);

CREATE TABLE Sector(
    Sector_Name VARCHAR(20),
    CIN  CHAR(21) FOREIGN KEY REFERENCES Company(CIN),
    PRIMARY KEY(Sector_Name,CIN)

);

CREATE TABLE Order (
    Order_ID CHAR(10) PRIMARY KEY,
    Order_time TIMESTAMP NOT NULL,
    Stop_Price DECIMAL(10,2) NOT NULL,
    Status CHAR(1) NOT NULL,
    User_ID CHAR(10) NOT NULL FOREIGN KEY REFERENCES Users(User_ID),
    Stock_Symbol VARCHAR(10) NOT NULL REFERENCES Stocks(Stock_Symbol)
);

CREATE TABLE News (
    CIN CHAR(21) FOREIGN KEY REFERENCES Company(CIN),
    Title VARCHAR(50),
    Link VARCHAR(50),
    Description TEXT,
    PRIMARY KEY (CIN,Title)
);

CREATE TABLE IPO (
    IPO_Name VARCHAR(50),
    Open_Date date,
    CIN CHAR(21) FOREIGN KEY REFERENCES Company(CIN),
    Issue_Price DECIMAL(10,2) NOT  NULL,
    Close_Date DATE NOT NULL,
    Lot_Size INT NOT NULL,
    Issue_Size VARCHAR(20),
    Minimum Invest DECIMAL(10,2) NOT NULL,
    Listing_Date date,
    PRIMARY KEY(IPO_Name,Open_Date)
);









