rem this is what it looks like to IMPORT a CSV  file to a VM or keyboard local instance 
bcp AP.dbo.Ships_template in c:\Divergence\Oil\Ships_incremental.csv -c -T -S. -t, -q
rem this is what it looks like to IMPORT a CSV  file to Azure SQL
bcp AP.dbo.Ships_template in c:\Divergence\Oil\Ships_incremental.csv -c -S2022dsiwd.database.windows.net -Uadmin2022dsiwd -PDivergence!2022dsiwd -t, -q
rem this is what it looks like to EXPORT a CSV  file to a VM or keyboard local instance 
bcp AP.dbo.Ships_template out c:\Divergence\Oil\Ships_incremental.csv -c -T -S. -t, -q
rem this is what it looks like to EXPORT a CSV  file to Azure SQL
bcp AP.dbo.Ships_template out c:\Divergence\Oil\Ships_incremental.csv -c -S2022dsiwd.database.windows.net -Uadmin2022dsiwd -PDivergence!2022dsiwd -t, -q
bcp AutoShipments.dbo.Calls_Cap1 out c:\Divergence\Auto\Calls.csv -c -T -S. -t, -q