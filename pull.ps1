#
# Script.ps1
#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="MainWindow" Height="421" Width="379">
    <Grid>
        <Label Content="Numero de la demande" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <Label Content="Materiel " HorizontalAlignment="Left" Margin="10,59,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <TextBox Margin="10,85,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" HorizontalAlignment="Left" Width="120" ClipToBounds="True" Name="TMat"/>
        <Label Content="Num Serie" HorizontalAlignment="Left" Margin="10,108,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <TextBox HorizontalAlignment="Left" Margin="10,134,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="120" ClipToBounds="True" Name="TSerial"/>
        <Label Content="Client" HorizontalAlignment="Left" Margin="10,157,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <TextBox HorizontalAlignment="Left" Margin="10,183,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="120" ClipToBounds="True" Name="TClient"/>
        <TextBlock HorizontalAlignment="Left" Margin="14,36,0,0" TextWrapping="Wrap" Text="TextBlock" VerticalAlignment="Top" Width="116" ClipToBounds="True"/>
        <Label Content="Descriptif de la panne" HorizontalAlignment="Left" Margin="10,206,0,0" VerticalAlignment="Top" ClipToBounds="True"/>
        <TextBox HorizontalAlignment="Left" Margin="10,232,0,0" TextWrapping="Wrap" Text="TextBox" Width="359" Height="83" VerticalAlignment="Top" ClipToBounds="True" Name="TCom"/>
        <Button Content="Creer la demande" HorizontalAlignment="Left" Margin="10,355,0,0" Width="125" Height="20" VerticalAlignment="Top" ClipToBounds="True" Name="BOk"/>
        <Button Content="Annuler la demande" HorizontalAlignment="Left" Margin="234,355,0,0" Width="125" Height="20" VerticalAlignment="Top" ClipToBounds="True" Name="BCancel"/>
    </Grid>
</Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#

function FOk(){
$Etat="OUVERT"
$Materiel=$TMat.Text
$Serial=$TSerial.Text
$Client=$TClient.Text
$Date= Get-Date -Format yyyy/MM/dd
#REQUETE SQL
$sQuery = "INSERT INTO `DEMANDES` (`Num`, `MATERIEL`, `CLIENT`, `DATE`, `SERIAL`, `ETAT`) VALUES (NULL, '$Materiel', '$Client', '$Date', '$Serial', '$Etat')"
Write-host "Vous allez envoyer dans la base les infos suivantes :" "$Materiel", "$Serial", "$Date", "$Etat", "SOUHAITEZ VOUS CONTINUER ? (y)/(n)"
if($continue=1){Invoke-MySqlQuery -Query $sQuery -Connection $sConnectionString}
else {}
}

function FCancel(){
Write-Host "Test Cancel"}
#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }

$BCancel.IsEnabled = $true

$BOk.Add_Click({FOk $this $_})
$BCancel.Add_Click({FCancel $this $_})

$Config = Get-Content 'config.ini' | ConvertFrom-StringData
$sMySQLHost=$Config.Server
$sMySQLUserName=$Config.User
$sMySQLPW=$Config.Password
$sMySQLDB=$Config.DB
#CHAINE DE CONNEXION A LA BASE
$sConnectionString = "server="+$sMySQLHost+";port=3306;uid=" + $sMySQLUserName + ";pwd=" + $sMySQLPW + ";database="+$sMySQLDB

[void]$Window.ShowDialog()
