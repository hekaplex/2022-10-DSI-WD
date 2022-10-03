##############################################################################################
## 1. Create reference to Analysis Services DLL in SSMS path
##############################################################################################
 
 
    # Approach 1
    # Use the DLL in the GAC if you already have SSM, or other tool installed
 
    <#
    try {
        $Result = [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.AnalysisServices.Tabular')
        }
    catch  { 
        $_.Exception.LoaderExceptions 
        }
    #>
 
    # Approach 2
    # Create a reference directly to a file called Microsoft.AnalysisServices.Tabular.Dll already installed by SSMS
 
    <#
 
    #$assemblypath = "c:\program files (x86)\microsoft sql server management studio 18\common7\ide\microsoft.analysisservices.Tabular.dll"
    try {add-type -path $assemblypath}
    catch  { $_.exception.loaderexceptions }
 
    #>
 
    # Approach 3
    # Download and extract the DLL From Nuget to somewhere local on your machine
 
    $assemblypath = "c:\temp\microsoft.analysisservices.Tabular.dll"
    try {add-type -path $assemblypath}
    catch  { $_.exception.loaderexceptions }
 
 
##############################################################################################
## 2. Get Power BI Desktop Port Number
##############################################################################################
 
 
    $ProcessName = 'msmdsrv'
    try {
        $Process = Get-Process -Name $ProcessName -ea Stop -ErrorVariable 'ps_error'
    } catch {
        throw "Warning: Could not find any process named: '$ProcessName'.`nMake sure Power BI is open."
    }
    $Result = Get-NetTCPConnection -OwningProcess $Process.Id
    $Port = $Result | Select-Object -ExpandProperty LocalPort | Sort-Object -Unique
    $ConnectionStringPBIDesktop = "localhost:$Port"
 
 
##############################################################################################
## 3. Create AS Server object and Connect to Power BI 
##############################################################################################
 
    $Server = [Microsoft.AnalysisServices.Tabular.Server]::new()
    $Server.Connect($ConnectionStringPBIDesktop)
    $Model = $Server.Databases[0].Model
 
    <#
    foreach($table in $Model.Tables)
    {
        $table.Name
    }
    #>
 
##############################################################################################
## 4. Remove Existing Calculation Group
##############################################################################################
 
 
    $result = $Model.Tables.Remove($Model.Tables["Time Calc"])
 
 
##############################################################################################
## 5. Create Calculation Group
##############################################################################################
 
 
    $CalculationGroup = [Microsoft.AnalysisServices.Tabular.CalculationGroup]::new()
    $CalculationGroup.Description="None"
    $CalculationGroup.Precedence=10
 
 
##############################################################################################
## 6. Create Calculation Item
##############################################################################################
 
 
    $CalculationItem = [Microsoft.AnalysisServices.Tabular.CalculationItem]::new()
    $CalculationItem.Description = "YTD"
    $CalculationItem.Name = "YTD"
    $CalculationItem.Expression = "CALCULATE(SELECTEDMEASURE(),DATESYTD(DimDate[FullDateAlternateKey]))"
    $CalculationItem.Ordinal = 0
 
    $CalculationGroup.CalculationItems.Add($CalculationItem)
 
 
##############################################################################################
## 7. Create Calculation Item 2
##############################################################################################
 
 
    $CalculationItem = [Microsoft.AnalysisServices.Tabular.CalculationItem]::new()
    $CalculationItem.Description = "MTD"
    $CalculationItem.Name = "MTD"
    $CalculationItem.Expression = "CALCULATE(SELECTEDMEASURE(),DATESMTD(DimDate[FullDateAlternateKey]))"
    $CalculationItem.Ordinal = 0
 
    $CalculationGroup.CalculationItems.Add($CalculationItem)
 
 
##############################################################################################
## 8. Create Table
##############################################################################################
 
 
    $Table = [Microsoft.AnalysisServices.Tabular.Table]::new()
    $Table.Name = "Time Calc"
    $Table.CalculationGroup = $CalculationGroup
 
 
##############################################################################################
## 9. Create Table Column
##############################################################################################
 
 
    $TableColumn = [Microsoft.AnalysisServices.Tabular.DataColumn]::new()
    $TableColumn.Name = "Time Calculations"
    $TableColumn.DataType = "String"
 
    $result = $Table.Columns.Add($TableColumn)
 
 
##############################################################################################
## 10. Create Partition
##############################################################################################
 
 
    $Partition = [Microsoft.AnalysisServices.Tabular.Partition]::new()
    $Partition.Name = "Partition For Time Calc"
    $Partition.Source =[Microsoft.AnalysisServices.Tabular.CalculationGroupSource]::new()
 
    $result = $Table.Partitions.Add($Partition)
 
 
##############################################################################################
## 11. Add Table to Model
##############################################################################################
 
 
    $result = $Model.Tables.Add($Table)
    
 
##############################################################################################
## 12. Commit all changes to the model
##############################################################################################
 
    $result = $Model.DiscourageImplicitMeasures=[bool] 1
    $result = $Model.SaveChanges()
 
 
##############################################################################################
## Woot!