USE db_library;

--1.) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
GO
CREATE PROCEDURE dbo.uspGetCopyBranch @title nvarchar(30), @branchName nvarchar(30)
AS
	SELECT numberOfCopies
	FROM bookCopies
	INNER JOIN books ON books.bookID = bookCopies.bookID
	INNER JOIN libraryBranch ON libraryBranch.branchID = bookCopies.branchID
	WHERE title = @title
	AND branchName = @branchName
GO
EXEC dbo.uspGetCopyBranch
@title='The Lost Tribe',@branchName='Sharpstown'

--2.) How many copies of the book titled "The Lost Tribe" are owned by each library branch?
GO
CREATE PROCEDURE dbo.uspGetCopy @title nvarchar(30)
AS
	SELECT numberOfCopies, branchName
	FROM bookCopies
	INNER JOIN books ON books.bookID = bookCopies.bookID
	INNER JOIN libraryBranch ON libraryBranch.branchID = bookCopies.branchID
	WHERE title = @title
GO
EXEC dbo.uspGetCopy
@title='The Lost Tribe'

--3.) Retrieve the names of all borrowers who do not have any books checked out.
GO
CREATE PROCEDURE dbo.uspNoneOut
AS
	SELECT barrowerName
	FROM barrower
	LEFT JOIN bookLoans ON barrower.cardNumber = bookLoans.cardNumber
	WHERE bookLoans.cardNumber IS NULL;
GO
EXEC dbo.uspNoneOut

--4.) For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.
GO
CREATE PROCEDURE dbo.uspDueTodaySharpstown
AS
	FROM bookLoans
	SELECT books.title,barrowerName,barrowerAddress
	INNER JOIN libraryBranch ON libraryBranch.branchID = bookLoans.branchID
	INNER JOIN books ON books.bookID = bookLoans.bookID
	INNER JOIN barrower ON barrower.cardNumber = bookLoans.cardNumber
	WHERE branchName = 'Sharpstown' AND dateDue = CONVERT(varchar, getdate(), 23)
GO
EXEC dbo.uspDueTodaySharpstown

--5.) For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
GO
CREATE PROCEDURE dbo.uspBooksOnLoan
AS
	SELECT branchName, COUNT(*) as 'Number of Books on Loan'
	FROM bookLoans
	INNER JOIN libraryBranch ON libraryBranch.branchID = bookLoans.branchID
	GROUP BY branchName
GO
EXEC dbo.uspBooksOnLoan

--6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.
GO
CREATE PROCEDURE dbo.uspFivePlusOut
AS
	SELECT barrowerName, barrowerAddress, COUNT(*) AS 'Number of Books on Loan'
	FROM bookLoans
	INNER JOIN barrower ON barrower.cardNumber = bookLoans.cardNumber
	GROUP BY barrowerName, barrowerAddress
	HAVING COUNT(*)>5
GO
EXEC dbo.uspFivePlusOut
	
--7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned 
--by the library branch whose name is "Central".
GO
CREATE PROCEDURE dbo.uspKingAtCentral
AS
	SELECT title, numberOfCopies
	FROM bookCopies
	INNER JOIN libraryBranch ON libraryBranch.branchID = bookCopies.branchID
	INNER JOIN books ON books.bookID = bookCopies.bookID
	INNER JOIN bookAuthors ON bookAuthors.bookID = bookCopies.bookID
	WHERE authorLname = 'King' AND branchName = 'Central'
GO
EXEC dbo.uspKingAtCentral