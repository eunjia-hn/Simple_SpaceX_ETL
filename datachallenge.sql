CREATE DATABASE spaceX;
USE spaceX;

-- Creating tables
CREATE TABLE tblROCKETS
(RocketID INT NOT NULL AUTO_INCREMENT,
RocketCode varchar(255) NOT NULL,
RocketName varchar(255) NOT NULL,
PRIMARY KEY(RocketID));

CREATE TABLE tblSHIPS
(ShipID INT NOT NULL AUTO_INCREMENT,
ShipCode varchar(255),
ShipName varchar(255),
PRIMARY KEY (ShipID));

CREATE TABLE tblLAUNCHES
(LaunchID INT NOT NULL AUTO_INCREMENT,
LaunchCode varchar(255),
Success varchar(255),
RocketID INT,
PRIMARY KEY(LaunchID));

CREATE TABLE tblPAYLOADS
(PayloadID INT NOT NULL AUTO_INCREMENT,
PayloadCode varchar(255),
Nationality varchar(255),
LaunchID INT,
PRIMARY KEY(PayloadID));

CREATE TABLE tblLAUNCH_SHIP
(LaunchShipID INT NOT NULL AUTO_INCREMENT,
LaunchID INT,
ShipID INT,
PRIMARY KEY(LaunchShipID),
FOREIGN KEY(LaunchID) REFERENCES tblLAUNCHES(LaunchID),
FOREIGN KEY(ShipID) REFERENCES tblSHIPS(ShipID));

ALTER TABLE tblLAUNCHES
ADD FOREIGN KEY (RocketID) REFERENCES tblROCKETS(RocketID);

ALTER TABLE tblPAYLOADS
ADD FOREIGN KEY(LaunchID) REFERENCES tblLAUNCHES(LaunchID);

-- Inserting data
INSERT INTO tblROCKETS(RocketCode, RocketName)
SELECT id, name
FROM RAW_rockets;

INSERT INTO tblSHIPS(ShipCode, ShipName)
SELECT DISTINCT id, name
FROM RAW_Ships;


-- GetLauncheID
USE `spaceX`;
DROP procedure IF EXISTS `GetLaunchID`;

DELIMITER $$
USE `spaceX`$$
CREATE PROCEDURE `GetLaunchID` (IN lcode varchar(255))
BEGIN
	SELECT LaunchID
    FROM tblLAUNCHES
    WHERE LaunchCode = lcode;
END$$

DELIMITER ;

-- GetShipID
USE `spaceX`;
DROP procedure IF EXISTS `GetShipID`;

DELIMITER $$
USE `spaceX`$$
CREATE PROCEDURE `GetShipID` (IN scode varchar(255))
BEGIN
	SELECT ShipID
    FROM tblSHIPS
    WHERE ShipCode = scode;
END$$

DELIMITER ;


-- tblLAUNCHES --
-- InsertLaunches
USE `spaceX`;
DROP procedure IF EXISTS `InsertLaunches`;

DELIMITER $$
USE `spaceX`$$
CREATE PROCEDURE `InsertLaunches` 
(IN p_launchcode varchar(255),
IN p_success varchar(255),
IN p_rocketID INT)
BEGIN
    INSERT INTO tblLAUNCHES(LaunchCode, Success, rocketID)
    VALUES(p_launchcode, p_success, p_rocketID);
END$$

DELIMITER ;

-- Working Copy
CREATE TABLE PK_Launches
(LaunchID INT NOT NULL AUTO_INCREMENT,
LaunchCode varchar(255),
Success varchar(255),
RocketCode varchar(255),
PRIMARY KEY(LaunchID));

INSERT INTO PK_Launches
(LaunchCode, Success, RocketCode)
SELECT id, success, rocket
FROM raw_launches;

-- pop launches
USE `spaceX`;
DROP procedure IF EXISTS `popLaunches`;

DELIMITER $$
USE `spaceX`$$
CREATE PROCEDURE `popLaunches` (
IN count INT)
BEGIN
	DECLARE lc varchar(255);
    DECLARE s varchar(255);
    DECLARE rc varchar(255);
    DECLARE r_id INT;
    
    WHILE count > 0 DO
        SET lc = (SELECT launchcode FROM PK_launches WHERE LaunchID = count);
        SET s = (SELECT success FROM PK_launches WHERE LaunchID = count);
        SET rc = (SELECT rocketcode FROM PK_launches WHERE LaunchID = count);
        SET r_id = (SELECT RocketID FROM tblROCKETS WHERE RocketCode = rc);

		CALL InsertLaunches(lc, s, r_id);
        DELETE FROM PK_launches WHERE launchID = count;
        SET count = count - 1;
	END WHILE;
END$$

SELECT RocketID FROM tblROCKETS WHERE RocketCode = '5e9d0d95eda69955f709d1eb';

-- calling procedure
CALL popLaunches((SELECT COUNT(*) FROM PK_launches));


-- tblPAYLOADS --
-- working copy with PK
CREATE TABLE PK_PAYLOADS
(PayloadID INT NOT NULL AUTO_INCREMENT,
PayloadCode varchar(255),
Nationality varchar(255),
launchcode varchar(255),
PRIMARY KEY(PayloadID));

INSERT INTO PK_PAYLOADS
(Payloadcode, nationality, launchcode)
SELECT id, nationalities, launch
FROM raw_payloads;

-- Insertpayload
USE `spaceX`;
DROP procedure IF EXISTS `insertPayloads`;

DELIMITER $$
USE `spaceX`$$
CREATE PROCEDURE `insertPayloads` (
IN count INT)
BEGIN
	DECLARE pc varchar(255);
    DECLARE n varchar(255);
    DECLARE lc varchar(255);
    DECLARE l_id INT;
    
    WHILE count > 0 DO
		SET pc = (SELECT payloadCode FROM PK_payloads WHERE payloadid = count);
        SET n = (SELECT nationality FROM PK_payloads WHERE payloadid = count);
        SET lc = (SELECT launchcode FROM PK_payloads WHERE payloadid = count);
        SET l_id = (SELECT launchID FROM tblLAUNCHES WHERE launchCode = lc);


        INSERT INTO tblPAYLOADS(payloadcode, nationality, launchID)
        VALUES (pc, n, l_id);
        
        DELETE FROM PK_Payloads WHERE payloadid = count;
        SET count = count - 1;
        END WHILE;
END$$

DELIMITER ;
-- calling procedure
CALL insertPayloads((SELECT COUNT(*) FROM PK_payloads));


-- tblLAUNCH_SHIP --
-- working copy with PK
CREATE TABLE PK_LAUNCH_SHIP
(LaunchShipID INT NOT NULL AUTO_INCREMENT,
LaunchCode varchar(255),
ShipCode varchar(255),
PRIMARY KEY(PayloadID));

INSERT INTO PK_LAUNCH_SHIP
(Payloadcode, nationality, launchcode)
SELECT id, nationalities, launch
FROM raw_payloads;

CREATE TABLE tblLAUNCH_SHIP
(LaunchShipID INT NOT NULL AUTO_INCREMENT,
LaunchID INT,
ShipID INT,
PRIMARY KEY(LaunchShipID),
FOREIGN KEY(LaunchID) REFERENCES tblLAUNCHES(LaunchID),
FOREIGN KEY(ShipID) REFERENCES tblSHIPS(ShipID));
