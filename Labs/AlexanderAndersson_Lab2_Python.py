from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL
from urllib.parse import unquote
from collections import defaultdict
import pandas as pd
from IPython.display import display
# Prompt for password so we don't store it in the script
##password = getpass("Enter database password: ")

# Create a SQLAlchemy engine
# Replace 'your_server', 'your_database', 'your_username' with your actual Server, Database, and Username
server_name   = "localhost" 
database_name = "Book_store" 
username = "Book_Search_Login"
password = "book"

connection_string = f"Driver=ODBC Driver 17 for SQL Server;Server={server_name};Database={database_name};UID={username};PWD={password};"
url_string        = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})


print('Connecting to database using URL string:')
unquoted_url = unquote(str(url_string))
print(unquoted_url, '\n')


try:    
    engine = create_engine(url_string)
    with engine.connect() as connection: # with is used to automatically close the connection at the end of the block to avoid memory leaks
        print(f'Successfully connected to {database_name}!')
except Exception as e:
    print('Error while connecting to database:\n')
    print(e)


def search_books(search_term):
    # Use the text() function to help protect against SQL injection
    query = text("""EXEC Book_Search :search_term""")

    # Get a connection from the Engine
    with engine.connect() as connection:
        result = connection.execute(query, {'search_term': search_term}).fetchall()
    
    # Display results in a DataFrame
    df = pd.DataFrame(result, columns=['Title', 'Store', 'Available'])
    if len(df) == 0:
        print("No books found.")
    else:
        display(df)
# Prompt the user to enter a search query
search_query = input("Enter a book title to search for: ")

# Search for the query in the database
search_books(search_query)