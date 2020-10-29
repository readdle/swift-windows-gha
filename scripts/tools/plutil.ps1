Param(
    [Parameter(Mandatory=$true)][ValidateSet('insert')][String]$Action,
    [Parameter(Mandatory=$true)][String]$KeyPath,
    [Parameter(Mandatory=$true)][ValidateSet('xml')][String]$Type,
    [Parameter(Mandatory=$true)][String]$Value,
    [Parameter(Mandatory=$true)][String]$File
)

if (Test-Path $File -PathType Leaf) {
    Write-Output "Reading $File"
    [xml]$PlistDoc = Get-Content $File -Raw
} else {
    Write-Output "Creating new plist"
    $PlistDoc = New-Object System.Xml.XmlDocument
    $Local:XmlDeclaration = $PlistDoc.CreateXmlDeclaration("1.0", "UTF-8", $null)
    $Local:DocType = $PlistDoc.CreateDocumentType("plist", "-//Apple//DTD PLIST 1.0//EN", "http://www.apple.com/DTDs/PropertyList-1.0.dtd", $null)
    $Local:PlistElement = $PlistDoc.CreateElement("plist")
    $Local:PlistElement.version = "1.0"
    $Local:DictElement = $PlistDoc.CreateElement("dict")

    $PlistDoc.AppendChild($Local:XmlDeclaration) | Out-Null
    $PlistDoc.AppendChild($Local:DocType) | Out-Null
    $PlistDoc.AppendChild($Local:PlistElement) | Out-Null
    $Local:PlistElement.AppendChild($Local:DictElement) | Out-Null
}

if ($Action -eq "insert") {
    Write-Output "Inserting $KeyPath with $Type value ""$Value"""
    $Local:DictNode = $PlistDoc.SelectSingleNode("/plist/dict")

    $Local:KeyElement = $PlistDoc.CreateElement("key")
    $Local:KeyElement.InnerText = $KeyPath

    $Local:XmlValue = [xml]$Value
    $Local:ValueNode = $PlistDoc.ImportNode($Local:XmlValue.FirstChild, $true)
    
    $Local:DictNode.AppendChild($Local:KeyElement) | Out-Null
    $Local:DictNode.AppendChild($Local:ValueNode) | Out-Null
} else {
    Write-Error "Unknown action: $Action"
    exit 1
}

Write-Output "Saving $File"
$PlistDoc.Save($File)

Write-Output "Done"