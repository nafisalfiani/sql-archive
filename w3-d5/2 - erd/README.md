# erd

Based on the requirements, create an ERD with the following entities and relationships:

Book:

- ISBN (Primary Key)
- Title
- Author
- Publisher
- Year_of_Publication

Member:

- Member_ID (Primary Key)
- First_Name
- Last_Name
- Date_of_Birth
- Address

Lending_Transaction:

- Transaction_ID (Primary Key)
- Member_ID (Foreign Key)
- ISBN (Foreign Key)
- Date_of_Lending
- Date_of_Return
- Condition_At_Return

Relationships:

- A member can borrow multiple books (but not more than 5 at a time).
- A book can be part of multiple lending transactions, but can be lent to one member at a time.

SUBMISSIONS INSTRUCTIONS Of Step 2: Creating an ERD

- Use a tool like Lucidchart, dbdiagram.io, or draw it on paper and take a photo.
- Save the ERD diagram as ERD.png (or another appropriate format).
- Push ERD.png to your GitHub repository.
