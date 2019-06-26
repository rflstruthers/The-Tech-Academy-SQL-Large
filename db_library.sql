CREATE DATABASE db_library;
USE db_library

--Create Tables:
GO
CREATE TABLE libraryBranch (
	branchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	branchName VARCHAR(50) NOT NULL,
	branchAddress VARCHAR (100) NOT NULL
	);
CREATE TABLE publisher (
	publisherName VARCHAR(50) PRIMARY KEY NOT NULL,
	publisherAddress VARCHAR(100),
	publisherPhone VARCHAR(20)
	);
CREATE TABLE barrower (
	cardNumber INT PRIMARY KEY NOT NULL IDENTITY (900000,1),
	barrowerName VARCHAR(50) NOT NULL,
	barrowerAddress VARCHAR(50),
	barrowerPhone VARCHAR(20)
	);
CREATE TABLE books (
	bookID INT PRIMARY KEY NOT NULL IDENTITY (1000,1),
	title VARCHAR(100) NOT NULL,
	publisherName VARCHAR(50) NOT NULL CONSTRAINT fk_publisherName_books FOREIGN KEY REFERENCES publisher(publisherName) ON UPDATE CASCADE ON DELETE CASCADE
	);
CREATE TABLE bookCopies (
	branchID INT NOT NULL CONSTRAINT fk_branchID_copies FOREIGN KEY REFERENCES libraryBranch(branchID) ON UPDATE CASCADE ON DELETE CASCADE,
	bookID INT NOT NULL CONSTRAINT fk_bookID_copies FOREIGN KEY REFERENCES books(bookID) ON UPDATE CASCADE ON DELETE CASCADE,
	numberOfCopies INT NOT NULL
	);
CREATE TABLE bookLoans (
	branchID INT NOT NULL CONSTRAINT fk_branchID_loans FOREIGN KEY REFERENCES libraryBranch(branchID) ON UPDATE CASCADE ON DELETE CASCADE,
	bookID INT NOT NULL CONSTRAINT fk_bookID_loans FOREIGN KEY REFERENCES books(bookID) ON UPDATE CASCADE ON DELETE CASCADE,
	cardNumber INT NOT NULL CONSTRAINT fk_cardNumber_loans FOREIGN KEY REFERENCES barrower(cardNumber) ON UPDATE CASCADE ON DELETE CASCADE,
	dateOut DATE NOT NULL,
	dateDue DATE NOT NULL
	);
CREATE TABLE bookAuthors (
	bookID INT NOT NULL CONSTRAINT fk_bookID_authors FOREIGN KEY REFERENCES books(bookID) ON UPDATE CASCADE ON DELETE CASCADE,
	authorLname VARCHAR(50) NOT NULL,
	authorFname VARCHAR(50) NOT NULL
	);
GO

--Populate Tables
GO
INSERT INTO libraryBranch--sharpstown, central, at least 4
	(branchName,branchAddress)
	VALUES
	('Sharpstown', '180 Hill Road, Sharpstown, OR 97000'),
	('Central', '6728 1st Street, Sharpstown, OR 97000'),
	('East Side', '1299 Lake Avenue, Sharpstown, OR 97123'),
	('West Side', '45823 Forest Boulevard, Sharpstown, OR 97124')
	;
SELECT * FROM libraryBranch;

INSERT INTO publisher
	(publisherName,publisherAddress,publisherPhone)
	VALUES
	('Sharpstown Publishing','345 14th St. Sharpstown, OR 97200','222-456-3987'),
	('Gallery Books','67 Griswald St. York, ME 78365','837-376-0982'),
	('Random House','23 5th Ave. NY, NY 10101','222-456-3987'),
	('Tech Publishing','5 Long Way San Francisco, CA 76829','376-982-2876'),
	('Outdoor Books, Inc.','98720 Green St. Butte, MT 34987','652-298-4783'),
	('UVM Press','100 Main St. Burlington, VT 05451','802-999-7234'),
	('Penguin Books','55 South Ave. Los Angeles, CA 90210','732-498-3223'),
	('Avon Books','14 High St. London, England','4-298-384-5729'),
	('BrewPress','1 Flatiron Rd. Boulder, CO 93873','909-222-7373'),
	('Workman','98 Beach Dr. Miami, FL 88873','444-772-3333'),
	('Phaidon','777 Sutton St. NY, NY 10123','888-222-3333'),
	('Boston Books','1 Commonwealth Ave, Boston, MA 82783','314-288-0982')
	;
SELECT * FROM publisher;

