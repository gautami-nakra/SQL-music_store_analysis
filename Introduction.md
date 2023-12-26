# SQL-music_store_analysis

# INTRODUCTION
In this innovative project, we harness the power of **MySQL** and **Power BI** to conduct a comprehensive analysis of a music record store dataset, aiming to uncover valuable insights and address key business questions. Our exploration dives deep into an intricately designed database schema, consisting of 11 tables that intricately capture various facets of the music industry.

The dataset includes the following tables:

•	**employee** table stores employees data such as employee id, last name, first name, etc. 


•	**customer** table stores customer data such as the name, address, phone, email, etc.


•	**invoice** & **invoice_item** tables store invoice-related data. 


  The invoices table stores invoice header data such as invoice id, billing address, postal code, total, etc.
The invoice_items table stores the invoice line items data such as invoice line id, track id, unit price, quantity, etc.


•	**artist table** stores artists data. It is a simple table that contains only the artist id and name.


•	**album** table stores data about a list of tracks. Each album belongs to one artist and artist id. However, one artist may have multiple albums.


•	**media_type** table stores media types such as MPEG audio and AAC audio files.


•	**genre** table stores music types such as rock, jazz, metal, etc.


•	**track** table stores the data of songs. Each track belongs to one album.


•	**playlist** & **playlist_track** tables: playlists table store data about playlists. Each playlist contains a list of tracks. Each track may belong to multiple playlists. The relationship between the playlists table and tracks table is many-to-many. The playlist_track table is used to reflect this relationship.


Each table is linked to some other table and the relationship within the tables can be seen in the following diagram:
 
The lines depict the link between the tables.
![image](https://github.com/gautami-nakra/SQL-music_store_analysis/assets/148481510/6a7ca489-b3f8-4a26-9852-ff3eb69b8000)


