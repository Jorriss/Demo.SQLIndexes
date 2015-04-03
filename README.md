# Demo.SQLIndexes
This project are the demos to the We Don’t Need Roads: A Developer’s Look Into SQL Server Indexes presentation. For more information on the presentation go to http://www.jorriss.net/blog/sqlindexes.

Please note: These demos are to show some how indexes work in SQL Server not best practices in console applications. I'm just sayin'.

## What's In Here

* SQLServerIndexesDemos.sql - The main demo script. This contains all of the index fun. This script uses the StackOverflow database.
* AdventureWorksEF - This uses AdventureWorks2012 database. Demonstrates how Entity Framework could kill indexes.

## Databases
* AdventureWorks2012 - You can grab it at https://msftdbprodsamples.codeplex.com/releases/view/55330. Once you've installed it you probably should run the `AdventureWorksIndex.sql` script to create the demo index.
* StackOverflow - You have to download the data dump at https://archive.org/details/stackexchange. You can write a tool to import the data yourself or you could use the SODDI tool (StackOverflow Data Dump Importer) Jeremiah Peschka has been maintaining a version of SODDI at https://github.com/peschkaj/soddi.