INSERT INTO barrower--8 borrowers, 2 have more than 5 books out
	(barrowerName,barrowerAddress,barrowerPhone)
	VALUES
	('James Smith','12 6th St. Sharpstown, OR 97200','222-456-9384'),
	('Randy Green','785 Wind St. Sharpstown, OR 97200','222-498-0098'),
	('Sally Doe','1666 Howard Rd. Sharpstown, OR 97200','222-998-6654'),
	('Roger Mcnab','65 Allen Dr. Sharpstown, OR 97200','222-654-1123'),
	('Jeff Lacy','74 32nd St. Sharpstown, OR 97200','222-987-5566'),
	('June Hardy','354 Norman St. Sharpstown, OR 97200','222-887-9873'),
	('Marge Tiller','5312 West Ave. Sharpstown, OR 97200','222-898-8723'),
	('Murphy Brown','55 Tin Rd. Sharpstown, OR 97200','222-254-9866')
	;
SELECT * FROM barrower;

INSERT INTO books--at least 20
	(title,publisherName)
	VALUES
	('The Lost Tribe','Sharpstown Publishing'),
	('IT','Gallery Books'),
	('Cell','Gallery Books'),
	('Under The Dome','Gallery Books'),
	('The Hobbit','Random House'),
	('Coding For Dummies','Tech Publishing'),
	('Bend Hiking','Outdoor Books, Inc.'),
	('U.S. History','UVM Press'),
	('Grapes Of Wrath','Penguin Books'),
	('Gardening in Oregon','Outdoor Books, Inc.'),
	('Watership Down','Avon Books'),
	('9th Girl','Random House'),
	('How to Brew','BrewPress'),
	('A Tale Of Two Cities','Random House'),
	('The Wine Bible','Workman'),
	('Conversational French','UVM Press'),
	('Bread is Gold','Phaidon'),
	('Run Away','Penguin Books'),
	('Faithful','Boston Books'),
	('The Great Gatsby','Random House'),
	('Mushroom Foraging','Outdoor Books, Inc.')
	;
SELECT * FROM books;

INSERT INTO bookCopies--2 of each, 10 books each branch, 2 by stephen king in central branch
	(branchID,bookID,numberOfCopies)
	VALUES
	(1,1000,2),
	(1,1001,2),
	(1,1002,2),
	(1,1003,2),
	(1,1004,2),
	(1,1005,2),
	(1,1006,2),
	(1,1007,2),
	(1,1008,2),
	(1,1009,2),
	(1,1010,2),
	(1,1011,2),
	(1,1012,3),
	(1,1013,2),
	(1,1014,3),
	(1,1015,2),
	(1,1016,4),
	(1,1017,2),
	(1,1018,2),
	(1,1019,2),
	(1,1020,3),
	(2,1000,2),
	(2,1001,4),
	(2,1002,2),
	(2,1003,2),
	(2,1004,2),
	(2,1005,2),
	(2,1010,2),
	(2,1011,2),
	(2,1012,3),
	(2,1013,3),
	(2,1014,3),
	(2,1015,2),
	(2,1016,4),
	(2,1017,2),
	(2,1018,2),
	(2,1019,2),
	(2,1020,3),
	(3,1000,3),
	(3,1001,2),
	(3,1002,5),
	(3,1003,2),
	(3,1004,2),
	(3,1005,2),
	(3,1007,2),
	(3,1008,2),
	(3,1009,2),
	(3,1010,2),
	(3,1011,2),
	(3,1012,3),
	(3,1013,2),
	(3,1014,3),
	(3,1019,2),
	(3,1020,2),
	(4,1000,2),
	(4,1001,2),
	(4,1002,2),
	(4,1003,2),
	(4,1004,2),
	(4,1005,2),
	(4,1006,2),
	(4,1007,2),
	(4,1008,2),
	(4,1009,2),
	(4,1010,2),
	(4,1011,2),
	(4,1012,2),
	(4,1013,2),
	(4,1014,2),
	(4,1015,2),
	(4,1016,2)
	;
SELECT * FROM bookCopies;

