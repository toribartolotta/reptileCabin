-- victoria bartolotta
-- csc 341 database
-- fall 2019
-- course project
-- the reptile cabin database

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY hh:mi';

CREATE TABLE CUSTOMER   (
CNO         CHAR(3)          CONSTRAINT PK_CUSTOMER PRIMARY KEY,
CNAME       VARCHAR2(30)     NOT NULL,
PHONE       VARCHAR2(10)     NOT NULL,
ADDRESS     VARCHAR2(30)     NOT NULL,
CITY        VARCHAR2(20)     NOT NULL,
STATE       CHAR(2)          NOT NULL,
ZIP         CHAR(5)          NOT NULL);

COMMIT;

CREATE TABLE REPTILETYPE   (
RNAME       VARCHAR(20)     CONSTRAINT PK_REPTILETYPE PRIMARY KEY,
RTYPE       VARCHAR(9)      NOT NULL,
TEMPHIGH    CHAR(3)         NOT NULL,
TEMPLOW     CHAR(3)         NOT NULL);

COMMIT;

CREATE TABLE PET    (
PNO         CHAR(3)         CONSTRAINT PK_PET PRIMARY KEY,
CNO         CHAR(3)         CONSTRAINT FK_CNO REFERENCES CUSTOMER(CNO),       
RTYPE       VARCHAR2(20)    CONSTRAINT FK_RTYPE REFERENCES REPTILETYPE(RNAME),
PNAME       VARCHAR2(20)    NOT NULL,
AGE         CHAR(2),
COMMENTS    VARCHAR2(150));

COMMIT;

CREATE TABLE VISIT  (
VNO         CHAR(3)     CONSTRAINT PK_VISIT PRIMARY KEY,
PNO         CHAR(3)     CONSTRAINT FK_PNO REFERENCES PET(PNO),
VTYPE       VARCHAR2(9) NOT NULL,
STARTDATE   DATE        NOT NULL,
PICKUPDATE  DATE);

COMMIT;

CREATE TABLE PAYMENT   (
PAYNO       CHAR(3)     CONSTRAINT PK_PAYMENT PRIMARY KEY,
VNO         CHAR(3)     CONSTRAINT FK_VNO REFERENCES VISIT(VNO),
PAYDATE     DATE        NOT NULL,
TOTAL       CHAR(3)     NOT NULL);

COMMIT;


-- INSERT STATEMENTS
INSERT INTO CUSTOMER VALUES ('001', 'BOB SMITH', '8605556688', '15 WALNUT ST', 'WILLIMANTIC', 'CT', '06226');
INSERT INTO CUSTOMER VALUES ('002', 'LAURA JONES', '2032678899', '500 MAIN ST', 'WILLIMANTIC', 'CT', '06226');
INSERT INTO CUSTOMER VALUES ('003', 'MIKE L', '8606781234', '18 ELM ST', 'CROMWELL', 'CT', '06416');
INSERT INTO CUSTOMER VALUES ('004', 'RACHEL B', '8609014474', '144 HIGH ST', 'WILLIMANTIC', 'CT', '06226');

INSERT INTO REPTILETYPE VALUES ('BEARDED DRAGON', 'DESERT', '110', '80');
INSERT INTO REPTILETYPE VALUES ('CHINESE WATER DRAGON', 'TROPICAL', '100', '70');
INSERT INTO REPTILETYPE VALUES ('TEGU', 'DESERT', '100', '75');
INSERT INTO REPTILETYPE VALUES ('LEOPARD GECKO', 'TROPICAL', '90', '75');
INSERT INTO REPTILETYPE VALUES ('CRESTED GECKO', 'TROPICAL', '78', '68');
INSERT INTO REPTILETYPE VALUES ('VELIED CHAMELEONS', 'TROPICAL', '100', '70');
INSERT INTO REPTILETYPE VALUES ('GREEN IGUANA', 'TROPICAL', '100', '70');

