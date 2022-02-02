Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"        
Title="SAV" Height="359" Width="544">
    <Grid Background="#FF1F175B">
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <Button Content="CONSULTER LES DEMANDES" Margin="10,120,10,120" Grid.Column="1" Height="80" Name="BConsult"/>
        <Button Content="NOUVELLE DEMANDE" Margin="10,10,10,254" Grid.Column="1" Height="80" Name="Bdem"/>
        <TextBlock HorizontalAlignment="Center" Margin="0,10,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="252" Height="45" Background="#FF7F7DA5" FontFamily="Arial Black"><Run Text="GESTION "/><Run Language="fr-fr" Text="DES DEMANDES DE SUPPORT"/><Run Text=" ET RETOUR DES PIECES TERRA"/></TextBlock>
        <Button Content="FORMULAIRE SAV INFORSUD&#xD;&#xA;" Margin="10,253,10,10" Grid.Column="1" Height="80" Name="BForm"/>
        <Image Margin="86,229,86,0" Name="Terralogo" Height="100" VerticalAlignment="Top" Source="c:\temp\logo-terra-300x226.png" />
        <Image Margin="5,90,5,153" Name="Difflogo" Source="c:\temp\Logo-INFORSUD-Technologies-Blanc-300.png"/>

    </Grid>
</Window>
"@

#-------------------------------------------------------------#
#----SCRIPT PRINCIPAL FORMU-----------------------------------#
#-------------------------------------------------------------#

function Fdem(){
Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="MainWindow" Height="450" Width="400">
    <Grid>
        <Label Content="DEMANDE N°" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <Label Content="Materiel " HorizontalAlignment="Left" Margin="10,118,0,0" VerticalAlignment="Top" ClipToBounds="True" RenderTransformOrigin="3.126,0.405" Width="75" Height="26"/>
        <Label Content="Num Serie" HorizontalAlignment="Left" Margin="10,200,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <TextBox HorizontalAlignment="Left" Margin="196,226,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="120" ClipToBounds="True" Name="TSerial"/>
        <Label Content="Client" HorizontalAlignment="Left" Margin="196,200,0,0" VerticalAlignment="Top" ClipToBounds="True" Width="65"/>
        <TextBox HorizontalAlignment="Left" Margin="10,226,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="120" ClipToBounds="True" Name="TClient"/>
        <TextBlock HorizontalAlignment="Left" Margin="98,15,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="50" ClipToBounds="True" Name="TNum"><Run Language="fr-fr" Text="0"/></TextBlock>
        <Label Content="Descriptif de la panne" HorizontalAlignment="Left" Margin="10,244,0,0" VerticalAlignment="Top" BorderThickness="0,0,0,3"/>
        <TextBox HorizontalAlignment="Center" Margin="0,270,0,0" TextWrapping="Wrap" Width="373" Height="83" VerticalAlignment="Top" ClipToBounds="True" Name="TCom"/>
        <Button Content="Creer la demande" HorizontalAlignment="Left" Margin="17,362,0,0" Width="125" Height="20" VerticalAlignment="Top" ClipToBounds="True" Name="BOk"/>
        <Button Content="Annuler la demande" HorizontalAlignment="Left" Margin="250,363,0,0" Width="125" Height="20" VerticalAlignment="Top" ClipToBounds="True" Name="BCancel"/>
        <ListBox Name="Listmat" Margin="10,144,218,213"/>
        <Label Content="Demandeur" HorizontalAlignment="Left" Margin="10,41,0,0" VerticalAlignment="Top" ClipToBounds="True" Width="75"/>
        <ListBox Name="Listdem" Margin="10,67,218,290"/>
        <Image HorizontalAlignment="Left" Height="127" Margin="251,37,0,0" VerticalAlignment="Top" Width="131" Source="/img_25693.png"/>
    </Grid>
</Window>
"@

#-------------------------------------------------------------#
#----SCRIPT DEMANDE-------------------------------------------#
#-------------------------------------------------------------#

function FOk(){

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"  Title="Window1" Height="110" Width="242">
    <Grid>
        <Button Content="CONFIRMER" HorizontalAlignment="Left" Margin="10,0,0,0" VerticalAlignment="Center" Height="33" Width="85" Name="BConf"/>
        <Button Content="ANNULER" HorizontalAlignment="Left" Margin="147,0,0,0" VerticalAlignment="Center" Height="33" Width="85" Name="BAnnul"/>

    </Grid>
</Window>
"@

function FConf(){
$Etat="OUVERT"
$Materiel=$Listmat.SelectedItem
$Serial=$TSerial.Text
$Client=$TClient.Text
[string]$Dem=$Listdem.SelectedItem
[string]$Client=$Client.Replace("'"," ")
[string]$Client=$Client.Replace("é","e")
$Com=$TCom.Text
[string]$Com=$Com.Replace("'"," ")
[string]$Com=$Com.Replace("é","e")
$Date= Get-Date -Format yyyy/MM/dd
#REQUETE SQL
$sql = New-Object MySql.Data.MySqlClient.MySqlCommand
$sql.Connection = $Connection
##SQL COMMAND
$sql.CommandText = "INSERT INTO `DEMANDES` (`Num`, `MATERIEL`, `CLIENT`, `DATE`, `SERIAL`, `COM`, `ETAT`, `DEMANDEUR`) VALUES (NULL, '$Materiel', '$Client', '$Date', '$Serial', '$Com', '$Etat', '$Dem')"
$sql.ExecuteNonQuery()
Write-Host "La demande à été envoyée"
[void]$Window.Close()
}

Function FAnnul(){
[void]$Window.Close()}



$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }
$BConf.Add_Click({FConf $this $_})
$BAnnul.Add_Click({FAnnul $this $_})
[void]$Window.ShowDialog()

}

