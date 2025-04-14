-- CREATE TABLE STATEMENTS
USE Lab5;
CREATE TABLE Investor (
    Phone VARCHAR(8) PRIMARY KEY,    -- e.g., '88888801'
    Investor_Name VARCHAR(50) NOT NULL,       -- Assumed (e.g., 'John Doe')
    Gender CHAR(1) NOT NULL,         -- Assumed (e.g., 'M')
    DOB DATE NOT NULL,               -- Assumed (e.g., '1990-01-01')
    Annual_Income DECIMAL(15,2) NOT NULL, -- Assumed (e.g., 75000.00)
    Company VARCHAR(100) NOT NULL,   -- Assumed (e.g., 'Tech Corp')
    CONSTRAINT CHK_Phone CHECK (Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CHK_Gender CHECK (Gender IN ('M', 'F', 'O'))
);
CREATE TABLE Risk_Tolerance (
    Investor_Phone VARCHAR(8) NOT NULL, -- e.g., '88888801'
    Risk_Level VARCHAR(20) NOT NULL,   -- e.g., 'Low'
    Q1_Answer VARCHAR(50) NOT NULL,    -- Assumed (e.g., 'Yes')
    Q2_Answer VARCHAR(50) NOT NULL,    -- Assumed (e.g., 'No')
    Q3_Answer VARCHAR(50) NOT NULL,    -- Assumed (e.g., 'Maybe')
    Q4_Answer VARCHAR(50) NOT NULL,    -- Assumed (e.g., 'Yes')
    Q5_Answer VARCHAR(50) NOT NULL,    -- Assumed (e.g., 'No')
    PRIMARY KEY (Investor_Phone, Risk_Level),
    FOREIGN KEY (Investor_Phone) REFERENCES Investor(Phone)
);

CREATE TABLE Financial_Goal (
    investor_phone VARCHAR(8) NOT NULL, -- e.g., '88888801'
    goal VARCHAR(50) NOT NULL,         -- e.g., 'Retirement'
    timeline DATE NOT NULL,             -- e.g., 10 (years)
    amount DECIMAL(15,2) NOT NULL,     -- e.g., 500000.00
    PRIMARY KEY (investor_phone, goal),
    FOREIGN KEY (investor_phone) REFERENCES Investor(Phone)
);

CREATE TABLE Portfolio (
    Investor_Phone VARCHAR(8) NOT NULL, -- e.g., '88888801'
    Portfolio_PID VARCHAR(4) NOT NULL,  -- e.g., 'P001'
    Annualized_Return DECIMAL(5,2) NOT NULL, -- e.g., 16.45
    Inception_Date DATE NOT NULL,       -- e.g., '2024-01-15'
    Market_Value INT NOT NULL,          -- e.g., 1678
    Fee INT NOT NULL,                   -- e.g., 121
    PRIMARY KEY (Investor_Phone, Portfolio_PID),
    FOREIGN KEY (Investor_Phone) REFERENCES Investor(Phone)
);


CREATE TABLE Unrealized_Gain_Loss (
    investor_phone VARCHAR(8) NOT NULL, -- e.g., '88888801'
    portfolio_pid VARCHAR(4) NOT NULL,  -- e.g., 'P001'
    unrealized_gains_loss_date DATE NOT NULL, -- e.g., '2024-01-15'
    Amount DECIMAL(15,2) NOT NULL,      -- e.g., 500.00 (assumed)
    PRIMARY KEY (Investor_Phone, Portfolio_PID, unrealized_gains_loss_date),
    FOREIGN KEY (Investor_Phone, Portfolio_PID) REFERENCES Portfolio(Investor_Phone, Portfolio_PID)
);
CREATE TABLE Invested_Value (
    Investor_Phone VARCHAR(8) NOT NULL, -- e.g., '88888801'
    Portfolio_PID VARCHAR(4) NOT NULL,  -- e.g., 'P001'
    Invested_Value_Date DATE NOT NULL,  -- e.g., '2024-01-15'
    Amount DECIMAL(15,2) NOT NULL,      -- e.g., 10000.00 (assumed)
    PRIMARY KEY (Investor_Phone, Portfolio_PID, Invested_Value_Date),
    FOREIGN KEY (Investor_Phone, Portfolio_PID) REFERENCES Portfolio(Investor_Phone, Portfolio_PID)
);

CREATE TABLE Assets (
    ID INT PRIMARY KEY,                 -- e.g., 1 to 663
    Asset_Name VARCHAR(50) NOT NULL,          -- e.g., 'Apple' (assumed)
    Price DECIMAL(10,2) NOT NULL        -- e.g., 100.50 (assumed)
);

CREATE TABLE Stock (
    ID INT PRIMARY KEY,                 -- e.g., 1 to 221
    PE_Ratio DECIMAL(5,2) NOT NULL,     -- e.g., 18.45
    EPS DECIMAL(4,2) NOT NULL,          -- e.g., 6.45
    EBITDA DECIMAL(7,2) NOT NULL,       -- e.g., 712.56
);

CREATE TABLE Bond (
    ID INT PRIMARY KEY,                 -- e.g., 222 to 442
    Interest_Rate DECIMAL(3,2) NOT NULL, -- e.g., 5.23
    Maturity_Date DATE NOT NULL,        -- e.g., '2035-02-28'
);

CREATE TABLE Fund (
    ID INT PRIMARY KEY,                 -- e.g., 443 to 663
    Expense_Ratio DECIMAL(3,2) NOT NULL, -- e.g., 0.91
    Dividend_Yield DECIMAL(3,2) NOT NULL, -- e.g., 3.01
    FOREIGN KEY (ID) REFERENCES Assets(ID)
);

CREATE TABLE Stock_In_Portfolio (
    ID INT NOT NULL,                    -- e.g., 1 to 221
    PID VARCHAR(4) NOT NULL,            -- e.g., 'P001'
    Phone VARCHAR(8) NOT NULL,          -- e.g., '88888801'
    start__date DATE NOT NULL,           -- e.g., '2024-01-15'
    Allocation_Ratio DECIMAL(3,2) NOT NULL, -- e.g., 0.4
    Post_trade_CO VARCHAR(50) NOT NULL, -- e.g., 'Apple'
    PRIMARY KEY (ID, PID, Phone),
    FOREIGN KEY (Phone, PID) REFERENCES Portfolio(Investor_Phone, Portfolio_PID)
);

CREATE TABLE Bond_In_Portfolio (
    ID INT NOT NULL,                    -- e.g., 222 to 442
    PID VARCHAR(4) NOT NULL,            -- e.g., 'P001'
    Phone VARCHAR(8) NOT NULL,          -- e.g., '88888801'
    start__date DATE NOT NULL,           -- e.g., '2024-01-15'
    Allocation_Ratio DECIMAL(3,2) NOT NULL, -- e.g., 0.3
    Post_trade_CO VARCHAR(50) NOT NULL, -- e.g., 'Treasury 2Y'
    PRIMARY KEY (ID, PID, Phone),
    FOREIGN KEY (Phone, PID) REFERENCES Portfolio(Investor_Phone, Portfolio_PID)
);

CREATE TABLE Fund_In_Portfolio (
    ID INT NOT NULL,                    -- e.g., 443 to 663
    PID VARCHAR(4) NOT NULL,            -- e.g., 'P001'
    Phone VARCHAR(8) NOT NULL,          -- e.g., '88888801'
    start__date DATE NOT NULL,           -- e.g., '2024-01-15'
    Allocation_Ratio DECIMAL(3,2) NOT NULL, -- e.g., 0.5
    Post_trade_CO VARCHAR(50) NOT NULL, -- e.g., 'SP500 ETF'
    PRIMARY KEY (ID, PID, Phone),
    FOREIGN KEY (Phone, PID) REFERENCES Portfolio(Investor_Phone, Portfolio_PID)
);

CREATE TABLE Stock_Transaction (
    stock_transaction_date DATE NOT NULL, -- e.g., '2024-01-15' (assumed)
    stock_ID INT NOT NULL,   -- e.g., 1 (refers to Stock.ID)
    transaction_type VARCHAR(10) NOT NULL,            -- e.g., 'Buy' (assumed)
    Fee DECIMAL(10,2) NOT NULL,           -- e.g., 50.00 (assumed)
    PRIMARY KEY (stock_transaction_date, stock_ID),
    FOREIGN KEY (stock_ID) REFERENCES Stock(ID)
);

CREATE TABLE Bond_Transaction (
    bond_transaction_date DATE NOT NULL,  -- e.g., '2024-01-15' (assumed)
    bond_ID INT NOT NULL,    -- e.g., 222 (refers to Bond.ID)
    transaction_type VARCHAR(10) NOT NULL,            -- e.g., 'Sell' (assumed)
    Fee DECIMAL(10,2) NOT NULL,           -- e.g., 75.00 (assumed)
    PRIMARY KEY (Bond_Transaction_Date, Bond_ID),
    FOREIGN KEY (Bond_ID) REFERENCES Bond(ID)
);

CREATE TABLE Fund_Transaction (
    fund_transaction_date DATE NOT NULL,  -- e.g., '2024-01-15' (assumed)
    fund_ID INT NOT NULL,    -- e.g., 443 (refers to Fund.ID)
    transaction_type VARCHAR(10) NOT NULL,            -- e.g., 'Buy' (assumed)
    Fee DECIMAL(10,2) NOT NULL,           -- e.g., 25.00 (assumed)
    PRIMARY KEY (Fund_Transaction_Date, Fund_ID),
    FOREIGN KEY (Fund_ID) REFERENCES Fund(ID)
);

-- DROP TABLE STATEMENTS

