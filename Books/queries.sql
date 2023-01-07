/* =================== STORED PROCEDURE QUERY QUESTIONS =================================== */

--комментарии:
	-- FROM - используется для указания списка таблиц и любых объединений, необходимых для SQL предложения
	-- INNER JOIN - с его помощью происходит объединение записей из двух таблиц по связующему полю, если оно содержит одинаковые значения в обеих таблицах.
	-- EXEC - команда для запуска хранимых процедур и SQL инструкций в виде текстовых строк
	-- SET - изменяют текущий сеанс, управляя специфическими данными
	-- COUNT - эта функция возвращает количество элементов, найденных в группе
	-- GROUP BY - функция позволяет группировать результаты при выборке из базы данных (SELECT * FROM имя_таблицы WHERE условие GROUP BY поле_для_группировки)
	-- HAVING - предложение, которое применяется после группировки для определения аналогичного предиката*, фильтрующего группы по значениям агрегатных функций**. Это предложение необходимо для проверки значений, которые получены с помощью агрегатной функции из групп таких строк
	-- *Предикаты представляют собой выражения, принимающие истинностное значение.
	-- **Агрегатная функция выполняет вычисление на наборе значений и возвращает одиночное значение

	/* #1- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */

	CREATE PROC dbo.bookCopiesAtAllSharpstown /*  <-- создание хранимой области */
(@bookTitle /* <-- ссылка на столбец таблицы*/ varchar(70) = 'The Lost Tribe' /*  <-- запрос для поиска */, @branchName varchar(70) = 'Sharpstown')
AS /*  <-- процесс присвоения новых имен для новой таблицы */
SELECT copies.book_copies_BranchID  AS [Branch ID] /*  <-- новое название столбца*/, branch.library_branch_BranchName AS [Branch Name],
	   copies.book_copies_No_Of_Copies AS [Number of Copies],
	   book.book_Title AS [Book Title]
	   FROM tbl_book_copies AS copies
			INNER JOIN tbl_book AS book ON /* <-- ON необходим для указанимя на какой именно стобец необходимо сопоставить таблицы */copies.book_copies_BookID = book.book_BookID
			INNER JOIN tbl_library_branch AS branch ON book_copies_BranchID = branch.library_branch_BranchID
	   WHERE book.book_Title = @bookTitle AND branch.library_branch_BranchName = @branchName
GO
EXEC dbo.bookCopiesAtAllSharpstown 

/* #2- How many copies of the book titled "The Lost Tribe" are owned by each library branch? */


CREATE PROC dbo.bookCopiesAtAllBranches 
(@bookTitle varchar(70) = 'The Lost Tribe')
AS
SELECT copies.book_copies_BranchID AS [Branch ID], branch.library_branch_BranchName AS [Branch Name],
	   copies.book_copies_No_Of_Copies AS [Number of Copies],
	   book.book_Title AS [Book Title]
	   FROM tbl_book_copies AS copies
			INNER JOIN tbl_book AS book ON copies.book_copies_BookID = book.book_BookID
			INNER JOIN tbl_library_branch AS branch ON book_copies_BranchID = branch.library_branch_BranchID
	   WHERE book.book_Title = @bookTitle 
GO
EXEC dbo.bookCopiesAtAllBranches

/* #3- Retrieve the names of all borrowers who do not have any books checked out.
       Найдите имена всех заемщиков, у которых нет проверенных книг.*/
		
CREATE PROC dbo.NoLoans
AS
SELECT borrower_BorrowerName FROM tbl_borrower
	WHERE /* зачем 'NOT'??? */NOT EXISTS /* <-- выражение возвращает истину, когда по запросу не найдено ни одной строки, и ложь, когда найдена хотя бы одна строка.*/
		(SELECT * FROM tbl_book_loans			  /* <-- Условие дял EXISTS */
		WHERE book_loans_CardNo = borrower_CardNo)
GO
EXEC dbo.NoLoans

/* #4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.  
	   Для каждой книги, выданной взаймы в филиале "Шарпстаун" и чей срок сдачи сегодня, получите название книги, имя заемщика и адрес заемщика.*/
	    