INSERT INTO bookLoans--at least 50
	(branchID,bookID,cardNumber,dateOut,dateDue)
	VALUES
	(1,1000,900001,'2019-06-25','2019-08-25'),
	(1,1001,900001,'2019-05-06','2019-07-05'),
	(1,1002,900001,'2019-06-25','2019-08-25'),
	(1,1004,900001,'2019-05-06','2019-07-05'),
	(1,1005,900001,'2019-06-25','2019-08-25'),
	(1,1006,900000,'2019-04-30','2019-06-30'),
	(1,1007,900000,'2019-04-30','2019-06-30'),
	(1,1008,900001,'2019-06-25','2019-08-25'),
	(1,1009,900000,'2019-04-26','2019-06-26'),
	(1,1010,900000,'2019-04-26','2019-06-26'),
	(1,1015,900001,'2019-06-25','2019-08-25'),
	(1,1016,900000,'2019-04-30','2019-06-30'),
	(1,1017,900000,'2019-04-30','2019-06-30'),
	(1,1018,900001,'2019-06-25','2019-08-25'),
	(1,1019,900000,'2019-04-30','2019-06-30'),
	(1,1020,900000,'2019-04-30','2019-06-30'),
	(2,1000,900003,'2019-05-15','2019-07-15'),
	(2,1001,900003,'2019-05-15','2019-07-15'),
	(2,1001,900004,'2019-06-02','2019-08-02'),
	(2,1003,900003,'2019-05-15','2019-07-15'),
	(2,1004,900004,'2019-06-02','2019-08-02'),
	(2,1005,900003,'2019-05-15','2019-07-15'),
	(2,1010,900003,'2019-05-15','2019-07-15'),
	(2,1011,900003,'2019-05-15','2019-07-15'),
	(2,1012,900003,'2019-05-15','2019-07-15'),
	(2,1015,900003,'2019-05-15','2019-07-15'),
	(2,1016,900003,'2019-05-15','2019-07-15'),
	(2,1017,900004,'2019-06-02','2019-08-02'),
	(2,1018,900003,'2019-05-15','2019-07-15'),
	(2,1019,900004,'2019-06-02','2019-08-02'),
	(2,1020,900004,'2019-06-02','2019-08-02'),
	(3,1000,900006,'2019-05-18','2019-07-18'),
	(3,1001,900006,'2019-05-18','2019-07-18'),
	(3,1002,900006,'2019-05-18','2019-07-18'),
	(3,1003,900006,'2019-05-18','2019-07-18'),
	(3,1004,900006,'2019-05-18','2019-07-18'),
	(3,1005,900006,'2019-05-18','2019-07-18'),
	(3,1007,900006,'2019-05-18','2019-07-18'),
	(3,1008,900006,'2019-05-18','2019-07-18'),
	(3,1009,900006,'2019-05-18','2019-07-18'),
	(3,1010,900006,'2019-05-18','2019-07-18'),
	(3,1011,900006,'2019-05-18','2019-07-18'),
	(3,1012,900006,'2019-05-18','2019-07-18'),
	(3,1013,900006,'2019-05-18','2019-07-18'),
	(3,1014,900006,'2019-05-18','2019-07-18'),
	(3,1019,900006,'2019-05-18','2019-07-18'),
	(3,1020,900006,'2019-05-18','2019-07-18'),
	(4,1000,900007,'2019-06-12','2019-08-12'),
	(4,1001,900007,'2019-06-12','2019-08-12'),
	(4,1002,900007,'2019-06-12','2019-08-12'),
	(4,1003,900007,'2019-06-12','2019-08-12'),
	(4,1004,900006,'2019-06-12','2019-08-12'),
	(4,1005,900006,'2019-03-22','2019-05-22'),
	(4,1006,900007,'2019-06-12','2019-08-12'),
	(4,1007,900006,'2019-03-22','2019-05-22'),
	(4,1008,900006,'2019-03-22','2019-05-22'),
	(4,1009,900007,'2019-06-12','2019-08-12'),
	(4,1010,900007,'2019-06-12','2019-08-12'),
	(4,1011,900007,'2019-06-12','2019-08-12'),
	(4,1013,900007,'2019-06-12','2019-08-12'),
	(4,1014,900006,'2019-03-22','2019-05-22'),
	(4,1015,900006,'2019-03-22','2019-05-22'),
	(4,1015,900007,'2019-06-12','2019-08-12')
	;
SELECT * FROM bookLoans;

INSERT INTO bookAuthors--at least 10, 2 by stephen king in central branch
	(bookID,authorFname,authorLname)
	VALUES
	(1000,'John','Writewell'),
	(1001,'Stephen','King'),
	(1002,'Stephen','King'),
	(1003,'Stephen','King'),
	(1004,'J.R.R.','Tolkein'),
	(1005,'James','Codeswell'),
	(1006,'Susan','Hikeswell'),
	(1007,'Dr. Alice','Buff'),
	(1008,'John','Steinbeck'),
	(1009,'Bob','Flowers'),
	(1010,'Richard','Adams'),
	(1011,'Tammi','Hoag'),
	(1012,'John','Palmer'),
	(1013,'Charles','Dickens'),
	(1014,'Karen','Macneil'),
	(1015,'Francois','Pierre'),
	(1016,'Massimo','Bottura'),
	(1017,'Harlan','Coben'),
	(1018,'Stewart','Nan'),
	(1019,'F. Scott','Fitzgerald'),
	(1020,'May','Cellium')
	;
SELECT * FROM bookAuthors;

GO