INSERT INTO PET VALUES ('100', '001', 'BEARDED DRAGON', 'PANCAKES', '02', 'LIKES KALE EVERYDAY, EATS EVERYTHING');
INSERT INTO PET VALUES ('101', '002', 'LEOPARD GECKO', 'MANGO', '01', NULL);
INSERT INTO PET VALUES ('102', '002', 'LEOPARD GECKO', 'PINKY', '02', 'NEEDS CALCIUM SUPPLEMENT DAILY ON FOOD');
INSERT INTO PET VALUES ('103', '003', 'TEGU', 'BAGEL', '10', NULL);
INSERT INTO PET VALUES ('104', '004', 'CRESTED GECKO', 'LILY', NULL, NULL);
INSERT INTO PET VALUES ('105', '004', 'GREEN IGUANA', 'IGGY', '05', NULL);

INSERT INTO VISIT VALUES ('050', '100', 'OVERNIGHT', '01-JUN-2018 11;00', '03-JUN-2018 05:00');
INSERT INTO VISIT VALUES ('051', '101', 'DAYCARE', '01-JUN-2018 09:00', '01-JUN-2018 06:00');
INSERT INTO VISIT VALUES ('052', '102', 'DAYCARE', '01-JUN-2018 09:00', '01-JUN-2018 06:00');
INSERT INTO VISIT VALUES ('053', '100', 'DAYCARE', '02-JUN-2018 09:30', '02-JUN-2018 05:45');
INSERT INTO VISIT VALUES ('054', '103', 'OVERNIGHT', '02-JUN-2018 10:00', '03-JUN-2018 04:45');
INSERT INTO VISIT VALUES ('055', '104', 'OVERNIGHT', '03-JUN-2018 11:30', '05-JUN-2018 05:30');
INSERT INTO VISIT VALUES ('056', '105', 'OVERNIGHT', '03-JUN-2018 11:30', '05-JUN-2018 05:30');
INSERT INTO VISIT VALUES ('057', '103', 'DAYCARE', '04-JUN-2018 09:30', '04-JUN-2018 06:00'); 
INSERT INTO VISIT VALUES ('058', '100', 'DAYCARE', '05-JUN-2018 08:45', '05-JUN-2018 05:45');
INSERT INTO VISIT VALUES ('059', '101', 'OVERNIGHT', '10-JUN-2018 9:00', '12-JUN-2018 06:10');
INSERT INTO VISIT VALUES ('060', '102', 'OVERNIGHT', '10-JUN-2018 9:00', '12-JUN-2018 06:10');

INSERT INTO PAYMENT VALUES ('001', '050', '03-JUN-2018 05:14', '150');
INSERT INTO PAYMENT VALUES ('002', '051', '01-JUN-2018 06;10', '050');
INSERT INTO PAYMENT VALUES ('003', '052', '01-JUN-2018 06:11', '050');
INSERT INTO PAYMENT VALUES ('004', '053', '02-JUN-2018 05:59', '050');
INSERT INTO PAYMENT VALUES ('005', '054', '03-JUN-2018 05:00', '100');
INSERT INTO PAYMENT VALUES ('006', '055', '05-JUN-2018 05:45', '150');
INSERT INTO PAYMENT VALUES ('007', '056', '05-JUN-2018 05:46', '150');
INSERT INTO PAYMENT VALUES ('008', '057', '04-JUN-2018 06:10', '050');
INSERT INTO PAYMENT VALUES ('009', '058', '05-JUN-2018 05:44', '050');

COMMIT;

-- REPORTING REQUIREMENTS 
SELECT CNAME, PHONE, PNAME
FROM CUSTOMER, PET, VISIT
WHERE CUSTOMER.CNO = PET.CNO
AND PET.PNO = VISIT.PNO
AND VISIT.VTYPE = 'OVERNIGHT'
AND VISIT.PNO >= 2;


SELECT PET.RTYPE, COUNT(PET.RTYPE) 
FROM PET, REPTILETYPE 
WHERE PET.RTYPE = REPTILETYPE.RNAME
GROUP BY PET.RTYPE
HAVING COUNT(*) >= 2;


SELECT PET.PNAME, PET.RTYPE, VISIT.VTYPE, REPTILETYPE.TEMPLOW, REPTILETYPE.TEMPHIGH, PET.COMMENTS, CUSTOMER.CNAME, CUSTOMER.PHONE, VISIT.PICKUPDATE
FROM CUSTOMER, REPTILETYPE, PET, VISIT
WHERE CUSTOMER.CNO = PET.CNO
AND PET.RTYPE = REPTILETYPE.RNAME
AND PET.PNO = VISIT.PNO
ORDER BY PICKUPDATE DESC;