CREATE PROC dbo.LoanersInfo 
(@DueDate date = NULL, @LibraryBranchName varchar(50) = 'Sharpstown')
AS
SET @DueDate = GETDATE() /* <--  GETDATE() возвращает текущую системную метку времени базы данных в виде значения datetime без смещения часового пояса базы данных*/
SELECT Branch.library_branch_BranchName AS [Branch Name],  Book.book_Title [Book Name], /* <-- почему тут нет 'AS'???*/
	   Borrower.borrower_BorrowerName AS [Borrower Name], Borrower.borrower_BorrowerAddress AS [Borrower Address],
	   Loans.book_loans_DateOut AS [Date Out], Loans.book_loans_DueDate [Due Date]
	   FROM tbl_book_loans AS Loans
			INNER JOIN tbl_book AS Book ON Loans.book_loans_BookID = Book.book_BookID
			INNER JOIN tbl_borrower AS Borrower ON Loans.book_loans_CardNo = Borrower.borrower_CardNo
			INNER JOIN tbl_library_branch AS Branch ON Loans.book_loans_BranchID = Branch.library_branch_BranchID
		WHERE Loans.book_loans_DueDate = @DueDate AND Branch.library_branch_BranchName = @LibraryBranchName
GO
EXEC dbo.LoanersInfo 

/* #5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
	   Для каждого филиала библиотеки получите название филиала и общее количество книг, выданных из этого филиала.*/

CREATE PROC dbo.TotalLoansPerBranch
AS
SELECT  Branch.library_branch_BranchName AS [Branch Name], COUNT (Loans.book_loans_BranchID) AS [Total Loans]
		FROM tbl_book_loans AS Loans
			INNER JOIN tbl_library_branch AS Branch ON Loans.book_loans_BranchID = Branch.library_branch_BranchID
			GROUP BY library_branch_BranchName
GO
EXEC dbo.TotalLoansPerBranch

/* #6- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out. 
	   Получите имена, адреса и количество выданных книг для всех заемщиков, у которых выдано более пяти книг.*/

CREATE PROC dbo.BooksLoanedOut
(@BooksCheckedOut INT = 5) /* <-- INT(n) не означает, что значения ограничены n-символьными значениями. Это означает только то, что MySQL попытается дополнить эти значения пробелами/нулями при их возврате.*/
AS
	SELECT Borrower.borrower_BorrowerName AS [Borrower Name], Borrower.borrower_BorrowerAddress AS [Borrower Address],
		   COUNT(Borrower.borrower_BorrowerName) AS [Books Checked Out]
		   FROM tbl_book_loans AS Loans
		   			INNER JOIN tbl_borrower AS Borrower ON Loans.book_loans_CardNo = Borrower.borrower_CardNo
					GROUP BY Borrower.borrower_BorrowerName, Borrower.borrower_BorrowerAddress
		   HAVING COUNT(Borrower.borrower_BorrowerName) >= @BooksCheckedOut
GO
EXEC dbo.BooksLoanedOut

/* #7- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
	   Для каждой книги, автором которой является «Стивен Кинг», получите название и количество копий, принадлежащих филиалу библиотеки с названием «Центральная»*/

CREATE PROC dbo.BookbyAuthorandBranch
	(@BranchName varchar(50) = 'Central', @AuthorName varchar(50) = 'Stephen King')
AS
	SELECT Branch.library_branch_BranchName AS [Branch Name], Book.book_Title AS [Title], Copies.book_copies_No_Of_Copies AS [Number of Copies]
		   FROM tbl_book_authors AS Authors
				INNER JOIN tbl_book AS Book ON Authors.book_authors_BookID = Book.book_BookID
				INNER JOIN tbl_book_copies AS Copies ON Authors.book_authors_BookID = Copies.book_copies_BookID
				INNER JOIN tbl_library_branch AS Branch ON Copies.book_copies_BranchID = Branch.library_branch_BranchID
			WHERE Branch.library_branch_BranchName = @BranchName AND Authors.book_authors_AuthorName = @AuthorName
GO	
EXEC dbo.BookbyAuthorandBranch

/* ==================================== STORED PROCEDURE QUERY QUESTIONS =================================== */
