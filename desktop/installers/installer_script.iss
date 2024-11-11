[Setup]
AppName=Indoor Tracking App
AppVersion=1.0
DefaultDirName={pf}\IndoorTrackingApp
DefaultGroupName=IndoorTrackingApp
OutputDir=Output
OutputBaseFilename=IndoorTrackingInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Indoor Tracking App"; Filename: "{app}\IndoorTrackingApp.exe"
Name: "{commondesktop}\Indoor Tracking App"; Filename: "{app}\IndoorTrackingApp.exe"

[Run]
Filename: "{app}\IndoorTrackingApp.exe"; Description: "Run Indoor Tracking App"; Flags: nowait postinstall skipifsilent