function FCancel(){



}


function FCancelold(){
[void]$Window.close()}
#endregion

#----------------------------------------------------------------#
#----Script DEMANDE EXEC-----------------------------------------#
#----------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


$BCancel.IsEnabled = $true

$BOk.Add_Click({FOk $this $_})
$BCancel.Add_Click({FCancel $this $_})


#Chargement du fichier config.ini
[void][system.reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.27\Assemblies\net5.0\MySql.Data.dll")
$Config = Get-Content 'config.ini' | ConvertFrom-StringData
$Mysqlhost= $Config.Server
$Mysqluser= $Config.User
$Mysqlpass= $Config.Password
$Mysqldatabase= $Config.DB
## SQL CONNEXION
$Connection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString="server=$Mysqlhost;uid=$Mysqluser;pwd=$Mysqlpass;database=$Mysqldatabase"}
$Connection.Open()
$sql = New-Object MySql.Data.MySqlClient.MySqlCommand
$sql.Connection = $Connection
$sql.CommandText = "SELECT * FROM DEMANDES WHERE Num = (SELECT max(Num) FROM DEMANDES)"
$myreader = $sql.ExecuteReader()
while($myreader.Read()){ $myreader.GetString(0) }
$Num=$myreader.GetString(0)
$Numint=[int]$Num
$Numint++
$TNum.Text=$Numint
$myreader.Close()

$Listdem.Items.Add("CELINE") | Out-Null
$Listdem.Items.Add("DAVY") | Out-Null
$Listdem.Items.Add("ERIC") | Out-Null
$Listdem.Items.Add("JULIEN") | Out-Null
$Listmat.Items.Add("CARTE MERE") | Out-Null
$Listmat.Items.Add("CLAVIER") | Out-Null
$Listmat.Items.Add("DISQUE DUR") | Out-Null
$Listmat.Items.Add("ECRAN") | Out-Null
$Listmat.Items.Add("ORDINATEUR") | Out-Null



[void]$Window.ShowDialog()

}

