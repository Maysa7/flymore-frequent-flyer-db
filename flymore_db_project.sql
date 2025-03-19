-- PASSENGERS table holds passenger information, including 2 multi-variable attributes
CREATE TABLE Passengers  
    (   passid          VARCHAR2(38), 
        pname           VARCHAR2(25),  
        ssn             VARCHAR2(11) NOT NULL,
        is_member       CHAR(1),
            CONSTRAINT is_member_bool CHECK (is_member IN ('1','0')), -- 0 for false, 1 for true
        gender          VARCHAR2(1),
        email           VARCHAR2(25),
        occupation      VARCHAR2(50),
        dob             DATE NOT NULL,
        PRIMARY KEY (passid)
    );

-- Multi-variable attribute Phone from passengers
CREATE TABLE Phone
    (   phone_number    VARCHAR2(20) NOT NULL,
        passid          VARCHAR2(38) NOT NULL,
        FOREIGN KEY (passid) 
            REFERENCES PASSENGERS (passid) ON DELETE CASCADE
    );

-- Multi-variable attribute address from passengers
CREATE TABLE Address
    (   zip             VARCHAR2(11), -- 11 characters to include foreign characters
        home_num        VARCHAR2(5),
        street          VARCHAR2(45), -- 45 characters for USA's longest street name
        city            VARCHAR2(20),
        state           VARCHAR2(12),
        passid          VARCHAR2(38) NOT NULL,
        FOREIGN KEY (passid) 
            REFERENCES Passengers (passid) ON DELETE CASCADE
    );

CREATE TABLE Card
    (   card_id         NUMBER(16),
        is_valid        CHAR(1),
            CONSTRAINT is_valid_bool CHECK (is_valid IN ('1','0')), -- 0 for false, 1 for true
        expiry_date     DATE,
        c_date          DATE NOT NULL,
        passid          VARCHAR2(38) NOT NULL,
        PRIMARY KEY (card_id, passid),
        FOREIGN KEY (passid)
            REFERENCES Passengers (passid) ON DELETE CASCADE
    );

CREATE TABLE Login
    (   username        VARCHAR2(50),
        password        VARCHAR2(50),
        passid          VARCHAR2(38) NOT NULL,
        PRIMARY KEY (username, passid),
        FOREIGN KEY (passid)
            REFERENCES Passengers (passid) ON DELETE CASCADE
    );

CREATE TABLE Awards
    (   award_id        VARCHAR2(38),
        a_description   VARCHAR2(100),
        points_required NUMBER(5),
        PRIMARY KEY (award_id)
    );

CREATE TABLE ExchgCenters
    (   center_id       VARCHAR2(38),
        center_name     VARCHAR2(50),
        c_location      VARCHAR2(50),
        PRIMARY KEY (center_id)
    );

CREATE TABLE Point_Accounts
    (   point_account_id    VARCHAR2(38),
        total_points        NUMBER(12),
        passid              VARCHAR2(38) NOT NULL,
        PRIMARY KEY (point_account_id),
        UNIQUE (passid),
        FOREIGN KEY (passid)
            REFERENCES Passengers (passid) ON DELETE CASCADE
    );

CREATE TABLE Passengers_Awards
    (   passid              VARCHAR2(38), 
        award_id            VARCHAR2(38),
        redemption_date     DATE,
        quantity            NUMBER(4),
        center_id           VARCHAR2(38) NOT NULL,
        point_account_id    VARCHAR2(38) NOT NULL,
        PRIMARY KEY(passid, award_id),
        FOREIGN KEY (passid)
            REFERENCES Passengers (passid)  ON DELETE CASCADE,
        FOREIGN KEY (award_id)
            REFERENCES Awards (award_id),
        FOREIGN KEY (center_id)
            REFERENCES ExchgCenters (center_id),
        FOREIGN KEY (point_account_id)
            REFERENCES Point_Accounts (point_account_id)
    );

-- honestly a BIT confused on the passenger to flight relationship
CREATE TABLE Flights
    (   flight_id           VARCHAR2(38),
        source              VARCHAR2(255),
        destination         VARCHAR2(255),
        arrival_datetime    DATE,
        dept_datetime       DATE,
        flight_miles        NUMBER(5),
        point_account_id    VARCHAR2(38) NOT NULL,
        passid              VARCHAR2(38) NOT NULL, 
        PRIMARY KEY (flight_id),
        FOREIGN KEY (point_account_id)
            REFERENCES Point_Accounts (point_account_id),
        FOREIGN KEY (passid)
            REFERENCES Passengers (passid)
    );

CREATE TABLE Trips
    (   trip_id             VARCHAR2(38),
        trip_miles          NUMBER(5),
        source              VARCHAR2(255),
        destination         VARCHAR2(255),
        arrival_datetime    DATE,
        dept_datetime       DATE,
        PRIMARY KEY(trip_id)
    );

CREATE TABLE Flights_Trips
    (   flight_id       VARCHAR2(38),
        trip_id         VARCHAR2(38) NOT NULL,
        PRIMARY KEY (flight_id, trip_id),
        FOREIGN KEY (flight_id)
            REFERENCES Flights (flight_id) ON DELETE CASCADE,
        FOREIGN KEY (trip_id)
            REFERENCES Trips (trip_id)
    );

CREATE TABLE Promotions 
    (   prom_id         VARCHAR2(38),
        prom_action     VARCHAR(50),
        prom_period     INTERVAL DAY(4) TO SECOND(2),
        p_description   VARCHAR2(100),
        PRIMARY KEY (prom_id)
    );

CREATE TABLE Flights_Promotions
    (   flight_id       VARCHAR2(38),
        prom_id         VARCHAR2(38),
        PRIMARY KEY (flight_id, prom_id),
        FOREIGN KEY (flight_id)
            REFERENCES Flights (flight_id),
        FOREIGN KEY (prom_id)
            REFERENCES Promotions (prom_id)
    );

CREATE TABLE Empl_Incentives 
    (   incentive_id        VARCHAR2(38),
        passenger_id        VARCHAR2(38),
        flight_id           VARCHAR2(38),
        percent_increase    NUMBER(5,2),
        PRIMARY KEY (incentive_id),
        FOREIGN KEY (flight_id)
            REFERENCES Flights (flight_id)
    );

CREATE TABLE Empl_Referrals 
    (   referral_id         VARCHAR2(38),
        passenger_id        VARCHAR2(38),
        flight_id           VARCHAR2(38),
        percent_increase    NUMBER(5,2),
        PRIMARY KEY (referral_id),
        FOREIGN KEY (flight_id)
            REFERENCES Flights (flight_id)
    );