<#
.SYNOPSIS
    Check folder permissions
.DESCRIPTION
    Check folder permisions with a GUI. Enter the path for permissions check and show the permissions
    in a data grid.
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
#>
function Sync-GridView {
    $path = $objTextBox1.Text
    $AllFolders = Get-ChildItem -Directory -Path $path -Recurse -Force
    $Results = @()
    Foreach ($Folder in $AllFolders) {
        $Acl = Get-Acl -Path $Folder.FullName
        foreach ($Access in $acl.Access) {
            if ($Access.IdentityReference -notlike "BUILTIN\Administrators" -and $Access.IdentityReference -notlike "domain\Domain Admins" -and $Access.IdentityReference -notlike "CREATOR OWNER" -and $access.IdentityReference -notlike "NT AUTHORITY\SYSTEM") {
                $Properties = [ordered]@{'FolderName'=$Folder.FullName;'ADGroup'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
                $Results += New-Object -TypeName PSObject -Property $Properties
            }
        }
    }
        $Array = New-Object System.Collections.ArrayList
        # $Data = Select-JoinCardSetAndRestoran
        $Array.AddRange( ($Results | Select-Object FolderName, ADGroup, Permissions, Inherited))
        $dataGridView.DataSource = $Null
        $dataGridView.AutoGenerateColumns = $True
        $dataGridView.DataSource = $Array
        $dataGridView.Refresh
}

    $SyncData = {
        Sync-GridView
    }

function Show-Form {

    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 

    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="Provjera dozvola" 
    $MyForm.Size = New-Object System.Drawing.Size(1280,1024)
    $MyForm.BackColor = "White" 

    $objTextBox1 = New-Object System.Windows.Forms.TextBox 
    $objTextBox1.Multiline = $True;
    $objTextBox1.Location = New-Object System.Drawing.Size(150,10) 
    $objTextBox1.Size = New-Object System.Drawing.Size(700,60)
    $objTextBox1.Font = 'Microsoft Sans Serif,18'


    $dataGridView = New-Object System.Windows.Forms.DataGridView
    $dataGridView.RowTemplate.DefaultCellStyle.ForeColor = "Blue"
    $dataGridView.Font = 'Microsoft Sans Serif,13'
    $dataGridView.Name = 'dataGridView'
    $dataGridView.DataBindings.DefaultDataSourceUpdateMode = 0
    $dataGridView.ReadOnly = $True
    $dataGridView.AllowUserToDeleteRows = $False
    $dataGridView.RowHeadersVisible = $False
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 1250
    $System_Drawing_Size.Height = 600
    $dataGridView.Size = $System_Drawing_Size
    $dataGridView.TabIndex = 8
    $dataGridView.Anchor = 15
    $dataGridView.AutoSizeColumnsMode = 16
    $dataGridView.AllowUserToAddRows = $False
    $dataGridView.ColumnHeadersHeightSizeMode = 2
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 10
    $System_Drawing_Point.Y = 300
    $dataGridView.Location = $System_Drawing_Point
    $dataGridView.AllowUserToOrderColumns = $True
    $dataGridView.AutoResizeColumns()
    $DataGridViewAutoSizeColumnsMode.AllCells

    $MyForm.Controls.Add($dataGridView)

    $Refresh_button = New-Object System.Windows.Forms.Button
    $Refresh_button.UseVisualStyleBackColor = $True
    $Refresh_button.Text = 'Sync dozvole'
    $Refresh_button.DataBindings.DefaultDataSourceUpdateMode = 0
    $Refresh_button.TabIndex = 1
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 100
    $System_Drawing_Size.Height = 60
    $Refresh_button.Size = $System_Drawing_Size
    $Refresh_button.location = New-Object System.Drawing.Point(10, 10)
    $Refresh_button.add_Click($SyncData)

    $MyForm.Controls.Add($Refresh_button)
        # Sync button action

    $MyForm.Controls.Add($objTextBox1)
    $MyForm.ShowDialog()
}

Show-Form