function FConsult(){

#
# Script.ps1
#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"        
Title="MainWindow" Height="1000" Width="1306">
   <Grid Background="#FF4987CC">
        <Button Content="CHERCHER" HorizontalAlignment="Left" Margin="600,107,0,0" Width="136" Height="33" VerticalAlignment="Top" Name="Bcherch"/>
        <Button Content="ANNULER" HorizontalAlignment="Left" Margin="741,107,0,0" Width="136" Height="33" VerticalAlignment="Top" Name="Bann"/>
        <Label Content="CRITERE DE RECHERCHE" HorizontalAlignment="Left" Margin="10,54,0,0" VerticalAlignment="Top" Height="43" Width="204"/>
        <ComboBox HorizontalAlignment="Left" Margin="10,102,0,0" VerticalAlignment="Top" Width="204" Height="43" Name="Cbox1">
            <ComboBoxItem Name="Num" Content="Numéro"/>
            <ComboBoxItem Name="DEMANDEUR" Content="Demandeur"/>
            <ComboBoxItem Name="CLIENT" Content="Client"/>
            <ComboBoxItem Name="ETAT" Content="Etat"/>
        </ComboBox>
        <TextBox HorizontalAlignment="Left" Margin="240,102,0,0" TextWrapping="Wrap" Text="Saisir un terme de recherche . . ." VerticalAlignment="Top" Width="319" Height="43" Name="Tbox1"/>
        <Grid Margin="0,210,0,0">
    <DataGrid Name="Datagrid" AutoGenerateColumns="True" >
        <DataGrid.Columns>
            <DataGridTextColumn Header="Num" Binding="{Binding Num}" Width="180" />
            <DataGridTextColumn Header="Materiel" Binding="{Binding Materiel}" Width="233"/>
            <DataGridTextColumn Header="Client" Binding="{Binding Client}" Width="233"/>
            <DataGridTextColumn Header="Date" Binding="{Binding DATE}" Width="180" />
            <DataGridTextColumn Header="N°Serie" Binding="{Binding SERIAL}" Width="233"/>
            <DataGridTextColumn Header="Commentaire" Binding="{Binding COM}" Width="233"/>
            <DataGridTextColumn Header="Etat" Binding="{Binding ETAT}" Width="180" />
            <DataGridTextColumn Header="Demandeur" Binding="{Binding DEMANDEUR}" Width="233"/>
        </DataGrid.Columns>
    </DataGrid>
        </Grid>
        <Button Content="AFFICHER TOUTE LA BASE DE DONNES" Margin="0,84,44,0" UseLayoutRounding="False" FontStyle="Normal" Grid.IsSharedSizeScope="True"  VerticalContentAlignment="Center" HorizontalContentAlignment="Center" Height="80" VerticalAlignment="Top" HorizontalAlignment="Right" Width="238" Name="Ball"/>

    </Grid>
</Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#


function FBConf (){
$Datagrid.Items.Clear()
[void][system.reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.27\Assemblies\net5.0\MySql.Data.dll")
$Config = Get-Content 'config.ini' | ConvertFrom-StringData
$Mysqlhost= $Config.Server
$Mysqluser= $Config.User
$Mysqlpass= $Config.Password
$Mysqldatabase= $Config.DB
$Connection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString="server=$Mysqlhost;uid=$Mysqluser;pwd=$Mysqlpass;database=$Mysqldatabase"}
$sql = New-Object MySql.Data.MySqlClient.MySqlCommand
$sql.Connection = $Connection
$table=$Cbox1.SelectedValue.Name
$req=$Tbox1.Text
$sql.CommandText = "SELECT * FROM DEMANDES WHERE $table = '$req'"
[array]$serverArray
$arrayCount = 0
    $Connection.Open()
    $myreader = $sql.ExecuteReader()
    while($myreader.Read())
    {
        $serverArray += ,
        (

$Datagrid.AddChild([pscustomobject]@{Num=$myreader.GetValue(0);Materiel=$myreader.GetValue(1);Client=$myreader.GetValue(2);DATE=$myreader.GetValue(3);SERIAL=$myreader.GetValue(4);COM=$myreader.GetValue(5);ETAT=$myreader.GetValue(6);DEMANDEUR=$myreader.GetValue(7)})
        )
        $arrayCount++
    }
$myreader.Close()
$Connection.Close()
}



function FBann (){
Write-Host "Bann"
[void]$Window.close()
}

function FBall(){
$Datagrid.Items.Clear()
[void][system.reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.27\Assemblies\net5.0\MySql.Data.dll")
$Config = Get-Content 'config.ini' | ConvertFrom-StringData
$Mysqlhost= $Config.Server
$Mysqluser= $Config.User
$Mysqlpass= $Config.Password
$Mysqldatabase= $Config.DB
$Connection = [MySql.Data.MySqlClient.MySqlConnection]@{ConnectionString="server=$Mysqlhost;uid=$Mysqluser;pwd=$Mysqlpass;database=$Mysqldatabase"}
$sql = New-Object MySql.Data.MySqlClient.MySqlCommand
$sql.Connection = $Connection
$sql.CommandText = "SELECT * FROM DEMANDES"
[array]$serverArray
$arrayCount = 0
    $Connection.Open()
    $myreader = $sql.ExecuteReader()
    while($myreader.Read())
    {
        $serverArray += ,
        (

$Datagrid.AddChild([pscustomobject]@{Num=$myreader.GetValue(0);Materiel=$myreader.GetValue(1);Client=$myreader.GetValue(2);DATE=$myreader.GetValue(3);SERIAL=$myreader.GetValue(4);COM=$myreader.GetValue(5);ETAT=$myreader.GetValue(6);DEMANDEUR=$myreader.GetValue(7)})
        )
        $arrayCount++
    }
$myreader.Close()
$Connection.Close()

}

#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml


$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }
$Bcherch.Add_Click({FBConf $this $_})
$Bann.Add_Click({FBann $this $_})
$Ball.Add_Click({FBall $this $_})


[void]$Window.ShowDialog()
   

}

function FForm(){
Invoke-Item "formulaire.xls"
}


#endregion

#-------------------------------------------------------------#
#----SCRIPT PRINCIPAL-----------------------------------------#
#-------------------------------------------------------------#


$Window = [Windows.Markup.XamlReader]::Parse($Xaml)
[xml]$xml = $Xaml
$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }
$Bdem.Add_click({Fdem $this $_})
$BConsult.Add_click({FConsult $this $_})
$BForm.Add_click({FForm $this $_})

[void]$Window.ShowDialog()